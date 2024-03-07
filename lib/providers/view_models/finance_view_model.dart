import 'package:flutter/material.dart';
import 'package:touresco/Interfaces/i_expenses.dart';
import 'package:touresco/models/single_finance_model.dart';

import 'package:touresco/services/service_collector.dart';

class FinacneViewModel with ChangeNotifier {
  final IExpenses expensesService;
  FinacneViewModel({required this.expensesService});

/*
  List<MenuItem> menuItems = [
    MenuItem(
        id: 'low',
        text: ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Lowest'
            : 'الادني قيمة',
        isEnabled: true),
    MenuItem(
        id: 'high',
        text: ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Highest'
            : 'الاعلى قيمة',
        isEnabled: true),
  ];
  */

  final List<DropdownMenuItem<String>> filterItems = [
    DropdownMenuItem(
        value: 'select',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Select to present results'
            : 'اختر لعرض النتائج')),
    DropdownMenuItem(
        value: 'dues',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Your dues'
            : 'دائن')),
    DropdownMenuItem(
        value: 'requiredToPay',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Required to pay'
            : 'مدين')),
  ];

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Map<String, dynamic> financeData = {
    'select': [],
    'dues': [],
    'requiredToPay': [],
  };

  String _filter = 'select';
  String get filter => _filter;
  set filter(value) {
    _filter = value;
    notifyListeners();
  }

  String get filterNameDisplay {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (filter == 'dues') {
      return lang == 'en' ? 'Your dues' : 'مستحقاتك';
    } else {
      return lang == 'en' ? 'Required to pay' : 'مطلوب التسديد';
    }
  }

  List<SingleFinanceModel> get finances => [...financeData[filter]];

  // ignore:
  // prefer_final_fields
  List<SingleFinanceModel> _financeSearched = [];
  List<SingleFinanceModel> get financeSearched => _financeSearched;
  String searchText = '';

  void syncFinances(String userId) async {
    isLoading = true;
    financeData = await expensesService.getAllUserFinances(userId);

    isLoading = false;
  }

/*
  void sortingFinances([bool byHighValue = true]) {
    if (byHighValue) {
      financeData[filter]
          .sort((b, a) => a.totalTripPrice.compareTo(b.totalTripPrice));
    } else {
      financeData[filter]
          .sort((a, b) => a.totalTripPrice.compareTo(b.totalTripPrice));
    }

    notifyListeners();
  }
  */

  void searchByName(String text) {

    _financeSearched.clear();

    if (text.isEmpty) {
      notifyListeners();
      return;
    }
    searchText = text;
    _financeSearched.addAll(finances);
    _financeSearched
        .retainWhere(((element) {
      return element.name.contains(text)||element.totalTripPrice.toInt().toString()==text ||element.id.toString()==text;
    }));

    notifyListeners();
  }
}
