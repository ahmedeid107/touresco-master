import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/providers/view_models/add_expenses_dialog_view_model.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddExpensesDialog extends StatelessWidget {
  const AddExpensesDialog(
      {Key? key,
      required this.tripId,
      required this.driverId,
      required this.tripSource})
      : super(key: key);

  final String tripId;
  final String driverId;
  final String tripSource;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ChangeNotifierProvider.value(
      value: AddExpensesDialogViewModel(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Consumer<AddExpensesDialogViewModel>(
              builder: (context, vm, child) {
                return Form(
                  key: vm.formState,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          lang!.addNewExpenses,
                          style: textTitle(kNormalTextColor),
                        ),
                        _buildAmountField(vm, lang),
                        _buildNoteField(vm, lang),
                        const SizedBox(
                          height: 12,
                        ),
                        _buildPaymentTypeSelector(vm, lang),
                        const SizedBox(
                          height: 12,
                        ),
                        vm.isLoading
                            ? const CircularProgressIndicator()
                            : DefaultButton(
                                buttonWidth: double.infinity,
                                buttonText: lang.addNewExpenses,
                                onpressed: () {
                                  vm.submitExpensedForm(
                                      context, tripId, driverId, tripSource);
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

  Widget _buildNoteField(
      AddExpensesDialogViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 0))
            ]),
      ),
      TextFormField(
        cursorColor: kPrimaryColor,
        onSaved: (value) {
          vm.note = value;
        },
        validator: (value) {
          if (value!.isEmpty) return lang!.fieldIsEmpty;
          return null;
        },
        decoration: InputDecoration(
          labelText: lang!.notenote,
          labelStyle: const TextStyle(color: kPrimaryColor),
          suffixIcon: const Icon(
            Icons.note,
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
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      ),
    ]);
  }

  Widget _buildAmountField(
      AddExpensesDialogViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 0))
            ]),
      ),
      TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
        cursorColor: kPrimaryColor,
        onSaved: (value) {
          vm.amount = double.parse(value!);
        },
        validator: (value) {
          if (value!.isEmpty) return lang!.fieldIsEmpty;
          return null;
        },
        decoration: InputDecoration(
          labelText: lang!.amount,
          labelStyle: const TextStyle(color: kPrimaryColor),
          suffixIcon: const Icon(
            Icons.money,
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
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      )
    ]);
  }

  Padding _buildPaymentTypeSelector(
      AddExpensesDialogViewModel vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
          underline: Container(),

          isExpanded: true,
          value: vm.paymentType,
          items: vm.menuItems,
          onChanged: (value) {
            vm.paymentType = value;
          }),
    );
  }
}
