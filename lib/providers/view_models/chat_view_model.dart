import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:touresco/Interfaces/i_chat.dart';
import 'package:touresco/models/meun.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/services/service_collector.dart';
import '../../utils/db_helper.dart';

class ChatViewModel with ChangeNotifier {
  final IChat chatService;
  final String userId;
  final List<String> users;
  final bool isPrivate;
  final bool isOwner;
  final String tripSource; // if exist
  final ChatGroupModel tempGroupData;
  late ChatGroupModel groupData;
  late String tripID;

  ChatViewModel({
    required this.chatService,
    required this.userId,
    required this.users,
    required this.tripSource,
    required this.isOwner,
    required this.isPrivate,
    required this.tempGroupData,
    required this.tripID,
  });

  List<SingleMessageData> _chats = [];
  File? image;
  bool isActive = false;
  bool isPlay = false;
  File? audioRecord;
  double second = 0;
  var mini = 0;
  IconData playIcon = Icons.play_arrow_outlined;
  AudioPlayer player = AudioPlayer();
  double value = 0.0;
  double maxValue = 0.0;
  var duration = const Duration();
  var position = const Duration();
  AnotherAudioRecorder? audioRecorder;

  bool _isRecorderInitialized = false;
  IconData icon = Icons.mic;
  Map<String, bool> voicesState = {};
  Map<String, Duration> voicesPosition = {};
  Map<String, AudioPlayer> voicesPlayers = {};
  Map<String, bool> voicesPlayersIsComplete = {};

  List<SingleMessageData> get chats => [..._chats];

  set chats(final List<SingleMessageData> value) {
    _chats.addAll(value);
  }

  List<MenuItemASD> menuItems = [
    MenuItemASD(
      id: 'leave',
      text: ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Leave'
          : 'مغادرة',
      isEnabled: true,
    ),
  ];

