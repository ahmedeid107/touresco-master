import 'package:touresco/services/service_collector.dart';

class OfficeModel {
  final String id;
  final String officeNameEn;
  final String officeNameAr;
  String get officeName =>
      ServiceCollector.getInstance().currentLanguage == 'en'
          ? officeNameEn
          : officeNameAr;

  OfficeModel(
      {required this.id,
      required this.officeNameEn,
      required this.officeNameAr});

  OfficeModel.fromJson(Map<String, dynamic> json)
      : id = json['Disk_Id'],
        officeNameEn = json['Disk_Name_English'],
        officeNameAr = json['Disk_Name_Arabic'];
}
