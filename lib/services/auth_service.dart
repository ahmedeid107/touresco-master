import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:touresco/Interfaces/i_auth.dart';
import 'package:touresco/models/car_size_model.dart';
import 'package:touresco/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:touresco/services/app_communication_service.dart';
import 'package:touresco/services/app_exception.dart';

import '../utils/constants.dart';

class AuthService implements IAuth {
  @override
  Future<UserModel> signIn(
      String email, String password, String deviceToken) async {
    final url = Uri.parse(mainUrl);
    final Map<String, dynamic> formData = {
      'login': '',
      'email': email,
      'password': password,
      'tokens': deviceToken,
    };

    try {
      final res = await http.post(url, body: formData);

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }

      final mapData = json.decode(res.body) as Map;

      if (mapData['Status'] == null) {
        throw AppException(AppExceptionData.unkown);
      }
      if (mapData['Status'] == '2') {
        throw AppException(AppExceptionData.emailOrPasswordIncorrect);
      }
      if (mapData['Status'] == '3') {
        throw AppException(AppExceptionData.accountNotExisted);
      }
      if (mapData['Status'] == '4') {
        throw AppException(AppExceptionData.accountIsNotActive);
      }
      // note  => login of deleted account \\//
      if (mapData['Status'] == '5') {
        throw AppException(AppExceptionData.accountIsNotActive);
      }

      //print(res.body);
      if (mapData['Status'] != '1') throw AppException(AppExceptionData.unkown);

      var map = mapData['User_Data'] as Map<String, dynamic>;
      var user = UserModel.fromJson(map);

      return user;
    } on AppException catch (error) {
      throw error.toString();
    } catch (error) {
      //  print(error.toString());
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<void> signUp(UserModel user, bool withActivateOwnerDashboard) async {
    final url = Uri.parse(mainUrl);

    String liscenseDateAsText =
        '${user.liscenseDate.year}-${user.liscenseDate.month}-${user.liscenseDate.day}';

    final Map<String, dynamic> formData = {
      'driver_registration': '',
      'name': user.fullName,
      'email': user.email,
      'phone': AppCommunicationService.replaceArabicNumber(user.phone),
      'password': user.password,
      'car_type': user.carTypeId,
      'seats_type': user.carSizeId,
      'license_due_date': liscenseDateAsText,
      'car_license_number': AppCommunicationService.replaceArabicNumber(
          user.carLicenseNumber.toString()),
      'udi_driver_licens_number':
          AppCommunicationService.replaceArabicNumber(user.carLisenseId),
      'phone2_opt': AppCommunicationService.replaceArabicNumber(user.phone2!),
      'office_id': user.officeId,
      'car_number': AppCommunicationService.replaceArabicNumber(user.carNumber),
      'instint_registration': withActivateOwnerDashboard ? '1' : '0',
    };

    try {
      final res = await http.post(url, body: formData);

      if (res.statusCode != 200) {
        throw AppException(AppExceptionData.serverNotRespond);
      }

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }

      final resData = json.decode(res.body) as Map;

      if (resData['Status'] == '404') {
        throw AppException(AppExceptionData.emailIsExisted);
      }

      if (resData['Status'] != '400') {
        throw AppException(AppExceptionData.unkown);
      }
    } on AppException catch (_) {
      rethrow;
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      prefs.remove('user');
      prefs.remove('img');
    }
  }

  @override
  Future<bool> retrieveAccountPassword(String email) async {
    final url = Uri.parse(mainUrl);
    try {
      final res =
          await http.post(url, body: {'Forgot_Password': '', 'email': email});

//empty email notexisted
      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      if (res.body == '2') {
        throw AppException(AppExceptionData.errorEmailNotExisted);
      } else if (res.body != '1') {
        throw AppException(AppExceptionData.unkown);
      }

      return true;
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Future<bool> changePassword(
      String userId, String oldPassword, String newPassword) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Change_Password': '',
        'User_Id': userId,
        'Password': newPassword,
        'Old_Password': oldPassword,
      });
      print("ASASD A SD ${res.body}");
      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      final mapData = json.decode(res.body) as Map;

