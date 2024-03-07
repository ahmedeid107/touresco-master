import 'package:touresco/services/service_collector.dart';

enum AppExceptionData {
  unkown,
  serverNotRespond,
  emailIsExisted,
  emailOrPasswordIncorrect,
  accountNotExisted,
  canNotTakeTripForThisUser,
  oldPasswordIsNotCorrect,
  accountIsNotActive,
  errorEmailNotExisted,
  errorTheLastDriverNotEndTranslatedTrip,
  errorTripDetailsPage
}

class AppException implements Exception {
  final AppExceptionData exception;

  AppException(this.exception);

  @override
  String toString() {
    return message;
  }

  String get message {
    String lang = ServiceCollector.getInstance().currentLanguage;

    if (exception == AppExceptionData.serverNotRespond) {
      return lang == 'en'
          ? 'Please check network connection'
          : 'يرجى التحقق من الاتصال بالشبكة';
    } else if (exception == AppExceptionData.emailIsExisted) {
      return lang == 'en'
          ? 'Email is already existed'
          : 'هذا البريد الالكتروني مسجل مسبقا';
    } else if (exception == AppExceptionData.emailOrPasswordIncorrect) {
      return lang == 'en'
          ? 'Email or password is incorrect'
          : 'البريد الالكتروني او كلمة المرور المدخلة غير صحيحة';
    } else if (exception == AppExceptionData.accountNotExisted) {
      return lang == 'en' ? 'Account is not existed' : 'الحساب غير موجود';
    } else if (exception == AppExceptionData.canNotTakeTripForThisUser) {
      return lang == 'en'
          ? 'Can\'t agree on this trip at this moment, please try again later'
          : 'لا يمكن الموافقة على هذه الرحلة في الوقت الحالي';
    } else if (exception == AppExceptionData.oldPasswordIsNotCorrect) {
      return lang == 'en'
          ? 'Old password is not correct'
          : 'كلمة المرور القديمة خاطئة';
    } else if (exception == AppExceptionData.accountIsNotActive) {
      return lang == 'en'
          ? 'Your account is not activated, please contact us for more information'
          : 'الحساب غير مفعل ، يرجى التواصل معنا لمزيد من المعلومات';
    } else if (exception == AppExceptionData.errorEmailNotExisted) {
      return lang == 'en'
          ? 'Email is not existed'
          : 'البريد الالكتروني غير موجود';
    } else if (exception ==
        AppExceptionData.errorTheLastDriverNotEndTranslatedTrip) {
      return lang == 'en'
          ? 'You can not end a trip held by another driver'
          : 'لا يمكنك إنهاء الرحلة قيد سائق اخر';
    } else if (exception == AppExceptionData.errorTripDetailsPage) {
      print("SSSSSSSSSSSS ${exception.toString()}");
      return lang == 'en' ? 'Data is unavailable' : 'بيانات الصفحة غير متاحة';
    } else {
      return lang == 'en'
          ? 'An error occur please try again later'
          : 'حدث خطأ ما يرجى المحاولة في وقت اخر';
    }
  }
}
