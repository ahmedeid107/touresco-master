import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/view_models/take_role_view_model.dart';

class SliverAppBarMain extends StatelessWidget {
  const SliverAppBarMain({Key? key, required this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return SliverAppBar(
       floating: true,
      pinned: true,
      snap: true,
      automaticallyImplyLeading: false,
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: (){
                String userId = Provider.of<AuthProvider>(context, listen: false).user.id;
                Provider.of<TakeRoleViewModel>(context, listen: false)
                    .syncNotificationProfileNew(userId); Provider.of<TakeRoleViewModel>(context, listen: false)
                    .checkRoleStatus(Provider.of<AuthProvider>(context, listen: false).user.id);

                Navigator.of(context).pop();
                },
              child: const Icon(Icons.dashboard,)),
        )
      ],
      // backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset(
          'assets/images/logo.png',
          width: 37,
          height: 37,
        ),
        Expanded(child: Center(child: Text(lang!.explore))),
        GestureDetector(
          onTap: ()async {
            // Navigator.push(context, MaterialPageRoute(builder: (c){
            //   return MainSrc();
            // }));
          },
          child: const Icon(
            Icons.list_alt,
            color: Colors.transparent,
            size: 0,
          ),
        ),

      ]),
    );
  }

}
