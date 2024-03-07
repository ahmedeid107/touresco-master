import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:touresco/Interfaces/i_expenses.dart';
import 'package:touresco/Interfaces/i_trips.dart';
import 'package:touresco/models/trip_details_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/services/app_communication_service.dart';
import 'package:touresco/services/service_collector.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../models/meun.dart';

class TripDetailsViewModel with ChangeNotifier {
  final ITrips tripService;
  final IExpenses expensesService;
  final BuildContext mainContext;

  TripDetailsViewModel(
      {required this.tripService,
      required this.expensesService,
      required this.mainContext});

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  TripDetailsModel _trip = TripDetailsModel(
    id: '',
    userId: '',
    status: '',
    Trip_Unchangable_Id: '',
    tripCompanyName: '',
    tripPrice: 0,
    tripResponseTime: '',
    isOwner: false,
    tripAddedDate: DateTime(0, 0, 0).toString(),
    tripSeenStatus: '',
    tripPaymentDate: DateTime(0, 0, 0).toString(),
    tripNotes: '',
    programs: [],
    expenses: [],
    flightNumber: '',
    passengers: [],
    transferStatus: TransferStatus.none,
    motionRequestStatus: MotionRequestStatus.none,
    tripApprovalId: '',
    tripDateConflictStatus: '0',
    tripChatMessagesNumber: '0',
    sourceId: null,
    tripArchivedDate: '',
  );

  TripDetailsModel get trip => _trip;

  String currentTripId = '';
  String currentTripSource = '';

  bool _isLoadingTrip = false;

  bool get isLoadingTrip => _isLoadingTrip;

  set isLoadingTrip(value) {
    _isLoadingTrip = value;
    notifyListeners();
  }

  bool _isExpandableGeneralInformation = true;

  bool get isExpandableGeneralInformation => _isExpandableGeneralInformation;

  set isExpandableGeneralInformation(final bool value) {
    _isExpandableGeneralInformation = value;
    notifyListeners();
  }

  bool _isExpandableExpenses = false;

  bool get isExpandableExpenses => _isExpandableExpenses;

  set isExpandableExpenses(final bool value) {
    _isExpandableExpenses = value;
    notifyListeners();
  }

  bool _isExpandableTripProgram = false;

  bool get isExpandableTripProgram => _isExpandableTripProgram;

  set isExpandableTripProgram(final bool value) {
    _isExpandableTripProgram = value;
    notifyListeners();
  }

  bool _isExpandablePassenger = false;

  bool get isExpandablePassenger => _isExpandablePassenger;

  set isExpandablePassenger(final bool value) {
    _isExpandablePassenger = value;
    notifyListeners();
  }

  bool _isExpandableNotes = false;

  bool get isExpandableNotes => _isExpandableNotes;

  set isExpandableNotes(final bool value) {
    _isExpandableNotes = value;
    notifyListeners();
  }

  List<MenuItemASD> menuItems = [
    MenuItemASD(
        id: 'addExpenses',
        text: ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Add Expenses'
            : 'اضافة مصاريف',
        isEnabled: false),
    MenuItemASD(
        id: 'transfer',
        text: ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Transfer Trip'
            : 'إعادة توجيه الرحله',
        isEnabled: false),
    MenuItemASD(
        id: 'sendNotification',
        text: ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Send important notice'
            : 'ارسال اشعار مهم',
        isEnabled: false),
    MenuItemASD(
        id: 'print',
        text: ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Print Manifest'
            : 'بيانات الرحلة',
        isEnabled: false),
  ];

// #region Functions

  Future syncAndFetchTrip(String id) async {
    isLoadingTrip = true;

    try {
      _trip = await ServiceCollector.getInstance().tripsService.getTripDetails(
          id,
          currentTripSource,
          Provider.of<AuthProvider>(mainContext, listen: false).user.id);
print("SSSSSSSSSSSSSSSSS ${_trip.isOwner}");
print("SSSSSSSSSSSSSSSSS ${_trip.status}");
//AddExp
      menuItems[0].isEnabled = (_trip.status == '3') ||
          (_trip.status == '13') ||
          (_trip.status == '23');

//Transfer Trip
      menuItems[1].isEnabled = ((_trip.status == '3') ||
              (_trip.status == '13' && currentTripSource != '3') ||
              (_trip.status == '23')) &&
          _trip.transferStatus == TransferStatus.canBeTransferred;

//Send Notification
      menuItems[2].isEnabled = _trip.status == '3' ||
          _trip.status == '4' ||
          _trip.status == '13' ||
          _trip.status == '14' ||
          _trip.status == '23' ||
          _trip.status == '24';

//Print Manifest
      menuItems[3].isEnabled = (_trip.status != '2') &&
          (_trip.status != '12') &&
          (_trip.status != '22');

      isLoadingTrip = false;
    } catch (error) {
      print("SASDASDASD ${error}");
      rethrow;
    }
  }

