
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/car_size_model.dart';
import 'package:touresco/models/car_type_model.dart';
import 'package:touresco/models/office_model.dart';

import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/screens/sheets/select_office_sheet.dart';
import 'package:touresco/services/app_exception.dart';
import 'package:touresco/services/service_collector.dart';

class UpdateProfileViewModel with ChangeNotifier {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  List<CarTypeModel> _carModels = [];
  List<CarTypeModel> get carModels => [..._carModels];

  List<CarSizeModel> _carSizes = [];
  List<CarSizeModel> get carSizes => [..._carSizes];
  File? image;
  get email => _formData['email'];
  get phone => _formData['phone'];
  get imgUrl => _formData['imgUrl'];
  get phone2 => _formData['phone2'];
  get carLisenseId => _formData['carLisenseId'];
  get driverLisenseId => _formData['driverLisenseId'];
  get carNumber => _formData['carNumber'];
  get driverLisenseEndDate => _formData['driverLisenseEndDate'];
  get carType => _formData['selectedCarType'];

  get carSize => _formData['selectedCarSize'];
  get officeId => _formData['selectedOfficeId'];
  Map _formData = {
    'email': '',
    'phone': '',
    'phone2': '',
    'carLisenseId': '',
    'driverLisenseId': '',
    'carNumber': '',
    'driverLisenseEndDate': '',
    'selectedCarType': null,
    'selectedCarSize': null,
    'activateTripOwner': '',
    'selectedOfficeId': null,
    'selectedOfficeNameEn': '',
    'selectedOfficeNameAr': '',
  };

  String _oldSelectedOfficeId = '';

  bool get isOfficeChanged =>
      _formData['selectedOfficeId'] != _oldSelectedOfficeId;

  bool get isDriverRelatedWithOffice =>
      (_formData['selectedOfficeId'] != null &&
          _formData['selectedOfficeId'] != '');

  String _oldActivateTripOwner = '';
  bool get isOwnerStatusChanged =>
      _formData['activateTripOwner'] != _oldActivateTripOwner;