      if (mapData['Status'] == '2') {
        throw AppException(AppExceptionData.oldPasswordIsNotCorrect);
      }

      if (mapData['Status'] != '1') {
        throw AppException(AppExceptionData.unkown);
      }

      return true;
    } on AppException catch (error) {
      throw error.toString();
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<Map> syncUserData(String userId) async {
    final url = Uri.parse(mainUrl);
    // final url = Uri.parse('https://apimocha.com/touresco/sync-user');
    try {
      final res =
          await http.post(url, body: {'profile_data': '', 'User_id': userId});

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      final mapData = json.decode(res.body) as Map;

      return mapData.cast<String, String?>();
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> updateUserData(String userId, Map data, bool isOfficeChanged,
      bool isOwnerStatusChanged) async {
    final url = Uri.parse(mainUrl);

    try {
      print("ASDASDss  ${data['selectedCarSize']}");
      print("ASDASDss  ${data['selectedCarType']}");
      final res = await http.post(url, body: {
        'profile_edit': '',
        'userId': userId,
        'phone': AppCommunicationService.replaceArabicNumber(data['phone']),
        'phone2': AppCommunicationService.replaceArabicNumber(data['phone2']),
        'carLisenseId':
            AppCommunicationService.replaceArabicNumber(data['carLisenseId']),
        'driverLisenseId': AppCommunicationService.replaceArabicNumber(
            data['driverLisenseId']),
        'carNumber':
            AppCommunicationService.replaceArabicNumber(data['carNumber']),
        'driverLisenseEndDate': data['driverLisenseEndDate'],
        'selectedCarType': data['selectedCarType'],
        'selectedCarSize': data['selectedCarSize'],
        'selectedOfficeId':
            (data['selectedOfficeId'] == null || data['selectedOfficeId'] == '')
                ? ''
                : data['selectedOfficeId'],
        'isOwnerStatusChanged': isOwnerStatusChanged == true ? '1' : '0',
        'isOfficeStatusChanged': isOfficeChanged ? '1' : '0'
      });

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      return true;
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> checkIfDriverCanUserEmailAsOwner(String email) async {
    final url = Uri.parse(mainUrl);
    //final url = Uri.parse('https://apimocha.com/touresco/check-owner');

    try {
      final res =
          await http.post(url, body: {'Check_Email': '', 'email': email});

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      return res.body == '1' ? true : false;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  deleteAccount({required String token, required String password}) async {
    // TODO: implement deleteAccount
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url, body: {
        'user_password': password,
        'user_id': token,
        "Deactivate_Account": ""
      });

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }
      final mapData = json.decode(res.body) as Map;
      return mapData;
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<Map > updateProfileImage(File image, String userId) async {
    final url = Uri.parse(mainUrl);
    try {
      var request = http.MultipartRequest("POST", url);
      request.fields['update_profile_image'] = '';
      request.fields['User_Id'] = userId;

      var pic = await http.MultipartFile.fromPath('data', image.path);

      request.files.add(pic);
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      Map<String, dynamic> mapData =
          json.decode(String.fromCharCodes(responseData));
      print("ASDADS AS${mapData}");
      String status =
           mapData['Status']  ;
      final String imageUrl = mapData['Profile_Photo'];

      return {"status": status, "imageUrl": imageUrl};
    } catch (error) {
      print("AAAAAAAAAAAAAA ${error}");
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<List<CarSizeModel>> getAllSize(String id) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url, body: {"get_seats": "", "car_id": id});

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }
      final mapData = json.decode(res.body) as List;
      List<CarSizeModel> a = [];
      mapData.forEach((element) {
        a.add(CarSizeModel.fromJson2(element));
      });
      return a;
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }
}
