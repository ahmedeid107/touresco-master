import 'package:touresco/services/service_collector.dart';

class CarSizeModel {
  final String id;
  final String carSeatArabic;
  final String carSeatEnglish;
  String get carSeat => ServiceCollector.getInstance().currentLanguage == 'en'
      ? carSeatEnglish
      : carSeatArabic;

  CarSizeModel({
    required this.id,
    required this.carSeatArabic,
    required this.carSeatEnglish,
  });

  CarSizeModel.fromJson(Map<String, dynamic> json)
      : id = json['Car_Seats_Id'],
        carSeatArabic = json['Car_Seats_Arabic'],
        carSeatEnglish = json['st_english_name'];

  CarSizeModel.fromJson2(Map<String, dynamic> json)
      : id = json['Car_Passnger_ID'],
        carSeatArabic = json['Arabic_Name'],
        carSeatEnglish = json['English_Name'];
}
