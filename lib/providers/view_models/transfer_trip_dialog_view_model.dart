import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/single_driver_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';

class TransferTripDialogViewModel with ChangeNotifier {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool _isTransferToPublicRole = true;
  var listItemControllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];
  String tripPaymentDate = '';
  final List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: '1',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Instant Payment'
            : 'دفع فوري')),
    DropdownMenuItem(
        value: '2',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Pay when paying for the flight'
            : 'دفع عند تسديد الرحلة')),
  ];

  void paymentType(value, index) {
    listItemControllers[index][2].text = value;
    notifyListeners();
  }

  void add(context) {
    if (listItemControllers.isEmpty) {
      listItemControllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
      notifyListeners();
    } else {
      if (check()) {
        listItemControllers.add([
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ]);
        notifyListeners();
      } else {
        Fluttertoast.showToast(
          msg: 'en' == 'en' ? 'please fill data' : 'املأ البيانات',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }

  bool check() {
    return listItemControllers.last[0].text.isNotEmpty &&
        listItemControllers.last[1].text.isNotEmpty &&
        listItemControllers.last[2].text.isNotEmpty;
  }

  void delete() {
    listItemControllers.removeLast();
    notifyListeners();
  }

  bool get isTransferToPublicRole => _isTransferToPublicRole;

  set isTransferToPublicRole(value) {
    _isTransferToPublicRole = value;
    notifyListeners();
  }

  String toId = '';
  String note = '';
  String price = '';

  String commission = '0';
  bool _isAbleToTransfer = false;

  bool get isAbleToTransfer => _isAbleToTransfer;

  set isAbleToTransfer(value) {
    _isAbleToTransfer = value;
    notifyListeners();
  }

  String errorDriverStatus = 'none';

  List<SingleDriverModel> _drivers = [];

  List<SingleDriverModel> get drivers => [..._drivers];

  DateTime? paymentDate;

  String get paymentDateText {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (paymentDate == null) return lang == 'en' ? 'Not set' : 'غير محدد';
    return DateFormat.yMd().format(paymentDate!);
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  // work here
  void submitForm(
    BuildContext context,
    BuildContext context2,
    String path,
    bool isUpdate,
  ) async {
    if (!isTransferToPublicRole) {
      if (toId.isEmpty) {
        errorDriverStatus = 'error';
        notifyListeners();
      }
    }
    if (paymentDate == null) {
      String lang = ServiceCollector.getInstance().currentLanguage;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            lang == 'en' ? 'Payment date not set' : "تاريخ التسديد غير محدد"),
      ));
    }

    isLoading = true;

    List<Map<String, dynamic>> list = [];
    listItemControllers.forEach((element) {
      list.add({
        "Outlay_Name": element[0].text,
        "Outlay_Amount": element[1].text,
        "Outlay_Type": element[2].text,
      });
    });

    bool isDone = await ServiceCollector.getInstance()
        .tripsService
        .transferTrip(
          isTransferToPublicRole: isTransferToPublicRole,
          tripId:
              Provider.of<TripDetailsViewModel>(context, listen: false).trip.id,
          fromUserId: Provider.of<AuthProvider>(context, listen: false).user.id,
          toUserId: isTransferToPublicRole ? '' : toId,
          note: note,
          price: price,
          commission: commission,
          paymentDate: paymentDate.toString(),
          isAbleToTransfer: isAbleToTransfer,
          path: path,
          arr: list,
          isUpdate: isUpdate,
        );
    isLoading = false;

    if (isDone) {
      Navigator.of(context).pop();
    }
  }

  void submitForm12({
    required BuildContext context,
    required String path,
    required bool isTransferToPublicRole22,
    required bool isUpdate,
    required String toID1,
    required String commission22,
    required String note22,
    required String price22,
    required String paymentDate11,
    required bool isAbleToTransfer11,
  }) async {
    if (!isTransferToPublicRole22) {
      if (toID1.isEmpty) {
        errorDriverStatus = 'error';
        notifyListeners();
      }
    }

    isLoading = true;
    List<Map<String, dynamic>> arrMap = [];
    listItemControllers.forEach((element) {
      Map<String, dynamic> map = {};
      map['Outlay_Name'] = element[0].text;
      map['Outlay_Amount'] = element[1].text;
      map['Outlay_Type'] = element[2].text;
      arrMap.add(map);
    });
    bool isDone = await ServiceCollector.getInstance()
        .tripsService
        .transferTrip(
            isTransferToPublicRole: isTransferToPublicRole22,
            tripId: Provider.of<TripDetailsViewModel>(context, listen: false)
                .trip
                .id,
            arr: arrMap,
            isUpdate: isUpdate,
            fromUserId:
                Provider.of<AuthProvider>(context, listen: false).user.id,
            toUserId: isTransferToPublicRole22 ? '' : toID1,
            note: note22,
            price: price22,
            commission: commission22,
            paymentDate: paymentDate11,
            isAbleToTransfer: isAbleToTransfer11,
            path: path);
    isLoading = false;

    if (isDone) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  void searchByName(String name) async {
    _drivers =
        await ServiceCollector.getInstance().metaDataService.searchByName(name);
    notifyListeners();
  }

  void selectUser(String id) {
    if (toId == id) return;
    toId = id;
    errorDriverStatus = 'selected';
    notifyListeners();
  }

  bool isIdSelected(String id) {
    return toId == id;
  }

  void setPaymentDate(BuildContext context, String tripPaymentDate) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(2100))
        .then((value) {
      if (DateTime.now().year <= value!.year &&
          value.day >= DateTime.now().day &&
          DateTime.now().month <= value.month) {
        paymentDate = value;
      } else {
        String lang = ServiceCollector.getInstance().currentLanguage;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(lang == 'en'
              ? 'Choose a payment date after the day date'
              : "يجب اختيار تاريخ تسديد بعد تاريخ اليوم"),
        ));
      }
      notifyListeners();
    });
  }

  void setPaymentDatePrice(BuildContext context, int index) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(2100))
        .then((value) {
      try {
        listItemControllers[index][2].text = DateFormat.yMd().format(value!);
        notifyListeners();
      } catch (Ex) {}
    }).catchError((onError) {});
  }

  void getPaymentDate(BuildContext context, TextEditingController controller) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(2100))
        .then((value) {
      controller.text = value.toString();
      notifyListeners();
    });
  }
}
