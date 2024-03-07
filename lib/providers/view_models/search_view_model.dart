import 'package:flutter/material.dart';
import 'package:touresco/models/single_driver_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:flutter/services.dart';

class SearchViewModel with ChangeNotifier {
  List<SingleDriverModel> _searchedDrivers = [];
  List<SingleDriverModel> get searchedDrivers => [..._searchedDrivers];

  void searchByName(String name) async {
    _searchedDrivers =
        await ServiceCollector.getInstance().metaDataService.searchByName(name);
    notifyListeners();
  }

  void copyDriverIdToCilpboard(
      String txt, String driverName, BuildContext context) {
    String lang = ServiceCollector.getInstance().currentLanguage;
    Clipboard.setData(ClipboardData(text: txt));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(lang == 'en'
            ? '$driverName Id has been copied'
            : 'تم نسخ معرف السائق $driverName')));
  }
}
