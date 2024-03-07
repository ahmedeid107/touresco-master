import 'package:flutter/material.dart';
import 'package:touresco/services/service_collector.dart';

enum ForgetPasswordTap {
  waitingUserToEnterEmail,
  emailSent,
}

class ForgetPasswordViewModel with ChangeNotifier {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String email = '';

  ForgetPasswordTap _currentTap = ForgetPasswordTap.waitingUserToEnterEmail;
  ForgetPasswordTap get currentTap => _currentTap;
  set currentTap(value) {
    _currentTap = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> retrieveAccountPassword( ) async {
    if (formState.currentState!.validate()) {
      try {
        formState.currentState!.save();

        isLoading = true;
        bool isDone = await ServiceCollector.getInstance()
            .authService
            .retrieveAccountPassword(email);

        if (isDone) {
          _currentTap = ForgetPasswordTap.emailSent;
        } else {}
      } catch (error) {
         return error.toString();
      } finally {

        isLoading = false;
      }

    }
    return null;
  }
}
