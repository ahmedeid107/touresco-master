import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/groups_view_model.dart';
import 'package:touresco/screens/dashbord/dashbord.dart';
import 'package:touresco/screens/groups/components/groups_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/screens/sheets/create_group_dialog.dart';

import '../../providers/view_models/take_role_view_model.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ChangeNotifierProvider.value(
      value: GroupsViewModel(
          currentUserId:
              Provider.of<AuthProvider>(context, listen: false).user.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(lang!.groups),
          leading: InkWell(
            onTap: () {
              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .numOfMessages = 0;

              String userId =
                  Provider.of<AuthProvider>(context, listen: false).user.id;
              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .syncGroupNumber(userId);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (c) {
                return Dashbord();
              }));
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        body: PopScope(
            onPopInvoked: (canPop) async {
              Provider.of<TakeRoleViewModel>(context, listen: false).numOfMessages = 0;
              String userId =
                  Provider.of<AuthProvider>(context, listen: false).user.id;
              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .syncGroupNumber(userId);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (c) {
                return Dashbord();
              }));
            },
            child: const GroupsBody()),
        floatingActionButton: Consumer<GroupsViewModel>(
          builder: (context, vm, child) {
            return vm.selectedFilter == 0
                ? FloatingActionButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return CreateGroupDialog(
                              mainContext: context,
                              isAddMemberOnly: false,
                              groupId: '',
                              usersCanNotJoinToGroup: [
                                SingleChatUserData(
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .user
                                        .id,
                                    ''),
                              ],
                            );
                          }).then((value) {
                        if (value != null) {
                          vm.addGroup(value);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ))
                : Container();
          },
        ),
      ),
    );
  }
}
