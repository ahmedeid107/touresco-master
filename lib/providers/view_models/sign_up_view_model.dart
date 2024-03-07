import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:touresco/Interfaces/i_auth.dart';
import 'package:touresco/Interfaces/i_meta_data.dart';
import 'package:touresco/models/car_size_model.dart';
import 'package:touresco/models/car_type_model.dart';
import 'package:touresco/models/office_model.dart';
import 'package:touresco/models/user_model.dart';
import 'package:touresco/screens/sheets/select_office_sheet.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpViewModel with ChangeNotifier {
  final IAuth authService;
  final IMetaData metaDataService;
  SignUpViewModel({required this.authService, required this.metaDataService});

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  get formState => _formState;
  Future<List<CarSizeModel>> getAllCarSizes(String id) async {
    return await ServiceCollector.getInstance().authService.getAllSize(id);
  }
  String _carType = ServiceCollector.getInstance().currentLanguage == 'en'
      ? 'Select Car Type'
      : 'اختر نوع المركبة';
  String get carType => _carType;
  set carType(value) {
    _carType = value;
    notifyListeners();
  }

  List<CarTypeModel> _carTypes = [];
  UnmodifiableListView get carTypes {
    List<String> ret = [
      ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Select Car Type'
          : 'اختر نوع المركبة'
    ];
    String lang = ServiceCollector.getInstance().currentLanguage;
    _carTypes.forEach(((element) {
      if (lang == 'en') {
        ret.add(element.carTypeEn);
      } else {
        ret.add(element.carTypeAr);
      }
    }));
    return UnmodifiableListView(ret);
  }

  bool isLoadingCarTypes = false;

  String _carSize = ServiceCollector.getInstance().currentLanguage == 'en'
      ? 'Select Car Size'
      : 'اختر عدد الركاب';
  String get carSize => _carSize;
  set carSize(value) {
    _carSize = value;
    notifyListeners();
  }

  List<CarSizeModel> _carSizes = [];
  UnmodifiableListView get carSizes {
    List<String> ret = [
      ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Select Car Size'
          : 'اختر عدد الركاب'
    ];

    String lang = ServiceCollector.getInstance().currentLanguage;

    for (var element in _carSizes) {
      if (lang == 'en') {
        ret.add(element.carSeatEnglish);
      } else {
        ret.add(element.carSeatArabic);
      }
    }

    return UnmodifiableListView(ret);
  }

  bool isLoadingCarSizes = false;

  // ignore: prefer_final_fields
  Map<String, dynamic> _formData = {'policy': false, 'office': null};
  Map<String, dynamic> get formData => _formData;
  set fullName(final String? value) => _formData['fullName'] = value;
  set email(final String? value) => _formData['email'] = value;
  set password(final String? value) => _formData['password'] = value;
  set phone(value) => _formData['phone'] = value;
  set phone2(value) => _formData['phone2'] = value;
  set cardId(final String value) => _formData['cardId'] = value;
  set driverId(final String? value) => _formData['driverId'] = value;
  set licenseDate(final DateTime? value) {
    _formData['licenseDate'] = value;
    notifyListeners();
  }

  set carNumber(final String value) => _formData['carNumber'] = value;
  set carTypeId(value) => _formData['carTypeId'] = value;
  set carSizeId(value) => _formData['carSizeId'] = value;
  set office(final OfficeModel value) => _formData['office'] = value;

  set policy(value) {
    _formData['policy'] = value;
    notifyListeners();
  }

  String get officeName {
    if (_formData['office'] == null) {
      return ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Not Selected'
          : 'غير محدد';
    }
    return (_formData['office'] as OfficeModel).officeNameEn;
  }

  DateTime? get licenseDate => _formData['licenseDate'];

  bool get policy => _formData['policy'];

  bool _isActivatingOwnerDashboard = false;
  bool get isActivatingOwnerDashboard => _isActivatingOwnerDashboard;
  set isActivatingOwnerDashboard(value) {
    _isActivatingOwnerDashboard = value;
    notifyListeners();
  }

  String tempEmail = '';

  Future checkIfUserEmailNotExistingAsOwner(BuildContext context) async {
    if (isActivatingOwnerDashboard) {
      isActivatingOwnerDashboard = false;
      return;
    }

    if (tempEmail == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'You have to enter your email first'
              : 'يجب عليك ادخال البريد الالكتروني اولا')));
      return;
    }

    try {
      isActivatingOwnerDashboard =
          await authService.checkIfDriverCanUserEmailAsOwner(tempEmail);

      if (isActivatingOwnerDashboard) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
                ? 'You have activate business owner dashboard option'
                : 'لقد قمت بتفعيل خيار لوحة تحكم كصاحب عمل')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
                ? 'This email is already registered before as business owner'
                : 'هذا البريد الالكتروني مسجل مسبقا كصاحب عمل')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Something wrong, please try again later'
              : 'حدث خطا ما، يرجى المحاولة مرة اخرى')));
    }
  }

  void syncAndFetchCarTypes() async {
    if (isLoadingCarTypes) {
      return;
    } else {
      isLoadingCarTypes = true;
      notifyListeners();
    }
    _carTypes = await metaDataService.getAllCarType();
    isLoadingCarTypes = false;

    notifyListeners();
  }

  void syncAndFetchCarSizes() async {
    if (isLoadingCarSizes) {
      return;
    } else {
      isLoadingCarSizes = true;
      notifyListeners();
    }
    _carSizes = await metaDataService.getAllCarSize();
    isLoadingCarSizes = false;
    notifyListeners();
  }

  String? getCarTypesId(String name) {
    String lang = ServiceCollector.getInstance().currentLanguage;

    if (!_carTypes.any((element) {
      if (lang == 'en') {
        return element.carTypeEn == name;
      } else {
        return element.carTypeAr == name;
      }
    })) return null;
    return _carTypes.firstWhere((element) {
      if (lang == 'en') {
        return element.carTypeEn == name;
      } else {
        return element.carTypeAr == name;
      }
    }).id;
  }

  String? getCarSizeId(String name) {
    String lang = ServiceCollector.getInstance().currentLanguage;

    if (!_carSizes.any((element) {
      if (lang == 'en') {
        return element.carSeatEnglish == name;
      } else {
        return element.carSeatArabic == name;
      }
    })) {
      return null;
    }
    return _carSizes.firstWhere((element) {
      if (lang == 'en') {
        return element.carSeatEnglish == name;
      } else {
        return element.carSeatArabic == name;
      }
    }).id;
  }

  bool _isPasswordVisible = true;
  bool get isPasswordVisible => _isPasswordVisible;
  set isPasswordVisible(value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  bool isLoadingSubmit = false;

  var searchController = TextEditingController();
  void showSelectOffieSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return SelectOfficeSheet(
            onCallBack: (value) {
              office = value as OfficeModel;
              notifyListeners();
            },
            search: searchController ,
          );
        });
  }

  void submitForm(BuildContext context , String sizeId,String typeID) async {
    if (_formState.currentState!.validate()) {
       if (_formData['licenseDate'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('End Liscense Date is required')));
        return;
      }

//Checking Car type is Selected


      //Checking Car Size is Selected


      //Checking if Office is Selected
      /*  if (_formData['office'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You have to select office')));
        return;
      }*/

//Checking Privacy Policy
      if (_formData['policy'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('You have to agree to our privacy policy to continue')));
        return;
      }
      if (_formData['phone2'] == null) _formData['phone2'] = '';

      _formState.currentState!.save();

      final user = UserModel(
        id: '',
        fullName: _formData['fullName'],
        email: _formData['email'],
        phone: _formData['phone'],
        carTypeId: carType,
        imgUrl: null ,
        carSizeId: carSize,
        phone2: _formData['phone2'],
        carLicenseNumber: _formData['cardId'],
        officeId: _formData['office'] == null
            ? ''
            : (_formData['office'] as OfficeModel).id,
        carNumber: _formData['carNumber'],
        carLisenseId: _formData['driverId'],
        liscenseDate: _formData['licenseDate'],
        userType: UserType.drivder,
        status: '',
      );

      user.password = _formData['password'];

      isLoadingSubmit = true;
      notifyListeners();

      try {
        await authService.signUp(user, isActivatingOwnerDashboard);
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      } finally {
        isLoadingSubmit = false;
        notifyListeners();
      }
    }
  }

  void showPrivacyPolicy() async {
    String url = 'https://touresco.net/privacy-policy/';
    final parsed = Uri.parse(url);

    if (await canLaunchUrl(parsed)) {
      if (Platform.isAndroid) {
        //In Android pdf should open inside pdfviewer
        await launchUrl(parsed,
            mode: LaunchMode
                .inAppWebView); //To show pdf file using external application in phone that support .pdf
      } else if (Platform.isIOS) {
        await launchUrl(parsed);
      }
    }
  }
}
