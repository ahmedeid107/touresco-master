import 'dart:convert';
import 'dart:io';

import 'package:touresco/Interfaces/i_chat.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/services/app_exception.dart';
import 'package:http/http.dart' as http;

import '../utils/db_helper.dart';
import '../utils/constants.dart';

class SQLChatService implements IChat {
  //This Function in backend will check if group Existed or not, if existed just return group data if not create new group & return it's data
  @override
  Future<ChatGroupModel> createGroup(String userId, List<String> users,
      String groupName, bool isPrivate) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (isPrivate) {
        return ChatGroupModel(
          groupId: userId,
          groupOwnerId: userId,
          countNotSeen: 0,
          users: [],
          groupName: '',
          isPrivate: true,
        );
      } else {
        final url = Uri.parse(mainUrl);
        String members = '$userId,';
        for (var element in users) {
          members += '$element,';
        }
        final res = await http.post(url, body: {
          'Create_Group': '',
          'Group_Name': groupName,
          'User_Id': userId,
          'Members': members,
        });
        print("ADSSADASD AS${res.body}");

        if (res.body.isEmpty) {
          throw AppException(AppExceptionData.unkown);
        }

        final mapData = json.decode(res.body) as Map;

        List<ChatGroupModel> ret = [];

        for (var element in (mapData['Data'] as List)) {
          ret.add(ChatGroupModel.fromJson(element));
        }
        return ret[0];
      }
    } catch (error) {
      print("ADSSADASD AS${error}");
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<List<SingleMessageData>> syncMessages(
      String userId, String groupId, String lastId, String path,
      [bool isPrivate = true]) async {
    final url = Uri.parse(mainUrl);
    try {
      List<SingleMessageData> ret = [];
      if (isPrivate) {
        final res = await http.post(url, body: {
          'Get_Chat': '',
          'User_Id': userId.toString(),
          'Trip_Id': groupId.toString(),
          'Last_Id': lastId.toString(),
        });

        final mapData = json.decode(res.body) as Map;
        for (var element in (mapData['Data'] as List)) {
          print("SAASDASD${element}");
          ret.add(SingleMessageData.fromJson(
              element, groupId.toString(), "", isPrivate));
        }
      } else {
        final res = await http.post(url, body: {
          'Get_Group_Chat': '',
          'Group_Id': groupId,
          'Last_Id': lastId,
          'User_Id': userId,
        });
        print("ASDASD IS PRIVATE FALSE ");
        final mapData = json.decode(res.body) as Map<String, dynamic>;
        print("ASDASDAS D${mapData}");
        for (var element in (mapData['Data'] as List)) {
          ret.add(SingleMessageData.fromJson(
              element, groupId.toString(), "", isPrivate));
        }
      }

      return ret;
    } catch (e) {
      print("ASDASDASDASD ASDASD ${e.toString()}");
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<List<ChatGroupModel>> syncGroups(String userId) async {
    final url = Uri.parse(mainUrl);

    try {
      print(await ChatsHelper().getLastGroupMessages());
      var a = await ChatsHelper().getLastGroupMessages();
      var dd = jsonEncode(a);

      final res = await http.post(
        url,
        body: {
          'Get_Groups': '',
          'User_id': userId,
          "ms": dd,
        },
      );

      final mapData = json.decode(res.body) as Map;

      print("Af sAf s ${dd}");
      List<ChatGroupModel> ret = [];

      for (var element in (mapData['Data'] as List)) {
        ret.add(ChatGroupModel.fromJson(element));
      }
      return ret;
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> addMembersToGroup(
    String groupId,
    String userId,
    List<String> users,
  ) async {
    try {
      final url = Uri.parse(mainUrl);

      String members = '';
      for (var element in users) {
        members += '$element,';
      }

      final res = await http.post(url, body: {
        'Add_Member': '',
        'Group_Id': groupId,
        'User_id': userId,
        'Members': members,
      });

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      if (res.body == '0') {
        throw AppException(AppExceptionData.unkown);
      }

      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<bool> leaveGroup(String groupId, String userId) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url,
          body: {'Leave_Group': '', 'Group_Id': groupId, 'User_Id': userId});

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      bool ret = false;

      ret = res.body == '1' ? true : false;

      if (ret == false) {
        throw AppException(AppExceptionData.unkown);
      }

      return ret;
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<Map<String, dynamic>> sendMessage({
    required String groupId,
    required String senderId,
    required String type,
    File? file,
    bool? isImage,
    required bool isOwner,
    required String message,
    required String duration,
    required String path,
    bool isPrivate = true,
  }) async {
    final url = Uri.parse(mainUrl);
    try {
      print("ASDSADASD ${isOwner} as ss ");
      if (isPrivate) {
        var request = http.MultipartRequest("POST", url);
        request.fields['Post_Chat'] = '';
        request.fields['Trip_Id'] = groupId;
        request.fields['User_Id'] = senderId;
        request.fields['Text'] = message;
        request.fields['Is_Owner'] = isOwner.toString();
        request.fields['Chat_File_Type'] = type;
        request.fields['Chat_Duration'] = duration;
        if (file != null) {
          var pic = await http.MultipartFile.fromPath('data', file.path);
          request.files.add(pic);
        }
        var res = await request.send();

        var responseData = await res.stream.toBytes();

//
        Map<String, dynamic> mapData =
            json.decode(String.fromCharCodes(responseData));
//
        MessageStatus status =
            SingleMessageData.getMessageStatus(mapData['Chat_Status']);
        final String msgId = mapData['chat_id'];
        final String imageUrl = mapData['Msg'];

        if (mapData.isEmpty) {
          throw AppException(AppExceptionData.unkown);
        }
        return {
          'status': status,
          'msgId': msgId,
          'Msg': imageUrl,
        };
      } else {
        var request = http.MultipartRequest("POST", url);
        request.fields['Post_Chat_Group'] = '';
        request.fields['Group_Id'] = groupId;
        request.fields['User_Id'] = senderId;
        request.fields['Text'] = message;
        request.fields['Chat_File_Type'] = type;

        request.fields['Chat_Duration'] = duration;
        if (file != null) {
          var pic = await http.MultipartFile.fromPath('data', file.path);
          request.files.add(pic);
        }
        var res = await request.send();

        var responseData = await res.stream.toBytes();

//
        Map<String, dynamic> mapData =
            json.decode(String.fromCharCodes(responseData));
//
        MessageStatus status =
            SingleMessageData.getMessageStatus(mapData['Chat_Status']);
        final String msgId = mapData['chat_id'];
        final String imageUrl = mapData['Msg'];

        if (mapData.isEmpty) {
          throw AppException(AppExceptionData.unkown);
        }
        return {
          'status': status,
          'msgId': msgId,
          'Msg': imageUrl,
        };
      }
    } catch (error) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<bool> syncEvents(String userId) async {
    // TODO: implement syncEvents
    final url = Uri.parse(mainUrl);
    try {
      final res = await http
          .post(url, body: {'GET_EVENTS_Check': '', 'user_id': userId});

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      Map<String, dynamic> map = jsonDecode(res.body);

      if (map.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }
      print("AAAAAAAAAAAAA ${map}");
      print("AAAAAAAAAAAAA ${map["Flag"].toString() == "true"}");
      return map["Flag"].toString() == "true";
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }
}
