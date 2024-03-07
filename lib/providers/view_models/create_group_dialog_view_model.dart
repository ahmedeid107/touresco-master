import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/models/single_driver_model.dart';
import 'package:touresco/providers/auth_provider.dart';

import 'package:touresco/services/service_collector.dart';

class CreateGroupDialogViewModel with ChangeNotifier {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  Map<String, dynamic> _formData = {
    'groupName': '',
  };

  // ignore: prefer_final_fields
  List<SingleDriverModel> _searchResults = [];
  List<SingleDriverModel> get searchResults => [..._searchResults];
  // ignore: prefer_final_fields
  List<SingleDriverModel> _invitedUsers = [];
  List<SingleDriverModel> get invitedUsers => [..._invitedUsers];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isThereAnyUserInvited = true;

  set groupName(value) => _formData['groupName'] = value;
  String get groupName => _formData['groupName'];

  String get getAllUsersAddedToDisplay {
    if (_invitedUsers.isEmpty) return '';
    String ret = '';

    for (var element in _invitedUsers) {
      ret += '${element.name}, ';
    }

    return ret;
  }

  void searchForDrivers(String name, List<SingleChatUserData> userCanNotJoinToGroup) async
  {
    final data = await ServiceCollector.getInstance().metaDataService.searchByName(name);

    //check if user joined before
    _searchResults.clear();
    for (var element in data) {
      if (!userCanNotJoinToGroup.any((e) => e.userId == element.id)) {
        _searchResults.add(element);
      }
    }

    notifyListeners();
  }

  bool isUserInvited(String id) =>
      _invitedUsers.any((element) => element.id == id);

  void inviteUser(SingleDriverModel user) {
    _invitedUsers.add(user);
    isThereAnyUserInvited = true;

    notifyListeners();
  }

  void deleteUser(SingleDriverModel user) {
    _invitedUsers.remove(user);
    notifyListeners();
  }

  void createGroup(BuildContext context, BuildContext mainContext) async {
    if (formState.currentState!.validate()) {
// check if there is at least one invited user
      if (invitedUsers.isEmpty) {
        isThereAnyUserInvited = false;
        notifyListeners();
        return;
      }
      formState.currentState!.save();

      isLoading = true;
      ChatGroupModel group = await ServiceCollector.getInstance()
          .chatService
          .createGroup(
              Provider.of<AuthProvider>(context, listen: false).user.id,
              List<String>.generate(
                  invitedUsers.length, (index) => invitedUsers[index].id,
                  growable: false),
              _formData['groupName'],
              false);

      Navigator.of(context).pop(group);

      isLoading = false;
    }
  }

  void addMembersToGroup(BuildContext context, String groupId) async {
    try {
      if (invitedUsers.isEmpty) return;

      isLoading = true;
      bool isDone = await ServiceCollector.getInstance()
          .chatService
          .addMembersToGroup(
              groupId,
              Provider.of<AuthProvider>(context, listen: false).user.id,
              List<String>.generate(
                  invitedUsers.length, (index) => invitedUsers[index].id));

      if (isDone) {
        Navigator.of(context).pop('sync');
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      isLoading = false;
    }
  }
}