  void reset() {
    _trip = TripDetailsModel(
      id: '',
      Trip_Unchangable_Id: '',
      userId: '',
      status: '',
      tripCompanyName: '',
      tripPrice: 0,
      tripResponseTime: '',
      tripAddedDate: DateTime(0, 0, 0).toString(),
      tripSeenStatus: '',
      tripPaymentDate: DateTime(0, 0, 0).toString(),
      tripNotes: '',
      programs: [],
      flightNumber: '',
      isOwner: false,
      expenses: [],
      transferStatus: TransferStatus.none,
      passengers: [],
      motionRequestStatus: MotionRequestStatus.none,
      tripApprovalId: '',
      tripDateConflictStatus: '0',
      tripChatMessagesNumber: '0',
      sourceId: null,
      tripArchivedDate: '',
    );

    currentTripId = '';

    menuItems = [
      MenuItemASD(
          id: 'addExpenses',
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Add Expenses'
              : 'اضافة مصاريف',
          isEnabled: false),
      MenuItemASD(
          id: 'transfer',
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Transfer Trip'
              : 'إعادة توجيه الرحله',
          isEnabled: false),
      MenuItemASD(
          id: 'sendNotification',
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Send important notice'
              : 'ارسال اشعار مهم',
          isEnabled: false),
      MenuItemASD(
          id: 'print',
          text: ServiceCollector.getInstance().currentLanguage == 'en'
              ? 'Print Manifest'
              : 'بيانات الرحلة',
          isEnabled: false),
    ];
    isLoadingTrip = false;
    isExpandableGeneralInformation = true;
    isExpandableTripProgram = false;
    isExpandableExpenses = false;
    isExpandablePassenger = false;
  }

