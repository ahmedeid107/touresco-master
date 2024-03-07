import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/forget_password_view_model.dart';
import 'package:touresco/screens/forget_password/components/forget_password_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(lang!.forgetPasswordTitle)),
      body: ChangeNotifierProvider.value(
          value: ForgetPasswordViewModel(), child: const ForgetPasswordBody()),
    );
  }
}
