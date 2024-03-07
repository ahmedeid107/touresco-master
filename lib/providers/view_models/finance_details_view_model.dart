import 'package:flutter/material.dart';
import 'package:touresco/models/single_finance_trip_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:intl/intl.dart';

class FinanceDetailsViewModel with ChangeNotifier {
  final String tripSourceAsString;
  final String userId;
  final String officeId;

  FinanceDetailsViewModel(
      {required this.tripSourceAsString,
      required this.userId,
      required this.officeId});

  List<SingleTripFinanceModel> _trips = [];

  List<SingleTripFinanceModel> get trips => [..._trips];

  List<SingleTripFinanceModel> _filteredTrips = [];

  List<SingleTripFinanceModel> get filteredTrips => [..._filteredTrips];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isFiltering = false;

  bool get isFiltering => _isFiltering;

  set isFiltering(value) {
    _isFiltering = value;
    notifyListeners();
  }

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

  void syncTrips(String ownerType, String fillter) async {
    isLoading = true;
    print("ASDSAD officeId ${officeId} ads");
    print("ASDSAD tripSourceAsString ${tripSourceAsString} ads");
    print("ASDSAD ownerType ${ownerType} ads");
    print("ASDSAD fillter ${fillter} ads");
    _trips = await ServiceCollector.getInstance()
        .expensesService
        .getTripsRelatedWithCreatorByExpensesStatus(
            userId, officeId, tripSourceAsString, ownerType, fillter);
    isLoading = false;
  }

  void clearFilteredTrips() {
    _filteredTrips = [];
  }

  void filterByDate(BuildContext context, String userId, String ownerType,
      String type , ) async {
    isFiltering = true;
    if (fromDate == null || toDate == null) {
      _filteredTrips = [];
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select dates fist')));
      isFiltering = false;
      return;
    }

    _filteredTrips = await ServiceCollector.getInstance()
        .expensesService
        .filterTripsRelatedWithCreatorByPaymentDate(userId, officeId,
            fromDate!.toString(), toDate!.toString(), ownerType, type);
    if (_filteredTrips.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'No result found'
          : 'لا توجد نتائج للبحث')));

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
