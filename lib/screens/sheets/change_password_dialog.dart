import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/providers/view_models/change_password_dialog_view_model.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ChangeNotifierProvider.value(
      value: ChangePasswordDialogViewModel(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Consumer<ChangePasswordDialogViewModel>(
              builder: (context, vm, child) {
                return Form(
                  key: vm.formState,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          lang!.changePassword,
                          style: textTitle(kNormalTextColor),
                        ),
                        const SizedBox(height: 16),

                        _buildOldPassword(vm, lang),
                        const SizedBox(
                          height: 8,
                        ),
                        _buildNewPassword(vm, lang),
                        const SizedBox(
                          height: 12,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        vm.isLoading
                            ? const CircularProgressIndicator()
                            : DefaultButton(
                                buttonWidth: double.infinity,
                                buttonText: lang.change,
                                onpressed: () {
                                  vm.submit(context);
                                }),
                        const SizedBox(
                          height: 12,
                        ),
                      ]),
                );
              },
            )),
      ),
    );
  }

  Widget _buildOldPassword(
      ChangePasswordDialogViewModel vm, AppLocalizations? lang) {
    return Stack(
      children : [
        Container(
          width: double.infinity,
          height: 49,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 7,
                    offset: const Offset(0, 2))
              ]),
        ),
        TextFormField(
        obscureText: vm.isPasswordVisible,
        cursorColor: kPrimaryColor,
        onSaved: (value) {
          vm.oldPassword = value!;
        },
        validator: (value) {
          //  if (value!.isEmpty) return 'Email is empty';
          // if (value.length < 8) return 'Password is less than 8 character';

          return null;
        },
        decoration: InputDecoration(
            labelText: lang!.oldPassword,
            labelStyle: const TextStyle(color: kPrimaryColor),
            suffixIcon: InkWell(
              onTap: () {
                vm.isPasswordVisible = !vm.isPasswordVisible;
              },
              child: vm.isPasswordVisible
                  ? const Icon(
                      Icons.visibility_off,
                      color: kPrimaryColor,
                    )
                  : const Icon(
                      Icons.visibility,
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
      ], );

  }

  Widget _buildNewPassword(
      ChangePasswordDialogViewModel vm, AppLocalizations? lang) {
    return Stack(
      children : [
      Container(
      width: double.infinity,
      height: 49,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 7,
                offset: const Offset(0, 2))
          ]),
    ),TextFormField(
      obscureText: vm.isPasswordVisible,
      cursorColor: kPrimaryColor,
      onSaved: (value) {
        vm.newPassword = value!;
      },
      validator: (value) {
        if (value!.isEmpty) return 'Email is empty';
        if (value.length < 8) return 'Password is less than 8 character';

        return null;
      },
      decoration: InputDecoration(
          labelText: lang!.newPassword,
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

          labelStyle: const TextStyle(color: kPrimaryColor),
          suffixIcon: InkWell(
            onTap: () {
              vm.isPasswordVisible = !vm.isPasswordVisible;
            },
            child: vm.isPasswordVisible
                ? const Icon(
                    Icons.visibility_off,
                    color: kPrimaryColor,
                  )
                : const Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
          )),
        ),]);
  }
}
