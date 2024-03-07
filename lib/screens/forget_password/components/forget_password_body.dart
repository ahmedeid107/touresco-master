import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/forget_password_view_model.dart';
import 'package:touresco/screens/forget_password/components/forget_password_completed.dart';

import 'package:touresco/screens/forget_password/components/forget_password_form.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(            physics: const BouncingScrollPhysics(),

        child: Consumer<ForgetPasswordViewModel>(
          builder: (context, vm, child) {
            if (vm.currentTap == ForgetPasswordTap.waitingUserToEnterEmail) {
              return const ForgetPasswordForm();
            } else if (vm.currentTap == ForgetPasswordTap.emailSent) {
              return const ForgetPasswordCompleted();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
