import 'dart:convert';

import 'package:touresco/Interfaces/i_expenses.dart';
import 'package:http/http.dart' as http;
import 'package:touresco/models/single_finance_model.dart';
import 'package:touresco/models/single_finance_trip_model.dart';
import 'package:touresco/services/app_communication_service.dart';
import 'package:touresco/services/app_exception.dart';

import '../utils/constants.dart';

class SQLExpensesService implements IExpenses {
  @override
  Future<bool> addExpenses(String tripId, String driverId, double prcie,
      String note, String paymentType, String path) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Add_Outlay': '',
        'Trip_Id': tripId,
        'Outlay_Amount':
            AppCommunicationService.replaceArabicNumber(prcie.toString()),
        'Outlay_Payment_Type': paymentType,
        'Driver_Id': driverId,
        'Outlay_Note': note,
        'Path': path,
      });

      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);

      final String? status = (json.decode(res.body) as Map)['Status'];
      if (status == null) throw AppException(AppExceptionData.unkown);
      if (status != '1') throw AppException(AppExceptionData.unkown);

      return true;
    } catch (error) {
      throw 'An error occurs, can\'t add this expenses';
    }
  }

  @override
  Future<bool> agreeNewExpensesByDriver(
      String userId, String expensesId, String path) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Outlay_Confirm_or_Refuse': '',
        'Outlay_Id': expensesId,
        'Driver_id': userId,
        'Status': '1',
        'Path': path,
      });
      print("ASDADSSddddAD ${res.body}");

      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);

      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> cancelNewExpensesByDriver(
      String userId, String expensesId, bool isOwner) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Outlay_Confirm_or_Refuse': '',
        'Outlay_Id': expensesId,
        'Driver_id': userId,
        'Status': isOwner ? '6' : '5',

      });
      print("ASDADSSAaaaaD ${res.body}");

      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);
      print("ASDADSSADeee ${res.body}");
      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> cancelPendingExpenses(
      String userId, String expensesId, bool isOwner) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Outlay_Confirm_or_Refuse': '',
        'Outlay_Id': expensesId,
        'Driver_id': userId,
        'Status': isOwner  ? '6' : '5',
      });
      print("ASDADSSADwwww ${res.body}");

      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);

      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> paymentDoneForExpenses(
      String userId, String expensesId, String path) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Outlay_Confirm_or_Refuse': '',
        'Outlay_Id': expensesId,
        'Driver_id': userId,
        'Status': '2',

      });
      print("ASDADSS1111AD ${res.body}");

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }

      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<Map<String, List<SingleFinanceModel>>> getAllUserFinances(
      String userId) async {
    final url = Uri.parse(mainUrl);
print("ASDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    try {
      final res = await http.post(url, body: {
        'Driver_Financial_Debt': '',
        'driver_id': userId,
      });

      final mapData = json.decode(res.body) as Map;
      print("ASDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD ${mapData}  DDD");

//Dues
      List<SingleFinanceModel> dues = [];

      for (var element in (mapData['Trip_Data'] as List)) {
        dues.add(SingleFinanceModel.fromJson(element));
      }
      print("SingleFinanceModel ${mapData}  DDD");

      //requiredToPay
      List<SingleFinanceModel> requiredToPay = [];

      for (var element in (mapData['Trip_Debt'] as List)) {
        requiredToPay.add(SingleFinanceModel.fromJson(element));
      }
      print("Trip_Debt ${mapData}  DDD");

      return {
        'select': [],
        'dues': dues,
        'requiredToPay': requiredToPay,
      };
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<List<SingleTripFinanceModel>> getTripsRelatedWithCreatorByExpensesStatus(
          String userId, String officeId, String path , String ownerType , String fillter) async {
    final url = Uri.parse(mainUrl);
    print("ASDSAD AS ${fillter} ads");

    try {
     var owner = "";
      if(ownerType == "1" || ownerType == "2"){
        owner = ownerType;
      }else {
        if (ownerType == "fromOffice") {
          owner = "1";
        } else {
          owner = "2";
        }
      }

      final res = await http.post(url, body: {
        'Driver_Financial_Debt_Spesifc': '',
        'driver_id': userId ,
        'user_id': officeId ,
        "ownerType":owner,
        "type":fillter

       });

      final mapData = json.decode(res.body) as Map;
      print("objectas1111 ${mapData}");
      List<SingleTripFinanceModel> ret = [];
      for (var element in (mapData['Data'] as List)) {
        ret.add(SingleTripFinanceModel.fromJson(element));
      }
       return ret;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<List<SingleTripFinanceModel>>
      filterTripsRelatedWithCreatorByPaymentDate(String userId, String officeId,
          String fromDate, String toDate, String ownerType, String type) async {
    final url = Uri.parse(mainUrl);
    try {



      final res = await http.post(url, body: {
        'Driver_Financial_Debt_Spesifc': '',
        'driver_id': userId,
        'user_id': officeId,
        'Date1': fromDate,
        "Date2": toDate,
        "ownerType": ownerType,
        "type": type,
      });

      final mapData = json.decode(res.body) as Map;
       List<SingleTripFinanceModel> ret = [];
      for (var element in (mapData['Data'] as List)) {
        ret.add(SingleTripFinanceModel.fromJson(element));
      }

      return ret;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }
}