  getImage(bool isCamera, context) async {
    Permission.camera.request();
    if (audioRecord != null) {
      deletePath(audioRecord!.path);
      removeFile();
    }
    var permissionCamera = await Permission.camera.request().isGranted;
    if (isCamera && permissionCamera) {
      XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      if (file != null) {
        image = File(file.path);
        Navigator.pop(context);
        notifyListeners();
      }
    } else {
      XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      print("ASDSAD PATH + ${file!.path}");
      image = File(file.path);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  deleteImage() {
    image = null;
    notifyListeners();
  }

  Future syncGroupData() async {
    // ChatsHelper().deleteMessage();
    if (isPrivate) {
      groupData = await chatService.createGroup(
          users[1], users, 'PRIVATECHAT', isPrivate);
    } else {
      groupData = tempGroupData;
    } // Syncing group Data when chat between (multi drivers)

    List<SingleMessageData> messages = await ChatsHelper()
        .getAllMessagesWithId(tripId: groupData.groupId, isPrivate: isPrivate);
    _chats = messages;
    if (messages.isEmpty) {
      _chats = await chatService.syncMessages(
        userId,
        isPrivate ? tripID : groupData.groupId,
        messages.isNotEmpty ? messages.last.id : '',
        tripSource,
        isPrivate,
      );
    }
    var ms = await syncMessages();
    chats.addAll(ms ?? []);
    // syncMessages();
    // chats = await syncMessages() ?? [];
  }

  Stream<List<SingleMessageData>?> chatStream() =>
      Stream<List<SingleMessageData>?>.periodic(const Duration(seconds: 1))
          .asyncMap(
        (event) => syncMessages(),
      );

// syncing message with db
  Future<List<SingleMessageData>?> syncMessages() async {
    var newListFromSer = await chatService.syncMessages(
      userId,
      groupData.groupId,
      _chats.isEmpty ? '' : _chats.last.id,
      tripSource,
      isPrivate,
    );
    print("ASDASDSAASDASDSAD " + newListFromSer.length.toString());

    newListFromSer.forEach((element) async {
      if (chats.contains((ele) => element.id == ele.id)) {
        newListFromSer.remove(element);
      }
    });

    return newListFromSer;
  }

  //typeJson
  void sendMessage(String text) async {
    try {
      File? file;
      if (audioRecord != null || image != null) {
        text = "";
      }
      bool? isImage = audioRecord == null;
      file = audioRecord ?? image;
      var type = file != null
          ? isImage
              ? "3"
              : "2"
          : "1";

      var duration = this.duration;
      var message = SingleMessageData(
        id: _chats.isEmpty ? '' : (int.parse(_chats.last.id) + 1).toString(),
        senderName: 'Name',
        message: text,
        type: type,
        sented: false,
        audioUrl: null,
        sendDate: DateTime.now().toString(),
        senderId: userId,
        duration: duration.toString().contains(".")
            ? duration.toString().split(".")[0].split(":")[2]
            : duration.inSeconds.toString(),
        imageUrl: null,
        tripID: tripID,
        isPrivate: isPrivate,
        tripSource: tripSource,
      );

      message.status = MessageStatus.pending;

      var uList;
      if (file != null) {
        uList = await imageToBytesFromCamera(file);
        if (isImage == true) {
          deleteImage();
        }
        if (isImage == false) {
          removeFile();
        }
      }
      _chats.add(message);
      notifyListeners();
      final msgData = await chatService.sendMessage(
        isOwner: isOwner,
        groupId: groupData.groupId,
        senderId: userId,
        message: message.message,
        file: file,
        type: type,
        isImage: isImage,
        path: file?.path ?? "",
        isPrivate: isPrivate,
        duration: duration.toString().contains(".")
            ? duration.toString().split(".")[0].split(":")[2]
            : duration.inSeconds.toString(),
      );
      MessageStatus newStatus = msgData['status'];
      _chats[_chats.indexOf(message)].status = newStatus;

      String msgId = msgData['msgId'];
      _chats[_chats.indexOf(message)].id = msgId;

      if (isImage == false && text.isEmpty) {
        _chats[_chats.indexOf(message)].audioUrl =
            "https://touresco.net/admin/material-rtl/voice/${msgData['Msg']}";
      }
      if (isImage == true && text.isEmpty) {
        _chats[_chats.indexOf(message)].imageUrl =
            "https://touresco.net/admin/material-rtl/images/images/${msgData['Msg']}";
      }
      // saveMessage(message, uList, file,groupData.groupId);

      if (isImage == false && text.isEmpty) {
        deletePath(file!.path);
      }
      message.sented = true;
      notifyListeners();
    } catch (Ec) {}
  }

  void deleteMessage(BuildContext context, SingleMessageData message) async {
    try {
      bool isDone = await chatService.deleteMessage(message.id);
      if (isDone) {
        _chats[_chats.indexOf(message)].status = MessageStatus.deleted;
        notifyListeners();
        Navigator.of(context).pop();
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future init() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
      Permission.camera
    ].request();

    bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted &&
        permissions[Permission.camera]!.isGranted;
    if (!permissionsGranted) {
      Fluttertoast.showToast(
        msg: "Mic permission and storage not granted",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    String customPath = '/another_audio_recorder_';
    Directory appDocDirectory;
    // io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
    if (Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = (await getExternalStorageDirectory())!;
    }
    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();
    audioRecorder =
        AnotherAudioRecorder(customPath, audioFormat: AudioFormat.WAV);
    _isRecorderInitialized = true;
  }

  Future disp() async {
    audioRecorder = null;
    _isRecorderInitialized = false;
  }

  void playOrStopToggle() async {
    if (!isPlay) {
      player.play(DeviceFileSource(audioRecord!.path));
      playIcon = Icons.stop;
      isPlay = true;
    } else {
      player.stop();
      isPlay = false;
      playIcon = Icons.play_arrow_outlined;
    }
    notifyListeners();
  }

  void positionChange() {
    player.onPositionChanged.listen((event) {
      position = event;
      notifyListeners();
    });
  }

  void onDurationChange() {
    player.onDurationChanged.listen((event) {
      duration = event;
      notifyListeners();
    });
  }

  void seekToSecond(double second) {
    if (isPlay) {
      player.pause();
      player.seek(Duration(milliseconds: (second * 1000).toInt()));

      player.resume();
    } else {
      player.seek(Duration(milliseconds: (second * 1000).toInt()));
    }
    position = Duration(milliseconds: (second * 1000).toInt());
    notifyListeners();
  }

  void onVoiceDurationChange(String key) {
    voicesPlayers[key]!.onPositionChanged.listen((event) {
      voicesPosition[key] = event;
      notifyListeners();
    });
  }

  void onCompleteChange() {
    player.onPlayerComplete.listen((event) {
      isPlay = false;
      playIcon = Icons.play_arrow_outlined;
      notifyListeners();
    });
  }

  void onCompleteVoiceChatChange(String key) {
    voicesPlayers[key]!.onPlayerComplete.listen((event) {
      voicesState[key] = false;
      voicesPlayersIsComplete[key] = true;
      notifyListeners();
    });
    voicesPosition[key] = Duration.zero;
  }

  void removeFile() {
    audioRecord = null;
    duration = const Duration();
    position = const Duration();

    notifyListeners();
  }

  void deletePath(path) {
    File(path).delete();
  }

  bool isRecord = false;

  Future<void> askPermissions(
    Permission requestedPermission,
  ) async {
    PermissionStatus status = await requestedPermission.status;

    if (status != PermissionStatus.granted &&
        status != PermissionStatus.permanentlyDenied) {
      status = await requestedPermission.request();
    }
  }

  Future<void> _showMyDialogStorage(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("permissionToStorage"),
          content: Text("application needs This permission to work properly"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                openAppSettings(),
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        settings: const RouteSettings(
                          name: "/PostLoad",
                        ),
                        builder: (BuildContext context) => Container())),
              },
              child: Text("ok"),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      settings: const RouteSettings(
                        name: "/PsotLoad",
                      ),
                      builder: (BuildContext context) => Container())),
              child: Text("cancel"),
            ),
          ],
        );
      },
    );
  }

  void record(context) async {
    if (image != null) {
      deleteImage();
    }

    //   Map<Permission, PermissionStatus> permissions = await [
    //   Permission.storage,
    //   Permission.microphone,
    //   Permission.camera
    // ].request();
    //
    // bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
    //     permissions[Permission.microphone]!.isGranted  ;
    // var status_storage = await Permission.storage.status;
    //
    // if (status_storage == PermissionStatus.permanentlyDenied || status_storage == PermissionStatus.denied) {
    //   _showMyDialogStorage(context);
    //
    //   }

    value = 0;
    !_isRecorderInitialized ? init() : null;

    try {
      if (isRecord) {
        isRecord = false;
        notifyListeners();
        var path = await audioRecorder!.stop();
        audioRecord = File(path?.path ?? "");
        player.setSourceDeviceFile(path?.path ?? "");

        positionChange();
        onDurationChange();
        onCompleteChange();
        //  maxDuration = await player.getDuration() ;
        icon = isRecord ? Icons.stop : Icons.mic;
        isActive = false;
        notifyListeners();
      } else {
        isRecord = true;
        notifyListeners();

        await audioRecorder!.start();

        icon = isRecord ? Icons.stop : Icons.mic;
        isActive = true;
        notifyListeners();
      }
    } on Exception catch (Excepition) {
      print(Excepition.toString() + " ASDSAD ASD ");
    }
  }

  playChatVoice(
      {required String? url, required String id, String? localPath}) async {
    if (voicesPlayers[id] == null) {
      voicesPlayers[id] = AudioPlayer();
    }

    voicesState.forEach((key, value) {
      if (key != id && value) {
        voicesPlayers[id]!.stop();
        voicesState[key] = false;
        notifyListeners();
      }
    });

    if (voicesState[id] == null) {
      if (localPath != null) {
        voicesPlayers[id]!.play(DeviceFileSource(localPath));
      } else if (url != null) {
        voicesPlayers[id]!.play(UrlSource(url));
      }
      voicesState[id] = true;
      notifyListeners();
      voicesPlayersIsComplete[id] = false;
    }
    if (voicesPlayersIsComplete[id] == true) {
      voicesState[id] = true;

      if (localPath != null) {
        voicesPlayers[id]!.play(DeviceFileSource(localPath));
      } else if (url != null) {
        voicesPlayers[id]!.play(UrlSource(url));
      }
    } else if (voicesState[id] == false) {
      voicesPlayers[id]!.resume();
      voicesState[id] = true;
      notifyListeners();
    } else {
      voicesState[id] = false;
      voicesPlayers[id]!.pause();
      notifyListeners();
    }
    onVoiceDurationChange(id);
    onCompleteVoiceChatChange(id);
  }

  void seekChatVoiceToSecond(double second, String id) {
    if (voicesPlayers[id] == null) {
      voicesPlayers[id] = AudioPlayer();
    }
    if (voicesPosition[id] == null) {
      voicesPosition[id] = Duration(milliseconds: (second * 1000).toInt());
    }
    if (voicesState[id] == true && voicesState[id] != null) {
      voicesPlayers[id]!.pause();
      voicesPlayers[id]!.seek(Duration(milliseconds: (second * 1000).toInt()));
      voicesPlayers[id]!.resume();
    } else {
      voicesPlayers[id]!.seek(Duration(milliseconds: (second * 1000).toInt()));
    }

    voicesPosition[id] = Duration(milliseconds: (second * 1000).toInt());

    notifyListeners();
  }

  String formatTime(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(4, "0");
  }

  Future<int> saveMessage(SingleMessageData message, String? uList,
      File? imageFile, String? groupID) async {
    var a = 0;
    if (message.type == "1") {
      a = await ChatsHelper().saveMessage(message, groupID);
    } else if (message.type == "2") {
      // File file = imageFile!;

      // await file.writeAsBytes(Uint8List.fromList(uList!.codeUnits));
      // message.localPath = file.path;
      // message.audioFile = uList;
      a = await ChatsHelper().saveMessage(message, groupID);
    } else {
      File file = imageFile!;

      await file.writeAsBytes(Uint8List.fromList(uList!.codeUnits));

      message.localPath = file.path;
      message.image = uList;

      a = await ChatsHelper().saveMessage(message, groupID);
    }
    return a;
  }

  Future<String> imageToBytesFromCamera(File file) async {
    Uint8List imagebytes = await file.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes);
    return base64string;
  }
}

class MenuItem {
  String id;
  String text;
  bool isEnabled;

  MenuItem({
    required this.id,
    required this.text,
    required this.isEnabled,
  });
}
