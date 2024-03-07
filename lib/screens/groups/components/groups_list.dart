import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/groups_view_model.dart';
import 'package:touresco/screens/sheets/create_group_dialog.dart';
import 'package:touresco/screens/sheets/group_member_sheet.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/meun.dart';
import '../../../services/service_collector.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({Key? key, required this.groups}) : super(key: key);
  final List<ChatGroupModel> groups;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return groups.isEmpty
        ? SizedBox(
            height: ScreenConfig.getYByPercentScreen(0.7),
            child: Column(children: [
              SizedBox(
                height: ScreenConfig.getYByPercentScreen(0.5),
                width: ScreenConfig.getXByPerecentScreen(0.9),
                child: Lottie.asset('assets/animations/lottie_people.json',
                    repeat: false),
              ),
              Text(
                lang!.thereAreNoGroups,
                style: textTitle(kPrimaryColor),
              ),
            ]),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                        color: Color(0xFF0079fe),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(width: 4,),
                  Text(lang!.myGroups),
                  SizedBox(width: 4,),

                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            color: Color(0xFF003269),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      SizedBox(width: 4,),
                      Text(lang!.otherGroups)
                    ],
                  ),
                ],
              ),


              SizedBox(height: 8,),
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return _buildGroupItem(index, context, lang);
                },
              )
            ],
          );
  }

  Widget _buildGroupItem(
      int index, BuildContext context, AppLocalizations? lang) {
    var langdd = ServiceCollector.getInstance().currentLanguage;

    return Container(
      height: 80,
      width: 80,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/GroupScreenChat', arguments: {
            'userId': Provider.of<AuthProvider>(context, listen: false).user.id,
            'officeId': 'GROUP',
            'title': groups[index].groupName,
            'isPrivate': false,
            'tripSource': '',
            'type': '1',
            'tempGroupData': groups[index]
          }).then((value) {
            if (value != null) {
              if (value == 'userLeaveGroup') {
                //leaving group
                Provider.of<GroupsViewModel>(context, listen: false)
                    .leaveGroup(groups[index], context);
              }
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 8,
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                groups[index].groupOwnerId ==
                        Provider.of<AuthProvider>(context, listen: false)
                            .user
                            .id
                    ? 'assets/images/img_group.png'
                    : "assets/images/asdasd.jpg",
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  groups[index].groupName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: kTitleBlackTextColor,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                groups[index].countNotSeen == 0
                    ? Container()
                    : Container(
                        height: 14,
                        width: 14,
                        alignment: Alignment.center,
                        child: Text(
                          groups[index].countNotSeen.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(55555)),
                      ),
              ],
            ),
            Spacer(),
            PopupMenuButton<MenuItemASD>(
              onSelected: (value) async {
                if (value.id == 'view') {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return GroupMemberSheet(
                          title: lang!.members,
                          drivers: groups[index].users,
                          ownerId: groups[index].groupOwnerId,
                        );
                      });
                } else if (value.id == 'invite') {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return CreateGroupDialog(
                          mainContext: context,
                          isAddMemberOnly: true,
                          groupId: groups[index].groupId,
                          usersCanNotJoinToGroup: groups[index].users,
                        );
                      }).then((value) {
                    if (value != null) {
                      Provider.of<GroupsViewModel>(context, listen: false)
                          .syncGroups(
                              Provider.of<AuthProvider>(context, listen: false)
                                  .user
                                  .id);
                    }
                  });
                } else if (value.id == 'leave') {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (contexat) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      lang!.leaveGroupe,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      lang.sureLeaveGroup,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700]),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            lang.canceltextButton,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          color: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Provider.of<GroupsViewModel>(
                                                    context,
                                                    listen: false)
                                                .leaveGroup(
                                                    groups[index], context);
                                          },
                                          child: Text(
                                            lang.leave,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                  ],
                                )));
                      });
                }
              },
              itemBuilder: (context) => [
                ...<MenuItemASD>[
                  MenuItemASD(
                      id: 'view',
                      text: langdd == 'en' ? 'View members' : 'عرض الاعضاء',
                      isEnabled: true),
                  if (groups[index].groupOwnerId ==
                      Provider.of<AuthProvider>(context, listen: false).user.id)
                    MenuItemASD(
                        id: 'invite',
                        text: langdd == 'en' ? 'Invite' : 'دعوة',
                        isEnabled: true),
                  if (groups[index].groupOwnerId !=
                      Provider.of<AuthProvider>(context, listen: false).user.id)  MenuItemASD(
                      id: 'leave',
                      text: langdd == 'en' ? 'Leave' : 'مغادرة',
                      isEnabled: true),
                ].map((e) => buildItem(e)).toList()
              ],
              child: Container(
                height: ScreenConfig.getRuntimeHeightByRatio(130),
                child: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<MenuItemASD> buildItem(item) => PopupMenuItem(
        value: item,
        child: Text(item.text),
        enabled: item.isEnabled,
      );
}
