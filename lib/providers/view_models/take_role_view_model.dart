import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:touresco/models/meun.dart';
import 'package:touresco/models/event_model.dart';
import 'package:touresco/models/location_model.dart';
import 'package:touresco/services/service_collector.dart';
import '../../screens/TableCalendarScreen.dart';

class TakeRoleViewModel with ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  int? numOfMyTrips;
  int? numOfDivertedTrips;
  int? numOfMadeen;
  int? numOfdaen;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void getEventNumber(id) async {

    events =
        await ServiceCollector.getInstance().metaDataService.getEvents(1, id);
    numOfMyTrips = events.length;

    events =
        await ServiceCollector.getInstance().metaDataService.getEvents(2, id);
    numOfDivertedTrips = events.length;

    events =
        await ServiceCollector.getInstance().metaDataService.getEvents(3, id);
    numOfMadeen = events.length;

    events =
        await ServiceCollector.getInstance().metaDataService.getEvents(4, id);
    numOfdaen = events.length;
  }

  Map<String, dynamic> notificationMessenger = {};

  List<MenuItemASD> getLists(id) {
    getEventNumber(id);

    List<MenuItemASD> menuItems = [
      MenuItemASD(
          id: "1",
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'My Private Trips'
              : 'رحلاتي الخاصة',
          isEnabled: true,
          num: numOfMyTrips),
      MenuItemASD(
          id: "2",
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Transfer flights'
              : 'رحلاتي المحولة',
          isEnabled: true,
          num: numOfDivertedTrips),
      MenuItemASD(
          id: "4",
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Required to pay'
              : 'مدين (عليك دفعها)',
          isEnabled: true,
          num: numOfMadeen),
      MenuItemASD(
          id: "3",
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Your dues'
              : 'دائن (عليك قبضها)',
          isEnabled: true,
          num: numOfdaen),
    ];

    return menuItems;
  }

  var c = EventController();
  List<List<innerModel>> list = [];

  void syncEvents(int type, String id, lang) async {
    c = EventController();
    list = [];
    isLoading = true;
    if (list.isEmpty) {
      list.add([
        innerModel(Colors.yellow, lang.transferFlights2),
        innerModel(Colors.green, lang.moreThanOneProgram),
      ]);
      list.add([
        innerModel(Colors.blue, lang.transferFlights2),
        innerModel(Colors.brown, lang.moreThanOneProgram),
      ]);
      list.add([
        innerModel(Colors.red, lang.oneBatch),
        innerModel(Colors.orange, lang.moreThanOneBatch),
      ]);
      list.add([
        innerModel(Colors.red, lang.oneBatch),
        innerModel(Colors.orange, lang.moreThanOneBatch),
      ]);
    }
    events = await ServiceCollector.getInstance()
        .metaDataService
        .getEvents(type, id);
    events.forEach((element) {
      var o = events.where(
          (element0) => element0.date.toString() == element.date.toString());


      final event = CalendarEventData(
        date: element.date ?? DateTime.now(),
        event: element.body,
        title: element.title ?? "",
        description:
            "${element.body},${element.type},${element.tripId},${element.path}",
        color: list[type - 1][o.length == 1 ? 0 : 1].color,
      );
      c.add(event);
    });

    isLoading = false;
    notifyListeners();
  }

  void syncNotificationProfile(String userId) async {
    notificationMessenger = await ServiceCollector.getInstance()
        .metaDataService
        .syncProfileNotifications(userId);
    notifyListeners();
  }

  bool _hasGeneralRole = false;

  bool get hasGeneralRole => _hasGeneralRole;

  set hasGeneralRole(value) {
    _hasGeneralRole = value;
    notifyListeners();
  }

  bool _hasSpecificRole = false;

  bool get hasSpecificRole => _hasSpecificRole;

  set hasSpecificRole(value) {
    _hasSpecificRole = value;
    notifyListeners();
  }

  String currentGeneralRole = '';
  String currentSpecificRole = '';
  String currentCity = '';
  String currentDistrict = '';

