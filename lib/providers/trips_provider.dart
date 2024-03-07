import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/Interfaces/i_trips.dart';
import 'package:touresco/models/light_trip_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/services/service_collector.dart';

class TripsProvider with ChangeNotifier {
  final ITrips tripsService;
  TripsProvider({required this.tripsService});
//
//
// #region explore_nav
  List<LightTripModel> _trips = [];
  List<LightTripModel> get trips => [..._trips];

  // ignore: prefer_final_fields
  List<LightTripModel> _searchedTrips = []; //
  List<LightTripModel> get searchedTrips => [..._searchedTrips];
  String searchText = '';
// #endregion

// #region trips_nav

  int _filterIndex = 0;
  int get filterIndex => _filterIndex;
  set filterIndex(value) {
    _filterIndex = value;
    notifyListeners();
  }

  Map<String, List<LightTripModel>> userTrips = {
    // trips_nav
    'currentUserTrips': [],
    'pendingUserPaymentTrips': [],
    'archivedUserTrips': [],
  };

  bool userHavePublicRole = false;
  String userRole = '';

  List<LightTripModel> get getTripsDependOnStatusChange {
    if (filterIndex == 0) {
      // someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
      //
      // userTrips['currentUserTrips']
      return [...?userTrips['currentUserTrips']];
    } else if (filterIndex == 1) {
      return [...?userTrips['pendingUserPaymentTrips']];
    } else if (filterIndex == 2) {
      return [...?userTrips['archivedUserTrips']];
    } else {
      return [];
    }
  }

  String get currentNamedStatus {
    String lang = ServiceCollector.getInstance().currentLanguage;

    if (filterIndex == 0) {
      return lang == 'en' ? 'Current Trips' : 'الرحلات النشطة';
    } else if (filterIndex == 1) {
      return lang == 'en' ? 'Unpaid Trips' : 'الرحلات غير المدفوعة';
    } else if (filterIndex == 2) {
      return lang == 'en' ? 'Archived Trips' : 'الرحلات المنتهية';
    } else {
      return '';
    }
  }

  String get currentNamedStatusError {
    String lang = ServiceCollector.getInstance().currentLanguage;

    if (filterIndex == 0) {
      return lang == 'en' ? 'current trips' : 'رحلات نشطة';
    } else if (filterIndex == 1) {
      return lang == 'en' ? 'unpaid trips' : 'رحلات غير مدفوعة';
    } else if (filterIndex == 2) {
      return lang == 'en' ? 'archived trips' : 'رحلات منتهية';
    } else {
      return '';
    }
  }

// #endregion

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void syncAndFetchTrips(String id) async {
    isLoading = true;
    _trips = await tripsService.getDriverTrips(id);
    isLoading = false;
    // notifyListeners();
  }

  void searchForTrips(String text) {
    _searchedTrips.clear();

    if (text.isEmpty) {
      notifyListeners();
      return;
    }
    searchText = text;

    _searchedTrips.addAll(_trips.where((element) =>
        element.tripOwner.contains(text) ||
        element.tripType.typeNameEn.contains(text) ||
        element.tripType.typeNameAr.contains(text) ||
        element.tripDirection.tripDirectionAr.contains(text) ||
        element.tripRegionData.regionEn.contains(text) ||
        element.tripRegionData.regionAr.contains(text) ||
        element.tripRegionData.governorateAr.contains(text) ||
        element.tripRegionData.governorateEn.contains(text)));

    notifyListeners();
  }

  Future syncAndFetchUserTrips(String userId ,bool isOwner) async {
    userTrips = await tripsService.getAllUserTrips(userId, );
    notifyListeners();
  }

  Future syncCurrentRole(BuildContext context) async {
    Map<String, dynamic> mapData = await ServiceCollector.getInstance()
        .metaDataService
        .checkCurrentRole(
            Provider.of<AuthProvider>(context, listen: false).user.id);

    userHavePublicRole = mapData['General_Reservation'];
    userRole = mapData['General_Role'];
  }
}
