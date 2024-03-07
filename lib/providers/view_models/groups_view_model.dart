import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/services/service_collector.dart';

class GroupsViewModel with ChangeNotifier {
  final String currentUserId;

  GroupsViewModel({required this.currentUserId});

  int _selectedFilter = 0;

  int get selectedFilter => _selectedFilter;

  set selectedFilter(value) {
    _selectedFilter = value;
    notifyListeners();
  }

  List<ChatGroupModel> _groups = [];

  List<ChatGroupModel> get myGroups =>
      [..._groups.where((element) => element.groupOwnerId == currentUserId)];

  List<ChatGroupModel> get getOtherGroups =>
      [..._groups.where((element) => element.groupOwnerId != currentUserId)];

  List<ChatGroupModel> groupsDependOnFilter() {
    List<ChatGroupModel> list  = [];
    list.addAll(myGroups);
    list.addAll(getOtherGroups);

    return list;

    // if (selectedFilter == 0) {
    //   return myGroups;
    // } else {
    //   return getOtherGroups;
    // }
  }

  Future syncGroups(String userId) async {
    // List<Map<String, int>> map = ChatsHelper().getLastGroupMessages();
    //
    // map.forEach((element) {
    //   if (element["groupId"] == null) {
    //     map.removeWhere((ele) => ele == element);
    //   }
    // });
    // print("ASD ASD ASD ASD $map");
    _groups = await ServiceCollector.getInstance()
        .chatService
        .syncGroups(userId,  );
    notifyListeners();
  }

  void addGroup(final ChatGroupModel value) {
    _groups.add(value);
    notifyListeners();
  }

  void leaveGroup2(String groupId, BuildContext context) async {
    ChatGroupModel groupe =
        _groups.firstWhere((element) => element.groupId == groupId);
    _groups.removeWhere((element) => element.groupId == groupId);
    notifyListeners();
    try {
      bool isDone = await ServiceCollector.getInstance().chatService.leaveGroup(
          groupId, Provider.of<AuthProvider>(context, listen: false).user.id);
      if (isDone) {
      } else {
        _groups.add(groupe);
        notifyListeners();
      }
    } catch (error) {
      _groups.add(groupe);
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void leaveGroup(ChatGroupModel group, BuildContext context) async {
    _groups.remove(group);
    notifyListeners();
    try {
      bool isDone = await ServiceCollector.getInstance().chatService.leaveGroup(
          group.groupId,
          Provider.of<AuthProvider>(context, listen: false).user.id);
      if (isDone) {
      } else {
        _groups.add(group);
        notifyListeners();
      }
    } catch (error) {
      _groups.add(group);
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
