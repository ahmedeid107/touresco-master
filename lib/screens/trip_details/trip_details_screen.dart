import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/loading_progress_default.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/screens/sheets/add_expenses_dialog.dart';
import 'package:touresco/screens/sheets/send_notification_dialog.dart';
import 'package:touresco/screens/trip_details/components/trip_details_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/services/app_communication_service.dart';
import 'package:touresco/services/service_collector.dart';

import '../../models/meun.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../utils/screen_config.dart';
import '../trip_trasfer/trip_transfer_screen.dart';

class TripDetailsScreen extends StatefulWidget {
  TripDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  String? type = "";

  String? details = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final lang = AppLocalizations.of(context);
    WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
      final p = Provider.of<TripDetailsViewModel>(context, listen: false);
      p.reset();
      p.currentTripId = routeData['id'];
      p.currentTripSource = routeData['path'];
      type = routeData['type'];
       details = routeData['details'];
      p.syncAndFetchTrip(routeData['id']).catchError((error) {
        AppCommunicationService.showGlobalSnackBar(error.toString());
        Navigator.pop(context);
      });
    }));
    return Consumer<TripDetailsViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          key: vm.scaffoldState,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: kPrimaryColor,
            titleSpacing: 0,
            leading: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[200],
                )),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${lang!.tripNumber} ${vm.trip.Trip_Unchangable_Id != "" ? vm.trip.Trip_Unchangable_Id : vm.trip.id}',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  vm.trip.tripCompanyName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenConfig.getFontDynamic(18),
                  ),
                ),
                details != null
                    ? Text(details!, style: textSubtitle(Colors.white))
                    : Container(),
              ],
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          body: vm.isLoadingTrip
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TripDetailsBody(vm: vm, type: type ?? ""),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (vm.trip.status != '22')
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    // ChatsHelper().deleteMessage();
                    Navigator.of(context).pushNamed('/chat_screen', arguments: {
                      "userId":
                          Provider.of<AuthProvider>(context, listen: false)
                              .user
                              .id,
                      "officeId": vm.trip.id,
                      "isOwner": vm.trip.isOwner,
                      "title":
                          '${lang.chatTripNumber} ${vm.trip.id} ${getTitleOfChat(vm.currentTripSource)}',
                      "tripSource": vm.currentTripSource,
                      "type": "0",
                      "isPrivate": true
                    }).then((value) {
                      vm.syncAndFetchTrip(vm.currentTripId);
                    });
                  },
                  child: Stack(children: [
                    const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    if (vm.trip.tripChatMessagesNumber != '0')
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            width: 10,
                            height: 10,
                          ))
                  ]),
                ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {},
                child: PopupMenuButton<MenuItemASD>(
                  onSelected: (value) async {
                    if (value.id == 'addExpenses') {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return AddExpensesDialog(
                              tripId: vm.trip.id,
                              driverId: Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .user
                                  .id,
                              tripSource: vm.currentTripSource,
                            );
                          });
                    }
                    if (value.id == 'transfer') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripTransferScreen(
                                source: vm.currentTripSource,
                                status: vm.trip.status,
                                isOwner: vm.trip.isOwner,
                                tripPaymentDate: vm.trip.tripPaymentDate),
                          ));
                    }
                    if (value.id == 'sendNotification') {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return SendNotificationDialog(
                              mainContext: context,
                            );
                          }).then((msg) {
                        if (msg != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(msg)));
                        }
                      });
                    }
                    if (value.id == 'print') {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return LoadingProgressDefault(
                              processText: lang.preparingTheFile,
                              action: vm.showManiFest(
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .user
                                    .id,
                              ),
                            );
                          });
                    }
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  // abed edit
                  itemBuilder: (context) =>
                      [...vm.menuItems.map((e) => buildItem(e)).toList()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  PopupMenuItem<MenuItemASD> buildItem(item) => PopupMenuItem(
        value: item,
        child: Text(item.text),
        enabled: item.isEnabled,
      );

  String getTitleOfChat(String path) {
    String lang = ServiceCollector.getInstance().currentLanguage;
    if (path == '1') {
      return lang == 'en' ? 'with office' : 'مع المكتب';
    } else if (path == '2') {
      return lang == 'en' ? 'with owner' : 'مع المالك';
    } else if (path == '3') {
      return lang == 'en' ? 'with driver' : 'مع السائق';
    } else {
      return '';
    }
  }
}
