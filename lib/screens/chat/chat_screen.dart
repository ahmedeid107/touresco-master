import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/providers/view_models/chat_view_model.dart';
import 'package:touresco/screens/chat/components/chat_body.dart';

import 'package:touresco/services/service_collector.dart';
import '../../models/meun.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  String type = "";

  @override
  Widget build(BuildContext context) {

    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String userId = routeData['userId'];
    String officeId = routeData['officeId'];
    String title = routeData['title'];
    bool isPrivate = routeData['isPrivate'];
    bool? isOwner = routeData['isOwner'];
    type = routeData['type'];
    String tripSource = routeData['tripSource'];
    ChatGroupModel tempGroupData = routeData['tempGroupData'] ??
        ChatGroupModel(
            groupId: '',
            groupName: '',
            groupOwnerId: '',
            isPrivate: true,
            countNotSeen:0,
            users: []);

    // build List Users
    List<String> users = isPrivate ? [userId, officeId] : [];
    return ChangeNotifierProvider.value(
      value: ChatViewModel(
        chatService: ServiceCollector.getInstance().chatService,
        userId: userId,
        users: users,
        tripID: officeId,
        tripSource: tripSource,
        isPrivate: isPrivate,
        tempGroupData: isPrivate
            ? ChatGroupModel(
                groupId: '',
                groupName: '',
                groupOwnerId: '',
                isPrivate: true,
                countNotSeen: 0,
                users: [],
              )
            : tempGroupData,
        isOwner: isOwner??false,
      ),
      child: Consumer<ChatViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
              leading: IconButton(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  vm.player.stop();
                  vm.voicesState.forEach((key, value) {
                    vm.voicesPlayers[key]!.stop();
                    vm.voicesState[key] = false;
                  });

                  Navigator.pop(context);
                },
              ),
            ),
            body: PopScope(
              onPopInvoked: (canPop) async {
                vm.player.stop();
                vm.voicesState.forEach((key, value) {
                  vm.voicesPlayers[key]!.stop();
                  vm.voicesState[key] = false;
                });
                Navigator.pop(context);
              },
              child: ChatBody(type: type),
            ),

          );
        },
      ),
    );
  }

  PopupMenuItem<MenuItemASD> buildItem(item) => PopupMenuItem(
        value: item,
        child: Text(item.text),
        enabled: item.isEnabled,
      );
}
