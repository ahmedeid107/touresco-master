import 'package:touresco/models/archive_model.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:touresco/models/trip_details_model.dart';

abstract class ITrips {
  Future<List<LightTripModel>> getDriverTrips(String id);
  Future<TripDetailsModel> getTripDetails(
      String id, String path, String userId);
  Future<bool> transferTrip(
      {required bool isTransferToPublicRole,
      required String tripId,
      required String fromUserId,    required bool isUpdate,

        required String toUserId,
      required String price,
        required List<Map<String,dynamic>> arr,
      required String paymentDate,
      required String note,
      required String commission,
      required bool isAbleToTransfer,
      required String path});



  Future<bool> takeTrip(String driverId, String tripId, String path);
  Future<bool> cancelTrip(
      String tripId, String userId, String tripStatus, String path,bool isOwner);
  Future<bool> endTrip(String driverId, String tripId, String path);
  Future<bool> completeAllExpensesForTrip(
      String driverId, String tripId, String path,
      bool needSave
      );
  Future<bool> requestMovemntMotion(
      String tripId, String driverId, String path);
  Future<String> getRequestMotionUrl(
      String approvalId, String path, String userId, String tripId);
  Future<String> getManifestUrl(String tripId, String path, String userId);
  Future<Map<String, List<LightTripModel>>> getAllUserTrips(String userId );
  Future<ArchiveModel> getArchiveData(String userId  );
  Future<List<SingleArchivedTrip>> getArchivedTripsFilteredByDate(
      String userId, String fromDate, String toDate);
  Future<Map<String, dynamic>> getTransferredTripsForUser(String userId);
  Future<String> setSingleProgramToEnd(
      String programId, String tripSourceId, String path);
  Future<bool> sendNotificationToOffice(
      String driverId, String officeId, String notification, String path);
}
