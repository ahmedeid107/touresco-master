import 'dart:convert';
import 'package:touresco/Interfaces/i_trips.dart';
import 'package:touresco/models/archive_model.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:http/http.dart' as http;
import 'package:touresco/models/trip_details_model.dart';
import 'package:touresco/services/app_communication_service.dart';
import 'package:touresco/services/app_exception.dart';

import '../utils/constants.dart';

class SQLTripsService implements ITrips {
  @override
  Future<List<LightTripModel>> getDriverTrips(String id) async {
    final url = Uri.parse(mainUrl);

    try {
      final res =
          await http.post(url, body: {'get_driver_trips': '', 'user_id': id});

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }

      final mapData = json.decode(res.body) as Map;

      if (mapData['Status'] == '2') return [];
      if (mapData['Status'] != '1') throw AppException(AppExceptionData.unkown);

      final trips = mapData['Trip_Data'] as List;
      List<LightTripModel> ret = [];
      for (var element in trips) {
        ret.add(LightTripModel.fromJson(element as Map<String, dynamic>));
      }
      return ret;
    } catch (_) {
      throw 'Unkown error, please try again later';
    }
  }

  @override
  Future<TripDetailsModel> getTripDetails(
    String id,
    String path,
    String userId,
  ) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(
        url,
        body: {
          'Get_Trip_Data': '',
          'Trip_Id': id,
          "User_Id": userId,
        },
      );
      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }
      final mapData = json.decode(res.body) as Map<String, dynamic>;
      var trip = TripDetailsModel.fromJson(mapData);
      return trip;
    } catch (error) {
      throw AppException(AppExceptionData.errorTripDetailsPage).toString();
    }
  }

  @override
  Future<bool> transferTrip({
    required bool isTransferToPublicRole,
    required String tripId,
    required String fromUserId,
    required String toUserId,
    required String price,
    required String paymentDate,
    required String note,
    required String commission,
    required bool isAbleToTransfer,
    required bool isUpdate,
    required List<Map<String, dynamic>> arr,
    required String path,
  }) async {
    final url = Uri.parse(mainUrl);

    try {
     if(isUpdate){
       await http.post(url, body: {
         'Update_Trip': '',
         'Trip_id': tripId,
         'Expensis': jsonEncode(arr),
         'Trip_Owner': fromUserId,
         'To_Driver': toUserId,
         'Price': AppCommunicationService.replaceArabicNumber(price),
         'Payment_Doue': paymentDate,
         'Transfarring_Condtion': isAbleToTransfer == false ? '0' : '1',
         'Commission': AppCommunicationService.replaceArabicNumber(commission),
         'Notes': note,
         'Transfare': isTransferToPublicRole
             ? 'Transfare_To_System'
             : 'Transfare_To_Driver',
       });
       return true;
     }else{
       await http.post(url, body: {
         'Transfare_Trip': '',
         'Trip_id': tripId,
         'Expensis': jsonEncode(arr),
         'Trip_Owner': fromUserId,
         'To_Driver': toUserId,
         'Price': AppCommunicationService.replaceArabicNumber(price),
         'Payment_Doue': paymentDate,
         'Transfarring_Condtion': isAbleToTransfer == false ? '0' : '1',
         'Commission': AppCommunicationService.replaceArabicNumber(commission),
         'Notes': note,
         'Transfare': isTransferToPublicRole
             ? 'Transfare_To_System'
             : 'Transfare_To_Driver',
       });
       return true;
     }
    } catch (error) {
      throw AppException(AppExceptionData.unkown);
    }
  }

  @override
  Future<bool> cancelTrip(
    String tripId,
    String userId,
    String tripStatus,
    String path,
    bool isOwner,
  ) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url, body: {
        'Refuse_Trip': '',
        'Trip_Id': tripId,
        'Driver_Id': userId,
        'Trip_Status': tripStatus,
        'isOwner': isOwner.toString(),
        'Path': path
      });
      print("asddddddddddddddddd ${res.body}");
      if (res.body.isEmpty) throw AppException(AppExceptionData.unkown);
      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> requestMovemntMotion(
      String tripId, String driverId, String path) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Send_Approve': '',
        'trip_id': tripId,
        'driver_id': driverId,
        'Path': path,
      });

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }

      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> takeTrip(String driverId, String tripId, String path) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Confirm_Trip': '',
        'trip_id': tripId,
        'driver_id': driverId,
        'Path': path
      });

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }

      String status = (json.decode(res.body) as Map)['Status'];

      if (status != '400') {
        throw AppException(AppExceptionData.canNotTakeTripForThisUser);
      }

      return true;
    } on AppException catch (error) {
      throw error.toString();
    } catch (error) {
      throw 'An error occurs, please try again later';
    }
  }

  @override
  Future<String> getManifestUrl(String tripId, String path, String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://touresco.net/mobile/print_mobile.php?trip_id=$tripId&userid=${userId}';
    //  return 'https://www.google.com';
  }

  @override
  Future<String> getRequestMotionUrl(String approvalId, String path, String userId, String tripId) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'https://touresco.net/mobile/print_agreement.php?approvel=$approvalId&Path=$path&userid=$userId&trip_id=$tripId';
  }

  @override
  Future<bool> completeAllExpensesForTrip(
      String driverId, String tripId, String path, bool needSave) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Confirm_Trip': '',
        'trip_id': tripId,
        'driver_id': driverId,
        'Path': path,
        "sendToArchive": needSave.toString()
      });

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }

      String status = (json.decode(res.body) as Map)['Status'];

      if (status != '400') {
        throw AppException(AppExceptionData.canNotTakeTripForThisUser);
      }

      return true;
    } on AppException catch (error) {
      throw error.toString();
    } catch (_) {
      throw 'An error occurs, please try again later';
    }
  }

  @override
  Future<bool> endTrip(String driverId, String tripId, String path) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(url, body: {
        'Confirm_Trip': '',
        'trip_id': tripId,
        'driver_id': driverId,
      });

      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.serverNotRespond);
      }
      print("ASDASD AASD ${res.body} ");
      String status = (json.decode(res.body) as Map)['Status'];

      if (status == '499') {
        throw AppException(
            AppExceptionData.errorTheLastDriverNotEndTranslatedTrip);
      }

      if (status != '400') {
        throw AppException(AppExceptionData.canNotTakeTripForThisUser);
      }

      return true;
    } on AppException catch (error) {
      throw error.toString();
    } catch (_) {
      throw 'An error occurs, please try again later';
    }
  }

  @override
  Future<Map<String, List<LightTripModel>>> getAllUserTrips(
    String userId,
  ) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url,
          body: {'Get_driver_trips_as_driver': '', 'user_id': userId});
      final mapData =
          (json.decode(res.body) as Map).cast<String, List<dynamic>>();
      List<LightTripModel> currentTrips = [];
      for (var element in mapData['Trip_Data_Active'] as List) {
        currentTrips.add(LightTripModel.fromJson(element));
      }
      List<LightTripModel> notPaid = [];
      for (var element in mapData['Trip_Data_Finished_Need_Payment'] as List) {
        notPaid.add(LightTripModel.fromJson(element));
      }

      List<LightTripModel> archivedTrips = [];
      for (var element in mapData['Trip_Data_Finished_Archived'] as List) {
        archivedTrips.add(LightTripModel.fromJson(element));
      }

      return {
        'currentUserTrips': currentTrips,
        'pendingUserPaymentTrips': notPaid,
        'archivedUserTrips': archivedTrips,
      };
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ArchiveModel> getArchiveData(String userId) async {
    final url = Uri.parse(mainUrl);
    try {
      final res =
          await http.post(url, body: {'get_archefed': '', 'User_Id': userId});

      final mapData = json.decode(res.body) as Map;
print("AAAAAAAAAAAAAAAAAA ${mapData}");
      return ArchiveModel.fromJson(mapData.cast<String, dynamic>());
      /*
      await Future.delayed(const Duration(seconds: 2));
      return ArchiveModel(resultTripsToCreator: [
        SingleArchivedDataResult(id: '1', name: 'Anas Anis', numberOfTrips: 1),
        SingleArchivedDataResult(
            id: '2', name: 'Hady Office', numberOfTrips: 2),
        SingleArchivedDataResult(
            id: '3', name: 'Ahmad Hamada', numberOfTrips: 3),
        SingleArchivedDataResult(
            id: '4', name: 'Alhakam Shesh', numberOfTrips: 4),
        SingleArchivedDataResult(id: '5', name: 'meme', numberOfTrips: 5),
      ], allArchivedTrips: [
        SingleArchivedTrip(
            id: '2',
            tripTypeEn: 'Airport',
            tripTypeAr: 'مطار',
            date: DateTime(1996, 2, 7),
            price: '120',
            tripSource: TripSource.oirginalSource),
        SingleArchivedTrip(
            id: '2',
            tripTypeEn: 'Internal',
            tripTypeAr: 'داخلي',
            date: DateTime(1996, 2, 7),
            price: '220',
            tripSource: TripSource.oirginalSource),
      ]);
      */
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<List<SingleArchivedTrip>> getArchivedTripsFilteredByDate(
      String userId, String fromDate, String toDate) async {
    final url = Uri.parse(mainUrl);

    try {
      print("objectsssssssssss  ${userId}");

      final res = await http.post(url, body: {
        'get_archefed': '',
        'User_Id': userId,
        'Date1': fromDate,
        'Date2': toDate,
      });

      final mapData = json.decode(res.body) as Map;
       print("objectsssssssssss ${mapData}");
      List<SingleArchivedTrip> ret = [];

      for (var element in (mapData['allArchivedTrips'] as List)) {
        ret.add(SingleArchivedTrip.fromJson(element));
      }

      return ret;
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<Map<String, dynamic>> getTransferredTripsForUser(String userId) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url,
          body: {'get_owned_transferd_trips': '', 'user_id': userId});
      final mapData = json.decode(res.body) as Map;

      print("ASDDDDDDDDDDDDDDD ${mapData}");
      // get: pending driver to take trip
      List<LightTripModel> pendingTrips = [];
      for (var element in mapData['Trip_Data_Waiting'] as List) {
        pendingTrips.add(LightTripModel.fromJson(element));
      }
      // get: active
      List<LightTripModel> activeTrips = [];
      for (var element in mapData['Trip_Data_Active'] as List) {
        activeTrips.add(LightTripModel.fromJson(element));
      }

      // get: finished & unpaid trips
      List<LightTripModel> unpaidTrips = [];
      for (var element in mapData['Trip_Data_Finished_Need_Payment'] as List) {
        unpaidTrips.add(LightTripModel.fromJson(element));
      }

      // get: archived trips
      List<LightTripModel> archivedTrips = [];
      for (var element in mapData['Trip_Data_Archived'] as List) {
        archivedTrips.add(LightTripModel.fromJson(element));
      }

      // get canceld by Owner
      List<LightTripModel> canceldByOwner = [];
      for (var element in mapData['Trip_Data_Canceld'] as List) {
        canceldByOwner.add(LightTripModel.fromJson(element));
      }

      // get canceld by Driver
      List<LightTripModel> canceldByDriver = [];
      for (var element in mapData['Trip_Data_Canceld_Bydriver'] as List) {
        canceldByDriver.add(LightTripModel.fromJson(element));
      }

      // get role pending
      List<LightTripModel> rolePending = [];
      for (var element in mapData['Trip_Rolled_Pending'] as List) {
        rolePending.add(LightTripModel.fromJson(element));
      }
      print("return asdads ");
      return {
        'select': [],
        'pending': pendingTrips,
        'active': activeTrips,
        'unpaid': unpaidTrips,
        'archived': archivedTrips,
        'canceldByOwner': canceldByOwner,
        'canceldByDriver': canceldByDriver,
        'pendingByRole': rolePending,
      };
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<String> setSingleProgramToEnd(
      String programId, String tripSourceId, String driverId) async {
    final url = Uri.parse(mainUrl);
    try {
      final res = await http.post(url, body: {
        'Update_Program': '',
        'program_id': programId,
        'Source_Id': tripSourceId,
        "Driver_Id": driverId,
      });

      final mapData = json.decode(res.body) as Map;
      print("EEE ${mapData}");
      return mapData["Status"];
    } catch (_) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  @override
  Future<bool> sendNotificationToOffice(String driverId, String officeId,
      String notification, String path) async {
    final url = Uri.parse(mainUrl);

    try {
      final res = await http.post(
        url,
        body: {
          'Notification_Send': '',
          'Trip_Id': officeId,
          'Note': notification,
          'userId': driverId,
        },
      );
      if (res.body.isEmpty) {
        throw AppException(AppExceptionData.unkown);
      }
      return true;
    } catch (_) {
      throw AppException(AppExceptionData.unkown);
    }
  }
}
