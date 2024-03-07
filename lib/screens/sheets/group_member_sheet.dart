import 'package:flutter/material.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupMemberSheet extends StatelessWidget {
  const GroupMemberSheet(
      {Key? key,
      required this.title,
      required this.drivers,
      required this.ownerId})
      : super(key: key);

  final String title;
  final List<SingleChatUserData> drivers;
  final String ownerId;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: ScreenConfig.getYByPercentScreen(0.4),
          child: Column(children: [
            const SizedBox(height: 12),
            Text(
              title,
              style: textTitle(kPrimaryColor),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            drivers[index].name,
                            style: textTitle(kPrimaryColor),
                          ),
                        ),
                        Text(
                          ownerId == drivers[index].userId
                              ? lang!.owner
                              : lang!.member,
                          style: textTitle(kNormalTextColor),
                        ),
                        const SizedBox(width: 5),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider();
                  },
                  itemCount: drivers.length),
            ),
            const SizedBox(
              height: 12,
            ),
          ]),
        ),
      ),
    );
  }
}
