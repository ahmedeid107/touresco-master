import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/providers/view_models/sign_in_view_model.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../dashbord/dashbord.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getRuntimeWidthByRatio(20)),
      child: Consumer<SignInViewModel>(
        builder: (context, vm, child) {
          return Form(
            key: vm.formState,
            child: Column(
              children: [
                Stack(
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
                      onEditingComplete: (){
                        FocusScope.of(context).nextFocus();
                      },
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {
                        vm.email = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return lang!.emailIsEmpty;
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang!.email,
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
                            borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenConfig.getYByPercentScreen(0.025)),
                Stack(
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
                                offset: const Offset(0, 0))
                          ]),
                    ),
                    TextFormField(
                      obscureText: vm.isHidingPassword,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {
                        vm.password = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return lang.password;
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang.password,
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            vm.isHidingPassword = !vm.isHidingPassword;
                          },
                          child: Icon(
                            vm.isHidingPassword == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: kPrimaryColor,
                          ),
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
                ),
                 const SizedBox(
                   height: 4,
                 ),
                Container(
                  padding: const EdgeInsets.only(right: 10, top: 5),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/forget_password_screen');
                    },
                    child: Text(
                      lang.forgetPassword,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: vm.isKeeplogged,
                        onChanged: (value) {
                          vm.isKeeplogged = value;
                        },
                    ),
                    Text(lang.keepLogged),
                  ],
                ),
              const SizedBox(
                  height: 4,
                ),
                vm.isLoading
                    ? const CircularProgressIndicator()
                    : DefaultButton(
                    buttonWidth: double.infinity,
                    buttonText: lang.login,
                    onpressed: () {

                      vm.submitForm(context).then((value) {
                        vm.email = "";
                        vm.password = "";

                        if(value){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>Dashbord()));
                        }
                      });
                    }),
              ],
            ),
          );
        },
      ),
    );
  }


}
