import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserDisplay extends StatefulWidget {
  const UserDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDisplay> createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
    final lang = AppLocalizations.of(context);
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Row(children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: ScreenConfig.getFontDynamic(50),
            backgroundColor: Colors.grey.withOpacity(0.2),
            backgroundImage: authProvider.user.imgUrl == null
                ? const AssetImage('assets/images/user_profile.png')
                : NetworkImage(authProvider.user.imgUrl!) as ImageProvider,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${lang!.id}${authProvider.user.id}',
              style: textTitle(kPrimaryColor),
            ),
            Text(
              authProvider.user.fullName,
              style: textTitle(kTitleBlackTextColor)
                  .copyWith(fontSize: ScreenConfig.getFontDynamic(20)),
            ),
            Text(
              authProvider.user.email,
            ),
          ],
        )),
      ]);
    });
  }
}
