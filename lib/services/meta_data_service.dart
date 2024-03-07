import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:touresco/Interfaces/i_meta_data.dart';
import 'package:touresco/models/car_size_model.dart';
import 'package:touresco/models/car_type_model.dart';
import 'package:http/http.dart' as http;
import 'package:touresco/models/event_model.dart';
import 'package:touresco/models/location_model.dart';
import 'package:touresco/models/notification_model.dart';
import 'package:touresco/models/office_model.dart';
import 'package:touresco/models/single_driver_model.dart';
import 'package:touresco/services/app_exception.dart';

import '../models/countryId.dart';
import '../utils/constants.dart';

class MetaDataService implements IMetaData {
  @override
  Future<List<CarTypeModel>> getAllCarType() async {
    final url = Uri.parse(mainUrl);
    final res = await http.post(url, body: {'Car_Types': ''});
    final resData = json.decode(res.body) as List;

    List<CarTypeModel> ret = [];
    for (var element in resData) {
      print("ASDASD ASD:: ${element}");
      ret.add(CarTypeModel.fromJson(element as Map<String, dynamic>));
    }

    return ret;
  }

  @override
  Future<List<CarSizeModel>> getAllCarSize() async {
    final url = Uri.parse(mainUrl);

    final res = await http.post(url, body: {'Seats_Types': ''});
    final resData = json.decode(res.body) as List;

    List<CarSizeModel> ret = [];
    for (var element in resData) {
      print("ASDASD aasd   ::::    ${element}");
      ret.add(CarSizeModel.fromJson(element as Map<String, dynamic>));
    }

    return ret;
  }

  @override
  Future<List<OfficeModel>> getAllOffices(String name) async {
    final url = Uri.parse(mainUrl);
    final res =
        await http.post(url, body: {'Offices_Search': '', 'name': name});

    final resData = json.decode(res.body) as Map;
    List<OfficeModel> ret = [];
    if (resData.isNotEmpty) {
      final officesList = resData['Data'] as List;

      for (var element in officesList) {
        ret.add(OfficeModel.fromJson(element as Map<String, dynamic>));
      }
    }

    return ret;
  }

  @override
  Future<Map<String, dynamic>> checkCurrentRole(String userId) async {
    final url = Uri.parse(mainUrl);
    final res = await http
        .post(url, body: {'check_reservation': '', 'driver_id': userId});
print("ASDASd ${res.body}");
    return (json.decode(res.body) as Map).cast<String, dynamic>();
  }

  @override
  Future<void> removeGeneralRole(String userId) async {
    final url = Uri.parse(mainUrl);
    await http
        .post(url, body: {'remove_general_role': '', 'driver_id': userId});
  }

  @override
  Future<void> takeGeneralRole(String userId) async {
    final url = Uri.parse(mainUrl);
    print("objectassssssssssssssssssssssssssssssst akeGeneralRole  ");
    await http.post(url, body: {'general_reserve': '', 'driver_id': userId});
  }

  @override
  Future<List<CityModel>> getCities() async {
    final url = Uri.parse(mainUrl);
    final res = await http.post(url, body: {'City_Datas': ''});

    final mapData = json.decode(res.body) as Map;
    final cities = mapData['Data'] as List;

    List<CityModel> ret = [];
    for (var element in cities) {
      ret.add(CityModel.fromJson(element as Map<String, dynamic>));
    }

    return ret;
  }

  @override
  Future<List<DistrictModel>> getDistricts(String cityId) async {
    final url = Uri.parse(mainUrl);
    final res =
        await http.post(url, body: {'District_data': '', 'city_id': cityId});

    final mapData = json.decode(res.body) as Map;
    final cities = mapData['District'] as List;
    List<DistrictModel> ret = [];
    for (var element in cities) {
      ret.add(DistrictModel.fromJson(element as Map<String, dynamic>));
    }

    return ret;
  }

  @override
  Future<void> takeSpecificRole(
      String userId, String cityId, String districtId) async {
    final url = Uri.parse(mainUrl);
    await http.post(url, body: {
      'spesfic_reserve': '',
      'driver_id': userId,
      'city': cityId,
      'district': districtId
    });
  }

  @override
  Future<void> removeSpecificRole(String userId) async {
    final url = Uri.parse(mainUrl);
    await http
        .post(url, body: {'remove_spesfic_role': '', 'driver_id': userId});
  }

  @override
  Future<List<SingleDriverModel>> searchByName(String name) async {
    final url = Uri.parse(mainUrl);
    try {
      final res =
          await http.post(url, body: {'SearchDriver': '', 'user_data': name});

      final mapData = json.decode(res.body) as Map;

      if (mapData['Status'] != '1') return [];

      List<SingleDriverModel> ret = [];

      for (var element in (mapData['Drivers'] as List)) {
        ret.add(SingleDriverModel.fromJson(element));
      }

      return ret;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<String> getPassengerSignUrl(
      String ownerName, String passengerName) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://touresco.net/mobile/print_signe.php?inst_name=$ownerName&sign_name=$passengerName';
  }

  @override
  Future<List<NotificationModel>> syncNotifications(
      String userId, String type) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url,
          body: {'Notification_Data': '', 'driver_id': userId, 'Type': type});

