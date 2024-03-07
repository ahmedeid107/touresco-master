
import 'dart:typed_data';

enum MessageStatus {
  none,
  pending,
  hasBeenSent,
  deleted,
}

class ChatGroupModel {
  final String groupId;
  final String groupOwnerId;
  final String groupName;
  final int countNotSeen;
  final List<SingleChatUserData> users;
  final bool isPrivate;

  ChatGroupModel(
      {required this.groupId,
      required this.groupOwnerId,
      required this.groupName,
      required this.countNotSeen,
      required this.users,
      required this.isPrivate});

  ChatGroupModel.fromJson(Map<String, dynamic> json)
      : groupId = json['Group_Id'],
        groupOwnerId = json['Group_Owner_Id'],
        groupName = json['Group_Name'],
        countNotSeen = json['countNotSeen'].toString() =="null" ? 0: int.parse(json['countNotSeen'].toString()),
        users = getUsersFromList(json['Group_Data_Members']),
        isPrivate = false;

  static List<SingleChatUserData> getUsersFromList(List<dynamic> user) {
    List<SingleChatUserData> ret = [];
    for (var element in user) {
      ret.add(SingleChatUserData.fromJson(element));
    }

    return ret;
  }
}

class SingleMessageData {
  String id;
  final String senderId;
  final String senderName;
  final String message;
   String sendDate;
  final String type;
  final String tripID;
  final String tripSource;
  bool sented;
  String? imageUrl;
  String? audioUrl;
  bool isPrivate;
  String? duration;

  MessageStatus status =
      MessageStatus.none; // VARIABLE CONTROLLED BY SENDER ONLY
  String? audioFile;
  String? localPath;
  String? image;

  SingleMessageData({
    required this.id,
    required this.senderName,
    required this.message,
    required this.sendDate,
    required this.imageUrl,
    required this.tripID,
    required this.sented,
    required this.isPrivate,
    required this.senderId,
    required this.tripSource,
    required this.type,
    required this.audioUrl,
    required this.duration,
    this.audioFile,
    this.image,
  });

  SingleMessageData.fromJson(Map<String, dynamic> json , this.tripID, this.tripSource , this.isPrivate)
      : id = json['Chat_Id'],
        senderId = json['Sender_Id'],
        senderName = json['Sender_Name'],
        message = json['Chat_Text'],
        type = json['Chat_type'],
        duration =json['Chat_Duration'].toString(),
        sented = true,
        audioUrl = "https://touresco.net/admin/material-rtl/voice/" +
            json['Chat_Text'],
        imageUrl =
            "https://touresco.net/admin/material-rtl/images/images/" +
                json['Chat_Text'],
        sendDate =  json['Chat_Date_Added'].toString(),
        status = getMessageStatus(json['Chat_Status']);

  static MessageStatus getMessageStatus(String data) {
    if (data == '1') {
      return MessageStatus.hasBeenSent;
    } else {
      return MessageStatus.none;
    }
  }



  SingleMessageData.fromJson3(Map<String, dynamic> json , this.tripID, this.tripSource , this.isPrivate)
      : id = json['id'],
        senderId = json['senderId'],
        senderName = json['senderName'],
        message = json['message'],
        type = json['type'],
        duration =   json['duration'].toString(),
        image =  json['image'] ,
        audioFile =  json['audioFile'] ,
        sented = true,
        audioUrl =json['audioUrl'],
        localPath=json["localPath"],
        imageUrl =json['imageUrl'].toString(),
        sendDate =  json['sendDate'].toString(),
        status = getMessageStatus(json['status'].toString());

  Map<String,dynamic> toJson() {
     return {
        "id": id,
        "senderName": senderName,
        "message": message,
        "sendDate": sendDate,
        "imageUrl": imageUrl,
        "tripID": tripID,
        "status": "status",
        "localPath":localPath,
        "image": image,
        "audioFile": audioFile,
        "tripSource": tripSource,
        "isPrivate": isPrivate,
        "sented": sented,
        "senderId": senderId,
        "type": type,
        "audioUrl": audioUrl,
        "duration": duration
    };
  }
  Map<String,dynamic> toJsonGroup(String groupId) {
     return {
        "id": id,
        "senderName": senderName,
        "message": message,
        "sendDate": sendDate,
        "imageUrl": imageUrl,
        "tripID": tripID,
        "status": "status",
        "localPath":localPath,
        "groupId":groupId,
        "image": image,
        "audioFile": audioFile,
        "tripSource": tripSource,
        "isPrivate": isPrivate,
        "sented": sented,
        "senderId": senderId,
        "type": type,
        "audioUrl": audioUrl,
        "duration": duration
    };
  }
}
Uint8List convertStringToUint8List(String str) {
  final List<int> codeUnits = str.codeUnits;
  final Uint8List unit8List = Uint8List.fromList(codeUnits);

  return unit8List;
}
class SingleChatUserData {
  final String userId;
  final String name;

  SingleChatUserData(this.userId, this.name);

  SingleChatUserData.fromJson(Map<String, dynamic> json)
      : userId = json['Member_User_Id'],
        name = json['Member_User_Name'];
}
