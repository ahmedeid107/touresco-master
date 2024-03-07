import 'package:flutter/material.dart';

import '../models/car_size_model.dart';
import '../models/single_driver_model.dart';
import '../services/service_collector.dart';

class TransferProvider with ChangeNotifier {
  //19/4 code drop tripe type
  Future<List<CarSizeModel>> getAllCarSizes(String id) async {
    return await ServiceCollector.getInstance().authService.getAllSize(id);
  }

  final List<DropdownMenuItem<String>> menuItems = [
        const DropdownMenuItem(
        value: '-1',
        child: Text("")),
    DropdownMenuItem(
        value: '0',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Airport'
            : 'مطار')),
    DropdownMenuItem(
      value: '1',
      child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Full Day'
          : 'يوم كامل'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Border crossing'
          : 'معبر حدودي'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Program over a day'
          : 'برنامج اكثر من يوم'),
    ),
  ];
  final List<DropdownMenuItem<String>> requestTypes = [
    const DropdownMenuItem(
      value: '-1',
      child: Text(""),
    ),
    DropdownMenuItem(
      value: '0',
      child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'General request'
          : 'طلب عام'),
    ),
    DropdownMenuItem(
      value: '1',
      child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'urgent request'
          : 'طلب مستعجل'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'Request a specific vehicle'
          : 'طلب مركبه محدده'),
    ),
  ];
  // final List<DropdownMenuItem<String>> cities = [
  //   DropdownMenuItem(
  //       value: '0',
  //       child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
  //           ? 'Oman'
  //           : 'عمان')),
  //   DropdownMenuItem(
  //     value: '1',
  //     child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
  //         ? 'Alzarqa'
  //         : 'الزرقا'),
  //   ),
  //   DropdownMenuItem(
  //     value: '2',
  //     child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
  //         ? 'Wadi Rum'
  //         : 'وادي رم'),
  //   ),
  //   DropdownMenuItem(
  //     value: '3',
  //     child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
  //         ? 'al aqapa'
  //         : 'العقبة'),
  //   ),
  //   DropdownMenuItem(
  //     value: '4',
  //     child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
  //         ? 'Dead Sea'
  //         : 'البحر الميت'),
  //   ),
  // ];

// car type
  List<SingleDriverModel> _searchResults = [];

  List<SingleDriverModel> get searchResults => [..._searchResults];

  void searchForDrivers(
    String name,
  ) async {
    final data =
        await ServiceCollector.getInstance().metaDataService.searchByName(name);

//check if user joined before
    for (var element in data) {
      _searchResults.add(element);
    }

    notifyListeners();
  }

  Future<bool> sendTripData({
    required String user_id,
    required String requestType,
    required String tripType,
    required String carType,
    required String carSize,
    required String flightNumber,
    required List ways,
    required String driverID,
    required String city,
    required String district,
    required String phoneToCommunity,
    required String touristName,
    required String nationality,
    required String passngerpassport,
    required String ismSha5sa,
    required List press,
    required List outlaies,
    required String price,
    required String dateTravle,
    required String timeTravle,
    required String note,
    required String trip_direction,
    required bool isTheFlightTransferable,
    required bool expensesPriceDetails,
  }) async {
    return await ServiceCollector.getInstance().metaDataService.sendTrip(
        user_id: user_id,
        carSize: carSize,
        carType: carType,
        city: city,
        dateTravle: dateTravle,
        district: "1",
        driverID: driverID,
        expensesPriceDetails: expensesPriceDetails,
        flightNumber: flightNumber,
        nationality: nationality,
        note: note,
        outlaies: outlaies,
        ismSha5sa: ismSha5sa,
        press: press,
        passngerpassport: "123",
        price: price,
        isTheFlightTransferable: isTheFlightTransferable,
        phoneToCommunity: phoneToCommunity,
        ways: ways,
        timeTravle: timeTravle,
        requestType: requestType,
        touristName: touristName,
        trip_direction: trip_direction,
        tripType: tripType);
  }
}
