import 'package:touresco/services/service_collector.dart';

class CarTypeModel {
  final String id;
  final String carTypeEn;
  final String carTypeAr;
  String get carType => ServiceCollector.getInstance().currentLanguage == 'en'
      ? carTypeEn
      : carTypeAr;

  CarTypeModel(
      {required this.id, required this.carTypeEn, required this.carTypeAr});

  CarTypeModel.fromJson(Map<String, dynamic> json)
      : id = json['Car_Type_Id'],
        carTypeAr = json['Car_Type_Arabic'],
        carTypeEn = json['Car_Type_English'];
}
