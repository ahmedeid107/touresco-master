import 'package:touresco/services/service_collector.dart';

class CityModel {
  final String id;
  final String cityNameEn;
  final String cityNameAr;
  String get cityName => ServiceCollector.getInstance().currentLanguage == 'en'
      ? cityNameEn
      : cityNameAr;

  CityModel(
      {required this.id, required this.cityNameEn, required this.cityNameAr});

  CityModel.fromJson(Map<String, dynamic> json)
      : id = json['City_Id'],
        cityNameEn = json['City_English_Name'],
        cityNameAr = json['City_Arabic_Name'];
}

class DistrictModel {
  final String id;
  final String districtNameEn;
  final String districtNameAr;
  String get districtName =>
      ServiceCollector.getInstance().currentLanguage == 'en'
          ? districtNameEn
          : districtNameAr;

  DistrictModel(
      {required this.id,
      required this.districtNameEn,
      required this.districtNameAr});

  DistrictModel.fromJson(Map<String, dynamic> json)
      : id = json['District_Id'],
        districtNameEn = json['District_En_Name'],
        districtNameAr = json['District_Ar_Name'];
}
