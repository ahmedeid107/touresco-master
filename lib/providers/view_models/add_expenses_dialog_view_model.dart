// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';

class AddExpensesDialogViewModel with ChangeNotifier {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: '1',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Instant Payment'
            : 'دفع فوري')),
    DropdownMenuItem(
        value: '2',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Pay when paying for the flight'
            : 'دفع عند تسديد الرحلة')),
  ];

  Map<String, dynamic> _formData = {
    'amount': 0.0,
    'note': '',
    'paymentType': '1'
  };

  String? get paymentType => _formData['paymentType'];
  set paymentType(value) {
    _formData['paymentType'] = value;
    notifyListeners();
  }

  set amount(value) => _formData['amount'] = value;
  set note(value) => _formData['note'] = value;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void submitExpensedForm(BuildContext context, String tripId, String driverId,
      String tripSource) async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      isLoading = true;

      try {
        bool isDone = await ServiceCollector.getInstance()
            .expensesService
            .addExpenses(tripId, driverId, _formData['amount'],
                _formData['note'], _formData['paymentType'], tripSource);
        isLoading = false;

        if (isDone) {
          Navigator.of(context).pop();
          await Provider.of<TripDetailsViewModel>(context, listen: false)
              .syncAndFetchTrip(tripId);
        }
      } catch (error) {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }
}
