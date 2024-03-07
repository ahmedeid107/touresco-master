import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/update_profile_view_model.dart';
import 'package:touresco/screens/update_profile/components/update_profile_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(lang!.updateProfile),
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: PopScope(
            onPopInvoked: (canPop) async {
              Navigator.pop(context);
            },
            child: ChangeNotifierProvider.value(
              value: UpdateProfileViewModel(),
              child: const UpdateProfileBody(),
            )));
  }
}
