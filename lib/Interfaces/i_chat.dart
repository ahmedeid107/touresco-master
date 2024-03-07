import 'dart:io';

import 'package:touresco/models/chat_group_model.dart';

abstract class IChat {
  Future<ChatGroupModel> createGroup(
    //this Function Using to create chat room between user and other user
    String userId,
    List<String> users,
    String groupName,
    bool isPrivate,
  );

  Future<List<ChatGroupModel>> syncGroups(String userId  );
  Future<bool> syncEvents( String userId );

  Future<List<SingleMessageData>> syncMessages(
      String userId, String groupId, String lastId, String path,
      [bool isPrivate = true]);

  Future<Map<String, dynamic>> sendMessage(

  {required String groupId, required String senderId,
    required String type,
    required bool isOwner,

    File? file,bool? isImage,required String message,required String duration,required String path,
  bool isPrivate = true,


  });

  Future<bool> deleteMessage(String messageId);

  Future<bool> addMembersToGroup(
      String groupId, String userId, List<String> users);

  Future<bool> leaveGroup(String groupId, String userId);
}
