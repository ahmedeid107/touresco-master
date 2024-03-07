import 'package:flutter/material.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:touresco/services/service_collector.dart';

class TransferredTripsViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isShowedFilter = false;

  bool get isShowedFilter => _isShowedFilter;
  set isShowedFilter(value) {
    _isShowedFilter = value;
    notifyListeners();
  }

  final List<DropdownMenuItemASD> menuItems = [

    DropdownMenuItemASD(
        value: 'pending',
        child: ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Pending approval'
            : 'في انتظار موافقة' ),

    // DropdownMenuItemASD(
    //     value: 'pendingByRole',
    //     child: ServiceCollector.getInstance().currentLanguage == 'en'
    //         ? 'Pending by role'
    //         : 'معلقة حسب الدور'),

    DropdownMenuItemASD(
        value: 'active',
        child:   ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Active'
            : 'الفعالة'),
    // DropdownMenuItemASD(
    //     value: 'canceldByOwner',
    //     child:  (ServiceCollector.getInstance().currentLanguage == 'en'
    //         ? 'Canceled flights'
    //         : 'الرحلات الملغاة')),
    DropdownMenuItemASD(
        value: 'canceldByDriver',
        child:  (ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Rejected flights'
            : 'الرحلات المرفوضة')),
    // DropdownMenuItemASD(
    //     value: 'archived',
    //     child:  (ServiceCollector.getInstance().currentLanguage == 'en'
    //         ? 'Archived'
    //         : 'المؤرشفة')),

  ];

  String _filter = 'pending';
  String get filter => _filter;
  set filter(value) {
    _filter = value;
    notifyListeners();
  }

  Map<String, dynamic> trips = {
    'select': [],
    'pending': [],
    'active': [],
    'unpaid': [],
    'archived': [],
    'canceldByOwner': [],
    'canceldByDriver': [],
    'pendingByRole': [],
  };

  List<LightTripModel> get getTripsDependOnAppliedFilter => [...trips[filter]];


  // List<LightTripModel>  getAllTrips() {
  //   List<LightTripModel>  a = [];
  //  trips.forEach((key, value) { print(value);
  //  for(var i  in value as List <LightTripModel>){
  //    a.add(i);
  //};
  //})
  // return a ;
  // }

  Future syncTrips(String userId, [bool isInit = true]) async {
    if (!isInit) {
      isLoading = true;
    }
    trips = await ServiceCollector.getInstance()
        .tripsService
        .getTransferredTripsForUser(userId);

    if (!isInit) {
      isLoading = false;
    }
  }
}

class DropdownMenuItemASD{
  String value;
  String child;

  DropdownMenuItemASD({required this.value,required this.child});

}