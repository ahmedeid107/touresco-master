import 'package:touresco/models/light_trip_model.dart';

import 'package:touresco/services/service_collector.dart';

class ArchiveModel {
  List<SingleArchivedDataResult> resultTripsToCreator;
  List<SingleArchivedTrip> allArchivedTrips;
  List<SingleArchivedTrip> allownedArchivedTrips;

  ArchiveModel(
      {required this.resultTripsToCreator, required this.allArchivedTrips, required this.allownedArchivedTrips});

  ArchiveModel.fromJson(Map<String, dynamic> json)
      : resultTripsToCreator =
            getArchiveDataResultAsList(json['resultTripsToCreator']),
        allArchivedTrips = getAllArchiveTripsAsList(json['allArchivedTrips'])
  ,allownedArchivedTrips=getAllownedArchivedTrips(json['allownedArchivedTrips'])
  ;

  static List<SingleArchivedDataResult> getArchiveDataResultAsList(
      List<dynamic> results) {
    List<SingleArchivedDataResult> ret = [];

    for (var element in results) {
      ret.add(SingleArchivedDataResult.fromJson(element));
    }

    return ret;
  }

  static List<SingleArchivedTrip> getAllArchiveTripsAsList(
      List<dynamic> results) {
    List<SingleArchivedTrip> ret = [];

    for (var element in results) {
       ret.add(SingleArchivedTrip.fromJson(element));
    }

    return ret;
  }
  static List<SingleArchivedTrip> getAllownedArchivedTrips(
      List<dynamic> results) {
    List<SingleArchivedTrip> ret = [];

    for (var element in results) {
       ret.add(SingleArchivedTrip.fromJson(element));
    }

    return ret;
  }
}

class SingleArchivedDataResult {
  final String id;
  final String name;
  final int numberOfTrips;

  SingleArchivedDataResult(
      {required this.id, required this.name, required this.numberOfTrips});

  SingleArchivedDataResult.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        numberOfTrips = json['numberOfTrips'];
}

class SingleArchivedTrip {
  final String id;
  String get tripType => ServiceCollector.getInstance().currentLanguage == 'en'
      ? tripTypeEn
      : tripTypeAr;
  final String tripTypeEn;
  final String Trip_Unchangable_Id ;
  final String tripTypeAr;
  final DateTime date;
  final String price;
  final TripSource tripSource;
  final String? sourceId;

  SingleArchivedTrip(
      {required this.id,
      required this.tripTypeEn,
      required this.tripTypeAr,
      required this.Trip_Unchangable_Id,
      required this.date,
      required this.price,
      required this.tripSource,
      required this.sourceId});

  SingleArchivedTrip.fromJson(Map<String, dynamic> json)
      : id = json['Trip_Id'],
        Trip_Unchangable_Id = json['Trip_Unchangable_Id']==null?"":json['Trip_Unchangable_Id'].toString(),
        tripTypeEn = json['Trip_Type']['Type_English'],
        tripTypeAr = json['Trip_Type']['Type_Arabic'],
        date = DateTime.parse(json['Trip_Payment_Due']),
        price = json['Trip_Price'],
        tripSource = LightTripModel.getTripSourceFromString(json['Trip_Path']),
        sourceId = json['sourceId'];
}