  get endDateAsUserDisplay {
    String date = _formData['driverLisenseEndDate'] as String;
    int year = int.parse(date.split('-')[0]);
    int month = int.parse(date.split('-')[1]);
    int day = int.parse(date.split('-')[2]);
    return DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
        .format(DateTime(year, month, day));
  }
  getImage(bool isCamera, context) async {
    Permission.camera.request();
    var permissionCamera = await Permission.camera.request().isGranted;
    if (isCamera && permissionCamera) {
      XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (file != null) {
        image = File(file.path);
        Navigator.pop(context);
        notifyListeners();
      }
    } else {
      XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100
      );
      if (file != null) {
        image = File(file.path);
        Navigator.pop(context);

        notifyListeners();
      }
    }
  }

   get activateTripOwner => _formData['activateTripOwner'];
  get tripOwnerAsDisplay =>
      _formData['activateTripOwner'] == '0' ? false : true;

  OfficeModel? get getSelectedOffice {
    if (_formData['selectedOfficeId'] == null) return null;

    return OfficeModel(
        id: _formData['selectedOfficeId'],
        officeNameEn: _formData['selectedOfficeNameEn'],
        officeNameAr: _formData['selectedOfficeNameAr'],
    );
  }

  set phone(value) => _formData['phone'] = value;
  set phone2(value) => _formData['phone2'] = value;
  set carLisenseId(value) => _formData['carLisenseId'] = value;
  set driverLisenseId(value) => _formData['driverLisenseId'] = value;
  set carNumber(value) => _formData['carNumber'] = value;
  set driverLisenseEndDate(value) {
    _formData['driverLisenseEndDate'] = value;
    notifyListeners() ;
  }

  set setCarType(value) {
    _formData['selectedCarType'] = value;
     getAllCarSizes(value);
    notifyListeners() ;
  }

  set setCarSize(String value) {
     _formData['selectedCarSize'] = value;
    notifyListeners() ;
    print("ASDASD DDD ${_formData['selectedCarSize']}");
  }





  set setAsOwner(value) {
    if (!value) return;
    if (value == true) {
      _formData['activateTripOwner'] = '1';
    } else {
      _formData['activateTripOwner'] = '0';
    }
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future syncProfileData(String userId , BuildContext context) async {

    // Getting car types
    _carModels =
        await ServiceCollector.getInstance().metaDataService.getAllCarType();

    _formData =
        await ServiceCollector.getInstance().authService.syncUserData(userId);

    Provider.of<AuthProvider>(context, listen: false).user.imgUrl = _formData["Profile_Photo"];

    getAllCarSizes(_formData["selectedCarType"]);

    //set values before update
    _oldSelectedOfficeId = _formData['selectedOfficeId'];
    _oldActivateTripOwner = _formData['activateTripOwner'];
  }

  void submit(BuildContext context) async {
    if (_formData['driverLisenseEndDate'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Driver lisense end date not set'
              : 'يجب عليك تحديد تاريخ انتهاء الرخصة')));
      return;
    }

    if (_formData['selectedCarType'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'You have to select car model'
              : 'يجب عليك تحديد نوع المركبة')));
      return;
    }

    if (_formData['selectedCarSize'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'You have to select car size'
              : 'يجب عليك تحديد سعة المركبة')));
      return;
    }

    if (formState.currentState!.validate()) {
      formState.currentState!.save();

      try {
        isLoading = true;
        bool isDone = false;
        if(image !=null){

          var map = await ServiceCollector.getInstance()
              .authService
              .updateProfileImage(image!, Provider.of<AuthProvider>(context, listen: false).user.id );

          if(map["status"].toString()=="400"){
            Provider.of<AuthProvider>(context, listen: false).user.imgUrl = map["imageUrl"];
            notifyListeners();
          }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
                    ? 'You cannot upload a large image'
                    : 'لا يمكن رفع صورة بحجم كبير')));
          }
        } else if(image == null){
           isDone = await ServiceCollector.getInstance()
              .authService
              .updateUserData(
              Provider.of<AuthProvider>(context, listen: false).user.id,
                _formData,
                isOfficeChanged,
                isOwnerStatusChanged,

           );

          if (!isDone) {
            throw AppException(AppExceptionData.unkown).toString();
          }


        }else{

         var map = await ServiceCollector.getInstance()
              .authService
              .updateProfileImage(image!, Provider.of<AuthProvider>(context, listen: false).user.id );
          if(map["status"].toString()=="400"){
            Provider.of<AuthProvider>(context, listen: false).user.imgUrl = map["imageUrl"];
          }else{
            print("ASSSSSSSSSSSSSSS SS SSS SS");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
                    ? 'You cannot upload a large image'
                    : 'لا يمكن رفع صورة بحجم كبير')));
          }
         notifyListeners();



           isDone = await ServiceCollector.getInstance()
              .authService
              .updateUserData(
              Provider.of<AuthProvider>(context, listen: false).user.id,
              _formData,
              isOfficeChanged,
              isOwnerStatusChanged);

          if (!isDone) {

            throw AppException(AppExceptionData.unkown).toString();
          }


        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
                ? 'Update profile is done'
                : 'تم تحديث الملف الشخصي')));

        if (isDone) {
          _oldSelectedOfficeId = _formData['selectedOfficeId'];
          _oldActivateTripOwner = _formData['activateTripOwner'];
          notifyListeners();
        }
      } finally {
        isLoading = false;
      }
    }


  }

 getAllCarSizes(String id)async{
    _carSizes = await ServiceCollector.getInstance()
        .authService.getAllSize(id);
    setCarSize=_carSizes.last.id;
notifyListeners();
  }

var searchController = TextEditingController();
  void showSelectOffieSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return SelectOfficeSheet(
            onCallBack: (value) {
              OfficeModel office = (value as OfficeModel);
              _formData['selectedOfficeId'] = office.id;
              _formData['selectedOfficeNameEn'] = office.officeNameEn;
              _formData['selectedOfficeNameAr'] = office.officeNameAr;

              notifyListeners();
            },
            search:searchController ,
          );
        });
  }

  void deleteOffice() {
    _formData['selectedOfficeId'] = '';
    notifyListeners();
  }

 }
