import 'package:touresco/services/service_collector.dart';

enum TripSource { none, oirginalSource, translated, owned, requiredByPay }
enum TripClassification {
  none,
  generalTrip,
  specificTrip,
  emergencyTrip,
  transferedTrip
}

class LightTripModel {
  final String id;
  final String Trip_Unchangable_Id;
  final double price;
  final TripTypeModel tripType;
  final TripDirectionModel tripDirection;
  final String tripExpirationTime;

  String get getResponseTimeForUserDisplay {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (tripExpirationTime.isEmpty) return '';

    int hour = int.parse(tripExpirationTime.split(':')[0]);
    int min = int.parse(tripExpirationTime.split(':')[1]);

    return lang == 'en' ? '$hour hour $min minute' : '$hour ساعة $min دقيقة';
  }

  final TripRegionModal tripRegionData;
  final String tripOwner;
  final String Trip_Time_Diff;
  final String commission;
  final TripClassification classification;
  final TripSource tripSource;
  final String numberOfPassenger;
  final String numberOfDays;
  final String paymentDate;
  final String driverName;
  final String Trip_Time_In_System;

  String get getTripClassicifcationAsText {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (classification == TripClassification.generalTrip) {
      return lang == 'en' ? "General Trip" : 'رحلة حسب الدور';
    } else if (classification == TripClassification.specificTrip) {
      return lang == 'en' ? "Specific Trip" : 'رحلة مخصصة';
    } else if (classification == TripClassification.emergencyTrip) {
      return lang == 'en' ? 'Emergency Trip' : 'طلب مستعجل';
    } else if (classification == TripClassification.transferedTrip) {
      return lang == 'en' ? 'Transferred Trip' : 'رحلة محولة';
    } else {
      return 'NONE';
    }
  }

  String get getTripClassicifcationAsIcon {
    if (classification == TripClassification.generalTrip) {
      return '🧑‍✈️';
    } else if (classification == TripClassification.specificTrip) {
      return '🙏';
    } else if (classification == TripClassification.emergencyTrip) {
      return '🔥';
    } else if (classification == TripClassification.transferedTrip) {
      return '💫';
    } else {
      return 'NONE';
    }
  }

  LightTripModel({
    required this.id,
    required this.Trip_Time_Diff,
    required this.price,
    required this.tripType,
    required this.Trip_Unchangable_Id,
    required this.tripDirection,
    required this.tripExpirationTime,
    required this.tripRegionData,
    required this.tripOwner,
    required this.commission,
    required this.classification,
    required this.numberOfPassenger,
    required this.Trip_Time_In_System,
    required this.numberOfDays,
    required this.driverName,
    required this.tripSource,
    required this.paymentDate,
   });

  LightTripModel.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['Trip_Id'],
        price = double.parse(jsonData['Trip_Price']),
        tripType = TripTypeModel.fromJson(jsonData['Trip_Type']),
        tripDirection = TripDirectionModel.fromJson(jsonData['Trip_time']),
        tripExpirationTime = jsonData['Trip_Time_Expiration']??"",
        tripRegionData = TripRegionModal.fromJson(jsonData['Trip_Regional']),
        tripOwner = jsonData['Trip_Owner'],
        commission = jsonData['Commission'],
        driverName = jsonData['driver_name'].toString() ,
        Trip_Unchangable_Id = jsonData['Trip_Unchangable_Id'] == null ? "" : jsonData['Trip_Unchangable_Id'].toString() ,
        Trip_Time_Diff = jsonData['Trip_Time_Diff'].toString() ,
        Trip_Time_In_System = jsonData['Trip_Time_In_System'].toString(),
        classification = getTripClassification(jsonData['Trip_Classification']),
        tripSource = getTripSourceFromString(jsonData['Trip_Path']),
        numberOfPassenger = jsonData['numberOfPassenger'] ?? 'passenges',
        numberOfDays = jsonData['numberOfDays'] ?? '',
        paymentDate = jsonData['Trip_Payment_Due'] ?? ''
     ;

  static TripSource getTripSourceFromString(String name) {
    if (name == '1') {
      return TripSource.oirginalSource;
    } else if (name == '2') {
      return TripSource.translated;
    } else if (name == '3') {
      return TripSource.owned;
    } else if (name == '4') {
      return TripSource.requiredByPay;
    } else {
      return TripSource.translated;
    }
  }

  static TripClassification getTripClassification(String classification) {
    if (classification == '1') {
      return TripClassification.generalTrip;
    } else if (classification == '2') {
      return TripClassification.specificTrip;
    } else if (classification == '3') {
      return TripClassification.emergencyTrip;
    } else if (classification == '4') {
      return TripClassification.transferedTrip;
    } else {
      return TripClassification.none;
    }
  }
}

class TripTypeModel {
  final String typeNameEn;
  final String typeNameAr;
  String get typeName => ServiceCollector.getInstance().currentLanguage == 'en'
      ? typeNameEn
      : typeNameAr;

  TripTypeModel({required this.typeNameEn, required this.typeNameAr});

  TripTypeModel.fromJson(Map<String, dynamic> json)
      : typeNameEn = json['Type_English'],
        typeNameAr = json['Type_Arabic'];
}

class TripDirectionModel {
  final String tripDirectionEn;
  final String tripDirectionAr;

  TripDirectionModel(this.tripDirectionEn, this.tripDirectionAr);

  TripDirectionModel.fromJson(Map<String, dynamic> json)
      : tripDirectionEn = json['Time_English'],
        tripDirectionAr = json['Time_Arabic'];
}

class TripRegionModal {
  final String regionEn;
  final String regionAr;
  final String governorateEn;
  final String governorateAr;

  TripRegionModal(
      this.regionEn, this.regionAr, this.governorateEn, this.governorateAr);

  TripRegionModal.fromJson(Map<String, dynamic> json)
      : regionEn = json['Region_English'],
        regionAr = json['Region_Arabic'],
        governorateEn = json['Governorate_English'],
        governorateAr = json['Governorate_Arabic'];
}