  void agreeToThisTrip(BuildContext context) async {
    isLoadingTrip = true;

    try {
      bool isDone = await tripService.takeTrip(
          Provider.of<AuthProvider>(context, listen: false).user.id,
          currentTripId,
          currentTripSource);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  void cancelTrip(BuildContext context , String text) async {
    isLoadingTrip = true;

    try {
      bool isDone = await tripService.cancelTrip(
        currentTripId,
        Provider.of<AuthProvider>(context, listen: false).user.id,
        trip.status,
        currentTripSource,
          trip.isOwner
      );
      if (isDone) {
        print("SSSSSSsssss ${isDone}"  );
        Navigator.of(scaffoldState.currentState!.context).pop();
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  bool get canUserEndTrip {
    return DateTime.now().isAfter(DateTime.parse(trip.programs.last.date));
  }

  void endTrip(BuildContext context) async {
    if (!canUserEndTrip) {
      String msg = ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'You can  not end this trip before last program date'
          : 'لايمكنك انهاء هذه الرحلة قبل تاريخ اخر برنامج';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        msg,
      )));
      return;
    }

    isLoadingTrip = true;
    try {
      bool isDone = await tripService.endTrip(
          Provider.of<AuthProvider>(context, listen: false).user.id,
          currentTripId,
          currentTripSource);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  void getPaidForAllTrip(BuildContext context, bool needSave) async {
    isLoadingTrip = true;
    try {
      bool isDone = await tripService.completeAllExpensesForTrip(
          Provider.of<AuthProvider>(context, listen: false).user.id,
          currentTripId,
          currentTripSource,
          needSave);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  void requestMovemntRequest(BuildContext context) async {
    isLoadingTrip = true;
    try {
      bool isDone = await tripService.requestMovemntMotion(
          currentTripId,
          Provider.of<AuthProvider>(context, listen: false).user.id,
          currentTripSource);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  Future showMovementRequest(BuildContext context) async {
    String url = await tripService.getRequestMotionUrl(
        trip.tripApprovalId, currentTripSource,
        Provider.of<AuthProvider>(context, listen: false).user.id,trip.id);
    final parsed = Uri.parse(url);

    if (await canLaunchUrl(parsed)) {
      if (Platform.isAndroid) {
        //In Android pdf should open inside pdfviewer
        await launchUrl(parsed,
            mode: LaunchMode
                .externalApplication); //To show pdf file using external application in phone that support .pdf
      } else if (Platform.isIOS) {
        await launchUrl(parsed);
      }
    }
  }

  Future showManiFest(String userId) async {
    String url =
        await tripService.getManifestUrl(currentTripId, currentTripSource,userId);
    final parsed = Uri.parse(url);

    if (await canLaunchUrl(parsed)) {
      if (Platform.isAndroid) {
        //In Android pdf should open inside pdfviewer
        await launchUrl(parsed,
            mode: LaunchMode
                .externalApplication); //To show pdf file using external application in phone that support .pdf
      } else if (Platform.isIOS) {
        await launchUrl(parsed);
      }
    }
  }

  Future callNumber() async {
    String url = 'tel://${trip.contactPhoneNumber}';
    final parsed = Uri.parse(url);

    if (await canLaunchUrl(parsed)) {
      if (Platform.isAndroid) {
        //In Android pdf should open inside pdfviewer
        await launchUrl(parsed,
            mode: LaunchMode
                .externalApplication); //To show pdf file using external application in phone that support .pdf
      } else if (Platform.isIOS) {
        await launchUrl(parsed);
      }
    }
  }

  Future showPassengerSignn() async {
    String url = await ServiceCollector.getInstance()
        .metaDataService
        .getPassengerSignUrl(trip.tripCompanyName, trip.signName!);
    final parsed = Uri.parse(url);

    if (await canLaunchUrl(parsed)) {
      if (Platform.isAndroid) {
        //In Android pdf should open inside pdfviewer
        await launchUrl(parsed,
            mode: LaunchMode
                .externalApplication); //To show pdf file using external application in phone that support .pdf
      } else if (Platform.isIOS) {
        await launchUrl(parsed);
      }
    }
  }

  Future paymentDoneForExpenses(BuildContext context, expensesId) async {
    isLoadingTrip = true;
    try {
      bool isDone = await expensesService.paymentDoneForExpenses(
          Provider.of<AuthProvider>(context, listen: false).user.id,
          expensesId,
          currentTripSource);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  Future agreeNewExpensesByDriver(BuildContext context, expensesId) async {
    isLoadingTrip = true;
    try {
      bool isDone = await expensesService.agreeNewExpensesByDriver(
          Provider.of<AuthProvider>(context, listen: false).user.id,
          expensesId,
          currentTripSource);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  Future cancelNewExpensesByDriver(BuildContext context, expensesId) async {
    print("ASDADSSAD ${112}");
    isLoadingTrip = true;
    try {
      bool isDone = await expensesService.cancelNewExpensesByDriver(
          Provider.of<AuthProvider>(context, listen: false).user.id,
          expensesId,
          trip.isOwner);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  Future cancelPendingExpenses(BuildContext context, expensesId) async {
    isLoadingTrip = true;
    try {
      bool isDone = await expensesService.cancelPendingExpenses(
          Provider.of<AuthProvider>(context, listen: false).user.id,
          expensesId,
          trip.isOwner);

      if (isDone) {
        await syncAndFetchTrip(currentTripId);
      } else {
        isLoadingTrip = false;
      }
    } catch (error) {
      isLoadingTrip = false;
      AppCommunicationService.showGlobalSnackBar(error.toString());
    }
  }

  void navigateBack(BuildContext context) {
    // String? userId = Provider.of<AuthProvider>(context, listen: false).user.id;
    Navigator.pop(scaffoldState.currentState!.context, false);
  }

  String _passengerLoader = 'none';

  String get passengerLoader => _passengerLoader;

  set passengerLoader(value) {
    _passengerLoader = value;
    notifyListeners();
  }

  Future<void> setSingleProgramToEnd(
    String programId,
    BuildContext context,
  ) async {
    SingleTripProgramData program =
        trip.programs.firstWhere((element) => element.id == programId);

//edit

    if (!(DateTime.now().isAfter(DateTime.parse(program.date)))) {
      String msg = ServiceCollector.getInstance().currentLanguage == 'en'
          ? 'You can not mark this program as done before the program date start'
          : 'لايمكنك وضع علامة (تم انجاز البرنامج) قبل الدخول بتاريخ يوم البرنامج';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        msg,
      )));
      return;
    }

    passengerLoader = programId;
    try {
      String? userId =
          Provider.of<AuthProvider>(context, listen: false).user.id;

      var a = await tripService.setSingleProgramToEnd(
          programId, trip.sourceId.toString(), userId);
      _trip
          .programs[
              _trip.programs.indexWhere((element) => element.id == programId)]
          .status = a;
      notifyListeners();
      if (a == "403") {
        String msg = ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'You cannot mark (program completed) You are not the last driver for the trip'
            : 'لايمكنك وضع علامة (تم انجاز البرنامج) أنت لست آخر سائق للرحلة';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          msg,
        )));
        return;
      }
    } catch (_) {
    } finally {
      passengerLoader = 'none';
    }
    notifyListeners();
  }

// #endregion


  void takeGeneralRole(String userId) async {
    await ServiceCollector.getInstance()
        .metaDataService
        .takeGeneralRole(userId);

  }
}
