import 'package:touresco/Interfaces/i_auth.dart';
import 'package:touresco/Interfaces/i_chat.dart';
import 'package:touresco/Interfaces/i_expenses.dart';
import 'package:touresco/Interfaces/i_meta_data.dart';
import 'package:touresco/Interfaces/i_trips.dart';

class ServiceCollector {
  static final ServiceCollector _serviceCollector =
      ServiceCollector._internal();

  ServiceCollector._internal();

  static ServiceCollector getInstance() => _serviceCollector;

  late IAuth _authService;
  IAuth get authService => _authService;

  late IMetaData _metaDataService;
  IMetaData get metaDataService => _metaDataService;

  late ITrips _tripsService;
  ITrips get tripsService => _tripsService;

  late IExpenses _expensesService;
  IExpenses get expensesService => _expensesService;

  late IChat _chatService;
  IChat get chatService => _chatService;

  String currentLanguage = 'en';

  void injectFixedServices(
      {required IAuth authService,
      required IMetaData metaDataService,
      required ITrips tripsService,
      required String currentLanguage,
      required IExpenses expensesService,
      required IChat chatService}) {
    _authService = authService;
    _metaDataService = metaDataService;
    _tripsService = tripsService;
    _expensesService = expensesService;
    _chatService = chatService;

    this.currentLanguage = currentLanguage;
  }
}
