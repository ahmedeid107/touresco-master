import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:touresco/firebase_options.dart';
import 'package:touresco/l10n/l10n.dart';
import 'package:touresco/providers/language_provider.dart';
import 'package:touresco/services/app_communication_service.dart';
import 'package:touresco/services/app_language_service.dart';
import 'package:touresco/services/auth_service.dart';
import 'package:touresco/services/meta_data_service.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/services/sql_chat_service.dart';
import 'package:touresco/services/sql_expenses_service.dart';
import 'package:touresco/services/sql_trips_service.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/FCM_SERVICE.dart';
import 'package:touresco/utils/navigation.dart';
import 'package:touresco/utils/providers.dart';
import 'package:touresco/utils/routes.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:touresco/components/wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ChatsHelper().initializeDatabase();
  String language = await AppLanguageService().syncDefaultLanguage();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);  await Initialization.initFirebaseMessaging();
  ScreenConfig.init(
      // Setup screen configuration (Design VALUES)
      onlyUpDownOrientation: true,
      designDeviceHeight: 844,
      designDeviceWidth: 390); // IPHONE 13

  ServiceCollector.getInstance().injectFixedServices(
    authService: AuthService(),
    metaDataService: MetaDataService(),
    tripsService: SQLTripsService(),
    expensesService: SQLExpensesService(),
    chatService: SQLChatService(),
    currentLanguage: language,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: injectProviders(),
        child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Touresco',
              navigatorKey: NavigationService.navigatorKey,
              scaffoldMessengerKey:
                  AppCommunicationService.rootScaffoldMessengerKey,
              theme: theme(),
              locale: Locale(languageProvider.currentLanguage),
              supportedLocales: L10n.all,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              routes: routes,
              home: const Wrappr(),
            );
          },
        ));
  }
}