// #region City Selector
  List<CityModel> _cities = [];

  List<CityModel> get cities => [..._cities];
  String? _selectedCity;

  String? get selectedCity => _selectedCity;

  set selectedCity(value) {
    _selectedCity = value;
    notifyListeners();
  }

  List<EventModel> events = [];

  // #endregion
  // #region District Selector
  List<DistrictModel> _districts = [];

  List<DistrictModel> get districts => [..._districts];

  set district(value) {
    _districts = value;
    notifyListeners();
  }

  String? _selectedDistrictId;

  String? get selectedDistrictId => _selectedDistrictId;

  set selectedDistrictId(value) {
    _selectedDistrictId = value;
    notifyListeners();
  }

  // #endregion
  Future checkRoleStatus(String userId) async {
    isLoading = true;
    Map<String, dynamic> mapData = await ServiceCollector.getInstance()
        .metaDataService
        .checkCurrentRole(userId);

    _hasGeneralRole = mapData['General_Reservation'];
    currentGeneralRole = mapData['General_Role'];

    _hasSpecificRole = mapData['Spesfic_Reservation'];
    currentSpecificRole = '0';
    String lang = ServiceCollector.getInstance().currentLanguage;

    if (_hasSpecificRole) {
      var cities = mapData['Spesfic_RCity'] as Map;
      var citiesData = cities["Data"] as List;
      if (citiesData.isNotEmpty) {
        currentCity = lang == 'en'
            ? citiesData[0]["City_English_Name"]
            : citiesData[0]["City_Arabic_Name"];
      }
      var district = mapData['Spesfic_RDistrict'] as Map;
      var districtData = district["District"] as List;
      if (districtData.isNotEmpty) {
        currentDistrict = lang == 'en'
            ? districtData[0]["District_En_Name"]
            : districtData[0]["District_Ar_Name"];
      }
    }
    if (_hasSpecificRole == false) {
      _cities =
          await ServiceCollector.getInstance().metaDataService.getCities();
    }

    isLoading = false;
    notifyListeners();
  }

  void takeGeneralRole(String userId) async {
    await ServiceCollector.getInstance()
        .metaDataService
        .takeGeneralRole(userId);

    await checkRoleStatus(userId);
  }

  void removeGeneralRole(String userId) async {
    await ServiceCollector.getInstance()
        .metaDataService
        .removeGeneralRole(userId);

    await checkRoleStatus(userId);
  }

  void syncDistricts(String cityId) async {
    selectedDistrictId = null;
    district = [].cast<DistrictModel>();

    _districts = await ServiceCollector.getInstance()
        .metaDataService
        .getDistricts(cityId);

    notifyListeners();
  }

  void takeSpecificRole(String userId) async {
    await ServiceCollector.getInstance()
        .metaDataService
        .takeSpecificRole(userId, selectedCity!, selectedDistrictId!);
    await checkRoleStatus(userId);
  }

  void removeSpecificRole(String userId) async {
    await ServiceCollector.getInstance()
        .metaDataService
        .removeSpecificRole(userId);
    await checkRoleStatus(userId);
  }

  void syncNotificationProfileNew(String userId) async {
    notificationMessenger = await ServiceCollector.getInstance()
        .metaDataService
        .syncProfileNotificationsNew(userId);

    notifyListeners();
  }

  int numOfMessages = 0;

  void syncGroupNumber(String userId) async {
    numOfMessages = 0;
    await ServiceCollector.getInstance()
        .chatService
        .syncGroups(
          userId,
        )
        .then((value) {
      numOfMessages = 0;
      value.forEach((element) {
        numOfMessages += element.countNotSeen;
      });
      notifyListeners();
    });
  }

  bool haveMarkNote = false;

  void syncEvent(String userId) async {
    numOfMessages = 0;
    await ServiceCollector.getInstance()
        .chatService
        .syncEvents(userId)
        .then((value) {
      haveMarkNote = value;
      notifyListeners();
    });
  }
}
