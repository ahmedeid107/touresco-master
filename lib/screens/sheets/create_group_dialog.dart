import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/models/chat_group_model.dart';

import 'package:touresco/providers/view_models/create_group_dialog_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

class CreateGroupDialog extends StatelessWidget {
  const CreateGroupDialog(
      {Key? key,
      required this.mainContext,
      required this.isAddMemberOnly,
      required this.groupId,
      required this.usersCanNotJoinToGroup})
      : super(key: key);

  final BuildContext mainContext;
  final bool isAddMemberOnly;
  final String groupId;
  final List<SingleChatUserData>
      usersCanNotJoinToGroup; // contain users that joined to groupbefore or blocked users or groupCreator

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ChangeNotifierProvider.value(
      value: CreateGroupDialogViewModel(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Consumer<CreateGroupDialogViewModel>(
              builder: (context, vm, child) {
                return Form(
                  key: vm.formState,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: isAddMemberOnly
                        ? _buildAddingMember(context, vm, lang)
                        : _buildCreateGroup(lang, vm, context),
                  ),
                );
              },
            )),
      ),
    );
  }

  Column _buildCreateGroup(AppLocalizations? lang,
      CreateGroupDialogViewModel vm, BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            lang!.createNewGroup,
            style: textTitle(kNormalTextColor),
          ),
          const SizedBox(height: 16),
          _buildGroupName(vm, lang),
          const SizedBox(
            height: 12,
          ),
          _buildSearchField(vm, lang, usersCanNotJoinToGroup),
          // when create new group groupUsers will be empty
          const SizedBox(
            height: 12,
          ),
           _buildSearchList(vm, lang),
          const SizedBox(
            height: 12,
          ),
          vm.isThereAnyUserInvited
              ? const SizedBox(
                  height: 0,
                )
              : Text(
                  lang.youHaveToInviteUser,
                  style: textTitle(Colors.red)
                      .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                ),
          const SizedBox(
            height: 12,
          ),
          Text(
            vm.getAllUsersAddedToDisplay,
            style: textSubtitle(kLightGreyColor),
          ),
          const SizedBox(
            height: 12,
          ),
          vm.isLoading
              ? const CircularProgressIndicator()
              : DefaultButton(
                  buttonWidth: double.infinity,
                  buttonText: lang.createGroup,
                  onpressed: () {
                    vm.createGroup(context, mainContext);
                  }),
          const SizedBox(
            height: 12,
          ),
        ]);
  }

  Column _buildAddingMember(
    BuildContext context,
    CreateGroupDialogViewModel vm,
    AppLocalizations? lang,
  ) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            lang!.addMembers,
            style: TextStyle(
              color: Colors.black,fontSize: 19,

            ),
          ),
          const SizedBox(height: 16),

          _buildSearchField(vm, lang, usersCanNotJoinToGroup),
          const SizedBox(
            height: 12,
          ),
          _buildSearchList(vm, lang),
          const SizedBox(
            height: 12,
          ),
          vm.isThereAnyUserInvited
              ? const SizedBox(
                  height: 0,
                )
              : Text(
                  lang.youHaveToInviteUser,
                  style: textTitle(Colors.red)
                      .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                ),
          const SizedBox(
            height: 12,
          ),
          vm.isLoading
              ? const CircularProgressIndicator()
              : DefaultButton(
                  buttonWidth: double.infinity,
                  buttonText: lang.add,
                  onpressed: () {
                    vm.addMembersToGroup(mainContext, groupId);
                  }),
          const SizedBox(
            height: 12,
          ),
        ]);
  }

  SizedBox _buildSearchList(
      CreateGroupDialogViewModel vm, AppLocalizations lang) {
    return vm.searchResults.isEmpty
        ? const SizedBox(
            height: 0,
          )
        : SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: vm.searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/img_user.png'),
                  ),
                  title: Text(
                    vm.searchResults[index].name,
                    style: textTitle(kTitleBlackTextColor),
                  ),
                  trailing: vm.isUserInvited(vm.searchResults[index].id)
                      ? GestureDetector(
                          onTap: () {
                            vm.deleteUser(vm.searchResults[index]);
                          },
                          child: Text(
                            lang.delete,
                            style: textTitle(Colors.red),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            vm.inviteUser(vm.searchResults[index]);
                          },
                          child: Text(
                            lang.invite,
                            style: textTitle(kPrimaryColor),
                          ),
                        ),
                );
              },
            ),
          );
  }

  Widget _buildGroupName(
      CreateGroupDialogViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 0))
            ]),
      ),
      TextFormField(
        cursorColor: kPrimaryColor,
        onSaved: (value) {
          vm.groupName = value;
        },
        validator: (value) {
          if (value!.isEmpty) return lang!.fieldIsEmpty;
          return null;
        },
        decoration: InputDecoration(
          labelText: lang!.groupName,
          labelStyle: const TextStyle(color: kPrimaryColor),
          suffixIcon: const Icon(
            Icons.group,
            color: kPrimaryColor,
          ),
          fillColor: Colors.white,
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      )
    ]);
  }

  Widget _buildSearchField(CreateGroupDialogViewModel vm,
      AppLocalizations? lang, List<SingleChatUserData> joinedDrivers) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 49,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 5,
                    offset: Offset(0, 0))
              ]),
        ),
        TextFormField(
          cursorColor: kPrimaryColor,
          onFieldSubmitted: (name) {
            //vm.searchForDrivers(name, joinedDrivers);
          },
          onChanged: (value){
            //if(value.length %2 !=0){
              vm.searchForDrivers(value, joinedDrivers);
            //}
          },
          decoration: InputDecoration(
            labelText: lang!.searchForDriver,
            labelStyle: const TextStyle(color: kPrimaryColor),
            suffixIcon: const Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
            fillColor: Colors.white,
            isDense: true,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
          ),
        ),
      ],
    );
  }
}
