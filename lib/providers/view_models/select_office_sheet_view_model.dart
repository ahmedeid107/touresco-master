import 'package:flutter/material.dart';
import 'package:touresco/Interfaces/i_meta_data.dart';
import 'package:touresco/models/office_model.dart';

class SelectOfficeSheetViewModel with ChangeNotifier {
  final IMetaData metaDataService;

  List<OfficeModel> _offices = [];

  SelectOfficeSheetViewModel(this.metaDataService);
  List<OfficeModel> get offices => [..._offices];

  bool isLoadingOffices = false;

  void syncAndFecthOffices(String name) async {

    _offices = await metaDataService.getAllOffices(name);
    print(_offices.length.toString() +" asdas das ");
    notifyListeners();
  }
}
