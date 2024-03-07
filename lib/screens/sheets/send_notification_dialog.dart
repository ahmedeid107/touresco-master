import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/providers/view_models/send_notification_dialog_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

class SendNotificationDialog extends StatelessWidget {
  const SendNotificationDialog({Key? key, required this.mainContext})
      : super(key: key);
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ChangeNotifierProvider.value(
      value: SendNotificationDialogViewModel(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Consumer<SendNotificationDialogViewModel>(
              builder: (context, vm, child) {
                return Form(
                  key: vm.formState,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          lang!.sendNotification,
                          style: textTitle(kNormalTextColor),
                        ),
                        _buildNotificationField(vm, lang),
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
                                buttonText: lang.send,
                                onpressed: () {
                                  vm.sendNotification(context, mainContext);
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

  Card _buildNotificationField(
      SendNotificationDialogViewModel vm, AppLocalizations? lang) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextFormField(
          maxLength: 90,
          maxLines: 4,
          cursorColor: kPrimaryColor,
          onSaved: (value) {
            vm.note = value;
          },
          validator: (value) {
            if (value!.isEmpty) return lang!.fieldIsEmpty;

            return null;
          },
          decoration: InputDecoration(
              labelText: lang!.note,
              labelStyle: const TextStyle(color: kPrimaryColor),
              suffixIcon: const Icon(
                Icons.note,
                color: kPrimaryColor,
              )),
        ),
      ),
    );
  }
}
