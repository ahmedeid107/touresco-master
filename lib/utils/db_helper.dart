import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/chat_group_model.dart';

class ChatsHelper {
  static Database? _database;
  static ChatsHelper? _chatsHelper;

  ChatsHelper._createInstance();

  factory ChatsHelper() {
    if (_chatsHelper == null) {
      _chatsHelper = ChatsHelper._createInstance();
    }
    return _chatsHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "chats10.db";

    var database = await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE Messages(uniqId integer primary key autoincrement,"
            "id integer,"
            "senderId TEXT NOT NULL,"
            "senderName TEXT NOT NULL,"
            "message TEXT ,"
            "sendDate TEXT,"
            "type Text,"
            "sented Integer ,"
            "imageUrl TEXT ,"
            "localPath TEXT ,"
            "audioUrl TEXT ,"
            "groupId TEXT ,"
            "duration TEXT,"
            "status TEXT ,"
            "image TEXT ,"
            "audioFile TEXT,"
            "isPrivate Boolean,"
            "tripSource TEXT ,"
            "tripID TEXT)");
      },
    );
    return database;
  }

  Future<int> saveMessage(
      SingleMessageData singleMessageData, String? groupID) async {
    var db = await database;
    var isExist = await messageIsExist(singleMessageData.id);
    if (!isExist) {
      if (groupID == null || groupID == "") {
        print("SADSADASD sssd ddf ff gh");
        return await db.insert("Messages", singleMessageData.toJson());
      } else {
        print("ASDSDSAD adssadasdads");
        var a =
            await db.insert("Messages", singleMessageData.toJsonGroup(groupID));
        return a;
      }
    } else {
      return Future(() => 0);
    }
  }

  update(List<SingleMessageData> _chats) async {
    var localPath = "";
    _chats.forEach((element) async {
      localPath = "";
      if (element.type == "3" && element.localPath == null) {
        var url = Uri.parse(element.imageUrl!);
        var response = await http.get(url);
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        File file;
        if (!path.basename(url.toString()).contains(".")) {
          file = File(path.join(
              documentDirectory.path, path.basename(url.toString()) + ".jpg"));
        } else {
          file = File(
              path.join(documentDirectory.path, path.basename(url.toString())));
        }
        await file.writeAsBytes(response.bodyBytes);
        localPath = file.path;
        await ImageGallerySaver.saveFile(localPath, isReturnPathOfIOS: true);
      }
    });

    // if(localPaths !=null){
    //
    //   if (type == "5") {
    //     var url = Uri.parse(typeUrl);
    //     var response = await http.get(url);
    //     Directory documentDirectory = await getApplicationDocumentsDirectory();
    //     File file = File(
    //         path.join(documentDirectory.path, path.basename(url.toString())));
    //     await file.writeAsBytes(response.bodyBytes);
    //     localPath = file.path;
    //     var a = await networkImageToBase64(response);
    //     Map<String, dynamic> row = {"localPath": localPath, "audioFile": a};
    //
    //     updateCount =
    //     await db.update("Messages", row, where: 'id = ?', whereArgs: [id]);
    //   }
    //
    //
    //
    // }
  }

  Future<String> upadteImage(
      String id, String? localPath1, String imageUrl) async {
    var localPath = "";

    if (localPath1 == null || localPath1.isEmpty) {
      var url = Uri.parse(imageUrl);
      var response = await http.get(url);
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      File file;
      if (!path.basename(url.toString()).contains(".")) {
        file = File(path.join(
            documentDirectory.path, path.basename(url.toString()) + ".jpg"));
      } else {
        file = File(
            path.join(documentDirectory.path, path.basename(url.toString())));
      }
      await file.writeAsBytes(response.bodyBytes);
      localPath = file.path;
    }
    return localPath;
    //   if(localPaths !=null){
    //   if (type == "5") {
    //     var url = Uri.parse(typeUrl);
    //     var response = await http.get(url);
    //     Directory documentDirectory = await getApplicationDocumentsDirectory();
    //     File file = File(
    //         path.join(documentDirectory.path, path.basename(url.toString())));
    //     await file.writeAsBytes(response.bodyBytes);
    //     localPath = file.path;
    //     var a = await networkImageToBase64(response);
    //     Map<String, dynamic> row = {"localPath": localPath, "audioFile": a};
    //     updateCount =
    //     await db.update("Messages", row, where: 'id = ?', whereArgs: [id]);
    //   }
    // }
  }

  Future<String> updateAudio(
      String id, String? localPath1, String audio, String duration) async {
    var localPath = "";

    if (localPath1 == null || localPath1.isEmpty) {
      var url = Uri.parse(audio);
      var response = await http.get(url);
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      File file;
      if (!path.basename(url.toString()).contains(".")) {
        file = File(path.join(
            documentDirectory.path, path.basename(url.toString()) + ".mp3"));
      } else {
        file = File(
            path.join(documentDirectory.path, path.basename(url.toString())));
      }
      await file.writeAsBytes(response.bodyBytes);
      localPath = file.path;
    }
    return localPath;
    // if(localPaths !=null){
    //
    //   if (type == "5") {
    //     var url = Uri.parse(typeUrl);
    //     var response = await http.get(url);
    //     Directory documentDirectory = await getApplicationDocumentsDirectory();
    //     File file = File(
    //         path.join(documentDirectory.path, path.basename(url.toString())));
    //     await file.writeAsBytes(response.bodyBytes);
    //     localPath = file.path;
    //     var a = await networkImageToBase64(response);
    //     Map<String, dynamic> row = {"localPath": localPath, "audioFile": a};
    //
    //     updateCount =
    //     await db.update("Messages", row, where: 'id = ?', whereArgs: [id]);
    //   }
    // }
  }

  Future<String?> networkImageToBase64(http.Response response) async {
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  Future<bool> messageIsExist(String id) async {
    var db = await database;
    List? count = await db.rawQuery("SELECT * FROM Messages WHERE id=?", [id]);
    return count.isNotEmpty;
  }

  Future<List<SingleMessageData>> getAllMessagesWithId(
      {required String tripId, required bool isPrivate}) async {
    var db = await database;

    if (isPrivate) {
      List? list = await db.rawQuery(
          "SELECT * FROM Messages WHERE tripID=? and isPrivate =?",
          [tripId, isPrivate]);
      List<SingleMessageData> reList = [];

      list.forEach((element) {
        reList.add(SingleMessageData.fromJson3(element, tripId, "", isPrivate));
      });
      return reList;
    } else {
      List? list = await db.rawQuery(
          "SELECT * FROM Messages WHERE groupId=? and isPrivate =?",
          [tripId, isPrivate]);
      List<SingleMessageData> reList = [];

      list.forEach((element) {
        print("ASASD group element ${element.toString()}");
        reList.add(SingleMessageData.fromJson3(element, tripId, "", isPrivate));
      });
      return reList;
    }
  }

  Future<List> getLastGroupMessages() async {
    var db = await database;
    List? map = await db.rawQuery(
        "SELECT MAX(id) , groupId  FROM Messages GROUP BY groupId ORDER BY id DESC");
    return map;
  }

  deleteMessage() async {
    var db = await database;
    db.rawQuery("DELETE FROM Messages");
  }
}
