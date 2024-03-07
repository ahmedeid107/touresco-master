import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/screens/groups/groups_screen.dart';

import '../../models/meun.dart';
import '../../models/chat_group_model.dart';

import '../../providers/auth_provider.dart';
import '../../providers/view_models/chat_view_model.dart';
import '../../providers/view_models/groups_view_model.dart';
import '../../services/service_collector.dart';
import 'chatbody2.dart';

class GroupScreenChat extends StatelessWidget {
  const GroupScreenChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String userId = routeData['userId'];
    String officeId = routeData['officeId'];
    String title = routeData['title'];
    bool isPrivate = routeData['isPrivate'];
    String tripSource = routeData['tripSource'];
    ChatGroupModel tempGroupData = routeData['tempGroupData'] ??
        ChatGroupModel(
          groupId: '',
          groupName: '',
          groupOwnerId: '',
          isPrivate: true,
          countNotSeen: 0,
          users: [],
        );

    // build List Users
    List<String> users = isPrivate ? [userId, officeId] : [];
    return ChangeNotifierProvider.value(
      value: ChatViewModel(
          chatService: ServiceCollector.getInstance().chatService,
          userId: userId,
          users: users,
          tripID: officeId,
          isOwner: false,
          tripSource: tripSource,
          isPrivate: isPrivate,
          tempGroupData: isPrivate
              ? ChatGroupModel(
                  groupId: '',
                  groupName: '',
                  groupOwnerId: '',
                  countNotSeen: 0,
                  isPrivate: true,
                  users: [],
                )
              : tempGroupData),
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return GroupsScreen();
                    })).then((value) {
                      Provider.of<GroupsViewModel>(context, listen: false)
                          .syncGroups(
                              Provider.of<AuthProvider>(context, listen: false)
                                  .user
                                  .id);
                    });
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return GroupsScreen();
                  })).then((value) {
                    Provider.of<GroupsViewModel>(context, listen: false)
                        .syncGroups(
                            Provider.of<AuthProvider>(context, listen: false)
                                .user
                                .id);
                  });
                },
                child: ChatBody2(
                    type: '1',
                    groupId: tempGroupData.groupId != ""
                        ? tempGroupData.groupId
                        : null),
              ));
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
