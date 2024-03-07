import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/language_provider.dart';
import 'package:touresco/providers/trips_provider.dart';
import 'package:touresco/providers/view_models/finance_view_model.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';

import '../providers/transfer_provider.dart';
import '../providers/view_models/add_expenses_dialog_view_model.dart';
import '../providers/view_models/archive_view_model.dart';
import '../providers/view_models/change_password_dialog_view_model.dart';
import '../providers/view_models/notifications_view_model.dart';
import '../providers/view_models/profile_view_model.dart';
import '../providers/view_models/select_office_sheet_view_model.dart';
import '../providers/view_models/take_role_view_model.dart';
import '../providers/view_models/transfer_trip_dialog_view_model.dart';

List<SingleChildWidget> injectProviders() {
  return [
    ChangeNotifierProvider(
        create: (context) => LanguageProvider(
            defaultLanguage: ServiceCollector.getInstance().currentLanguage)),
    ChangeNotifierProvider(
        create: (context) => AuthProvider(
            authService: ServiceCollector.getInstance().authService)),
    ChangeNotifierProvider(create: (context) => TakeRoleViewModel()),
    ChangeNotifierProvider(create: (context) => ProfileViewModel()),
    ChangeNotifierProvider(create: (context) => NotificationsViewModel()),
    ChangeNotifierProvider(create: (context) => TransferProvider()),
    ChangeNotifierProvider(create: (context) => TransferTripDialogViewModel()),
    ChangeNotifierProvider(
      create: (context) => SelectOfficeSheetViewModel(
          ServiceCollector.getInstance().metaDataService),
    ),

    ChangeNotifierProvider(
        create: (context) => TripsProvider(
            tripsService: ServiceCollector.getInstance().tripsService)),
    ChangeNotifierProvider(
        create: (context) => FinacneViewModel(
            expensesService: ServiceCollector.getInstance().expensesService)),
    ChangeNotifierProvider(
        create: (context) => TripDetailsViewModel(
            tripService: ServiceCollector.getInstance().tripsService,
            expensesService: ServiceCollector.getInstance().expensesService,
            mainContext: context)),

    // new
    ChangeNotifierProvider(create: (context) => AddExpensesDialogViewModel()),
    ChangeNotifierProvider(create: (context) => ArchiveViewModel()),
    ChangeNotifierProvider(create: (context) => ChangePasswordDialogViewModel()),
     // ChangeNotifierProvider(create: (context) => ArchiveViewModel()),


  ];
}
