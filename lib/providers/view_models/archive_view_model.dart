import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:touresco/models/archive_model.dart';
import 'package:touresco/services/service_collector.dart';

class ArchiveViewModel with ChangeNotifier {
  String totalTrips = '';
  int _filterIndex = 0;
  int get filterIndex => _filterIndex;


  set filterIndex(value) {
    _filterIndex = value;
    notifyListeners();
  }
  List<SingleArchivedDataResult> _totals = [];
  List<SingleArchivedDataResult> get chartResult {
    if (_totals.length <= 4) return [..._totals];

    List<SingleArchivedDataResult> ret = [];
    _totals.sort((b, a) => a.numberOfTrips.compareTo(b.numberOfTrips));

    int totalOfOthers = 0;

    for (int i = 3; i < _totals.length; i++) {
      totalOfOthers += _totals[i].numberOfTrips;
    }

    ret = _totals.take(3).toList();
    String lang = ServiceCollector.getInstance().currentLanguage;

    ret.add(SingleArchivedDataResult(
      //Adding low values to others
      id: 'anasanis#@27',
      name: lang == 'en' ? 'Others' : 'أخرى',
      numberOfTrips: totalOfOthers,
    ));

    return ret;
  }

  List<SingleArchivedDataResult> get allResult {
    _totals.sort((b, a) => a.numberOfTrips.compareTo(b.numberOfTrips));
    return [..._totals];
  }

  List<SingleArchivedTrip> _endedTrips = [];
  List<SingleArchivedTrip> _mol2ah = [];
  List<SingleArchivedTrip> get endedTrips => [ ..._endedTrips];
  List<SingleArchivedTrip> get mol2ah => [ ..._mol2ah];

  double get totalPriceOfAllTrips {
    double ret = 0;
   if(filterIndex==0){
     for (var element in endedTrips) {
       ret += double.parse(element.price);
     }
   } else {
     for (var element in mol2ah) {
       ret += double.parse(element.price);
     }
   }
    return ret;
  }

  bool get isArchiveDataEmpty {
    return _totals.isEmpty && (_endedTrips.isEmpty||_mol2ah.isEmpty);
  }

  bool _isFiltering = false;
  bool get isFiltering => _isFiltering;
  set isFiltering(value) {
    _isFiltering = value;
    notifyListeners();
  }

  List<SingleArchivedTrip> _filteredTrips = [];
  List<SingleArchivedTrip> get filteredTrips => [..._filteredTrips];

  DateTime? fromDate;
  String get fromDateTxt {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (fromDate == null) return lang == 'en' ? 'Not set' : 'غير محدد';
    return DateFormat.yMd().format(fromDate!);
  }

  DateTime? toDate;
  String get toDateTxt {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (toDate == null) return lang == 'en' ? 'Not set' : 'غير محدد';
    return DateFormat.yMd().format(toDate!);
  }
  late ArchiveModel archiveData;
  Future syncData(String userId) async {
      archiveData = await ServiceCollector.getInstance()
        .tripsService
        .getArchiveData(userId);

    _totals = archiveData.resultTripsToCreator;
    _endedTrips = archiveData.allArchivedTrips;
    _mol2ah = archiveData.allownedArchivedTrips;
    notifyListeners();
  }

  void filterByDate(BuildContext context, String userId) async {
    isFiltering = true;
    if (fromDate == null || toDate == null) {
      _filteredTrips = [];
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select dates fist')));
      isFiltering = false;
      return;
    }

    _filteredTrips = await ServiceCollector.getInstance()
        .tripsService
        .getArchivedTripsFilteredByDate(
            userId,
            '${fromDate!.year.toString()}-${fromDate!.month.toString()}-${fromDate!.day.toString()}',
            '${toDate!.year.toString()}-${toDate!.month.toString()}-${toDate!.day.toString()}');

    if (_filteredTrips.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Results')));
    }

    isFiltering = false;
  }

  void setFromDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100))
        .then((value) {
      fromDate = value;

      notifyListeners();
    });
  }

  void setToDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100))
        .then((value) {
      toDate = value;
      notifyListeners();
    });
  }
}