      final mapData = json.decode(res.body) as Map;

      List<NotificationModel> ret = [];

      for (var element in (mapData['Notifications'] as List)) {
        ret.add(NotificationModel.fromJson(element));
      }
      return ret;
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  //NewWork
  @override
  Future<Map<String, dynamic>> syncProfileNotifications(String userId) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http
          .post(url, body: {'Notification_Count': '', 'driver_id': userId});
      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);
      return (json.decode(res.body) as Map).cast<String, dynamic>();
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<Map<String, dynamic>> syncProfileNotificationsNew(
      String userId) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http
          .post(url, body: {'Notification_Count_New': '', 'driver_id': userId});
      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);
      return (json.decode(res.body) as Map).cast<String, dynamic>();
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<void> syncNotificationsSeen(String notificationId) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url,
          body: {'Notification_Update': '', 'notification_id': notificationId});

      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<List<EventModel>> getEvents(int type, String id) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url, body: {
        'GET_EVENTS': '',
        'type': type.toString(),
        "user_id": id.toString()
      });
      List<EventModel> ret = [];

      final mapData = json.decode(res.body) as Map;

      for (Map<String, dynamic> element in (mapData['Events'] as List)) {
        print(element.toString() + " AAAAAAA BB CC ");
        ret.add(EventModel.fromJson(element));
      }
      return ret;
    } catch (a) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<void> deleteNotifications(
      String driverId, List<String> notifications) async {
    final url = Uri.parse(mainUrl);
    try {
      //   var map = {};
      //  notifications.forEach((element) {
      //   map["ID"]=element;
      //  });

      final res = await http.post(url, body: {
        'Delete_Notification': '',
        "user_id": driverId,
        "Notificatios_ids": json.encode(notifications)
      });
      // print("ASDASDSAD ${map}");
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<bool> sendTrip(
      {required String user_id,
      required String requestType,
      required String tripType,
      required String carType,
      required String carSize,
      required String flightNumber,
      required List ways,
      required String ismSha5sa,
      required List press,
      required List outlaies,
      required String driverID,
      required String city,
      required String district,
      required String phoneToCommunity,
      required String touristName,
      required String nationality,
      required String passngerpassport,
      required String price,
      required String dateTravle,
      required String timeTravle,
      required String note,
      required String trip_direction,
      required bool isTheFlightTransferable,
      required bool expensesPriceDetails}) async {
    // TODO: implement sendTrip

    final url = Uri.parse(mainUrl);
    print("Create_Trip dateTravle  ways  ${ways}");

    try {
      var arrDate = dateTravle.split("/");
      var day = arrDate[0];
      var month = arrDate[1];
      var year = arrDate[2];

      var date = DateFormat('yyyy-MM-dd').format(
          DateTime.utc(int.parse(year), int.parse(month), int.parse(day)));
      final res = await http.post(url, body: {
        "Create_Trip": "",
        "user_id": user_id,
        "carSize": carSize,
        "carType": carType,
        "city": city,
        "dateTravle": date,
        "district": district,
        "driverID": driverID,
        "expensesPriceDetails": expensesPriceDetails.toString(),
        "flightNumber": flightNumber,
        "nationality": nationality,
        "note": note,
        "passngerpassport": "123",
        "price": price,
        "isTheFlightTransferable": isTheFlightTransferable.toString(),
        "phoneToCommunity": phoneToCommunity, //8--
        "ways": jsonEncode(ways),
        "timeTravle": timeTravle,
        "requestType": requestType,
        "touristName": touristName,
        "trip_direction": trip_direction,
        "signNam": ismSha5sa,
        "passnger_array": jsonEncode(press),
        "outlaies": jsonEncode(outlaies),
        "tripType": tripType,
      });


      print("ASDASD else ${res.body}");
      if (res.body.isNotEmpty) {

        final resData = json.decode(res.body) as Map;
        print("ASDASD else ${resData}");

        var status =resData["Status"].toString();
        var ifTrue=status  ==  "400";
        print(ifTrue);
        if ( ifTrue ) {
          return true;
        } else {

          return false;
        }
      } else {
        print("ASDASD else");
        return false;
      }
    } catch (er) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<List<Country>> getCountryes() async {
    // TODO: implement getCountryes
    final url = Uri.parse(mainUrl);
    final res = await http.post(url, body: {'get_countries': ''});

     final resData = json.decode(res.body) as List;

    List<Country> ret = [];
    for (var element in resData) {
      print("ASDASD ASD::sssss ssss ssss  ${element}");
      ret.add(Country.fromJson(element as Map<String, dynamic>));
    }

    return ret;
  }
}
