import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/providers/view_models/forget_password_view_model.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Consumer<ForgetPasswordViewModel>(
      builder: (context, vm, child) {
        return Form(
          key: vm.formState,
          child: Column(
            children: [
              SizedBox(
                height: ScreenConfig.getYByPercentScreen(0.07),
              ),
              SizedBox(
                height: 200,
                child: Lottie.asset(
                    'assets/animations/lottie_forgetPassword.json',
                    repeat: false),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  lang!.enterTheEmailAddress,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenConfig.getFontDynamic(18)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  lang.weWillEmailYou,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kLightGreyColor,
                      fontSize: ScreenConfig.getFontDynamic(16)),
                ),
              ),
              SizedBox(
                height: ScreenConfig.getYByPercentScreen(0.07),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildEmailUserNameField(vm, lang)),
              SizedBox(
                height: ScreenConfig.getYByPercentScreen(0.07),
              ),
              vm.isLoading
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DefaultButton(
                          buttonWidth: double.infinity,
                          buttonText: lang.send,
                          onpressed: () {
                            vm.retrieveAccountPassword( ).then((value) {
                              if(value!=null){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                              }

                            });

                          }),
                    )
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmailUserNameField(
      ForgetPasswordViewModel vm, AppLocalizations lang) {
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
          onSaved: (value) {
            vm.email = value!;
          },
          validator: (value) {
            if (value!.isEmpty) return 'Email is empty';
            bool isEmailValid = RegExp(emailRegex).hasMatch(value);
            if (!isEmailValid) return 'Email format is wrong';
            return null;
          },
          decoration: InputDecoration(
              labelText: lang.email,
              labelStyle: const TextStyle(color: kPrimaryColor),
              suffixIcon: const Icon(
                Icons.person,
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
                  borderSide: const BorderSide(color: Colors.transparent))),
        ),
      ],
    );
  }
}
