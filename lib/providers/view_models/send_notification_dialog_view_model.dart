import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/app_exception.dart';
import 'package:touresco/services/service_collector.dart';

class SendNotificationDialogViewModel with ChangeNotifier {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  // ignore: prefer_final_fields
  Map<String, dynamic> _formData = {
    'note': '',
  };

  set note(value) => _formData['note'] = value;

  void sendNotification(BuildContext context, mainContext) async {
    String lang = ServiceCollector.getInstance().currentLanguage;
    try {
      if (formState.currentState!.validate()) {
        formState.currentState!.save();

        isLoading = true;
        bool isDone = await ServiceCollector.getInstance()
            .tripsService
            .sendNotificationToOffice(
              Provider.of<AuthProvider>(context, listen: false).user.id,
              Provider.of<TripDetailsViewModel>(context, listen: false).trip.id,
              _formData['note'],
              Provider.of<TripDetailsViewModel>(context, listen: false)
                  .currentTripSource,
            );
        if (!isDone) {
          throw AppException(AppExceptionData.unkown);
        }

        Navigator.of(context).pop(lang == 'en'
            ? 'Notification has been sent'
            : 'تم ارسال الاشعار بنجاح');
      }
    } catch (error) {
      Navigator.of(context).pop(error.toString());
    } finally {
      isLoading = false;
    }
  }
}
