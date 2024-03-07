import 'package:touresco/models/car_size_model.dart';
import 'package:touresco/models/car_type_model.dart';
import 'package:touresco/models/event_model.dart';
import 'package:touresco/models/location_model.dart';
import 'package:touresco/models/notification_model.dart';
import 'package:touresco/models/office_model.dart';
import 'package:touresco/models/single_driver_model.dart';

import '../models/countryId.dart';

abstract class IMetaData {
  Future<List<CarTypeModel>> getAllCarType();
  Future<List<CarSizeModel>> getAllCarSize();
  Future<List<OfficeModel>> getAllOffices(String name);
  Future<Map<String, dynamic>> checkCurrentRole(String userId);
  Future<void> takeGeneralRole(String userId);
  Future<void> removeGeneralRole(String userId);
  Future<List<CityModel>> getCities();
  Future<List<Country>> getCountryes();
  Future<List<DistrictModel>> getDistricts(String cityId);
  Future<void> takeSpecificRole(
      String userId, String cityId, String districtId);

  Future<void> removeSpecificRole(String userId);
  Future<List<SingleDriverModel>> searchByName(String name);
  Future<String> getPassengerSignUrl(String ownerName, String passengerName);
  Future<List<NotificationModel>> syncNotifications(String userId ,String type);
  Future<void> syncNotificationsSeen(String notificationId);
  Future<void> deleteNotifications(String driverId , List<String> notifications);
  Future<Map<String, dynamic>> syncProfileNotifications(String userId);
  Future<Map<String, dynamic>> syncProfileNotificationsNew(String userId);
  Future<List<EventModel>> getEvents(int type , String id);


  Future<bool> sendTrip({
    required String user_id,
    required String requestType,
    required String tripType,
    required String carType,
    required String carSize,
    required String flightNumber,
    required List  ways,
    required List  outlaies,
    required String driverID,
    required String city,
    required String ismSha5sa,
    required List press,
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
    required bool expensesPriceDetails,

});
}
