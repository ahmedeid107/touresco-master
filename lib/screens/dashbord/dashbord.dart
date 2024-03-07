import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/custom_drawer.dart';
import 'package:touresco/models/meun.dart';
import 'package:touresco/screens/TableCalendarScreen.dart';
import 'package:touresco/screens/main_nav/main_nav.dart';
import 'package:touresco/screens/new_trip/NewTripScreen.dart';
import '../../components/default_button.dart';
import '../../providers/auth_provider.dart';
import '../../providers/view_models/take_role_view_model.dart';
import '../../utils/constants.dart';
import '../../utils/screen_config.dart';
import '../dashboard_notfications/dashboardNotifications.dart';
import 'dart:async';

class Dashbord extends StatefulWidget {
  Dashbord({Key? key}) : super(key: key);

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  Timer? _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<TakeRoleViewModel>(context, listen: false).numOfMessages = 0;
    //startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer() {
    String userId = Provider.of<AuthProvider>(context, listen: false).user.id;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      Provider.of<TakeRoleViewModel>(context, listen: false)
          .syncGroupNumber(userId);
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    String userId = Provider.of<AuthProvider>(context, listen: false).user.id;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<TakeRoleViewModel>(context, listen: false)
            .checkRoleStatus(userId);
        Provider.of<TakeRoleViewModel>(context, listen: false)
            .syncNotificationProfileNew(userId);
        Provider.of<TakeRoleViewModel>(context, listen: false)
            .syncEvent(userId);

        Provider.of<TakeRoleViewModel>(context, listen: false)
            .syncGroupNumber(userId);
      },
    );

    return Scaffold(
        drawer: CustomDrawer(),
        key: _scaffoldKey,
        backgroundColor: Colors.grey[100],
        body: PopScope(
          onPopInvoked: (canPop) async {},
          child: RefreshIndicator(
            onRefresh: () async {
              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .checkRoleStatus(userId);
              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .syncNotificationProfileNew(userId);
              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .numOfMessages = 0;

              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .syncGroupNumber(userId);
              Provider.of<TakeRoleViewModel>(context, listen: false)
                  .syncEvent(userId);
            },
            child: Consumer<TakeRoleViewModel>(builder: (context, vm, child) {
              return vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SafeArea(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: constraints.copyWith(
                                  minHeight: constraints.maxHeight,
                                  maxHeight: double.infinity),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenConfig
                                              .getRuntimeHeightByRatio(16)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: InkWell(
                                                highlightColor:
                                                    Colors.transparent,
                                                focusColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                child: Icon(
                                                  Icons.menu,
                                                  color: Colors.grey[800],
                                                  size: 32,
                                                ),
                                                onTap: () {
                                                  _scaffoldKey.currentState
                                                      ?.openDrawer();
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  lang!.dashbord,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                highlightColor:
                                                    Colors.transparent,
                                                focusColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.grey[800],
                                                  size: 32,
                                                ),
                                                onTap: () {
                                                  Provider.of<TakeRoleViewModel>(
                                                          context,
                                                          listen: false)
                                                      .syncNotificationProfileNew(
                                                          userId);

                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return MainNav(
                                                      index: 4,
                                                    );
                                                  }));
                                                },
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 12, right: 12),
                                              child: Image.asset(
                                                'assets/images/logo.png',
                                                width: 32,
                                                height: 32,
                                              ),
                                            ),
                                          ]),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      children: [
                                        vm.hasGeneralRole
                                            ? _buildGeneralRoleExist(
                                                vm, userId, lang)
                                            : Container(),
                                        _buildRegisterWithNewGeneralRole(
                                            vm, userId, lang, context),
                                        if (vm.currentCity != "" &&
                                            vm.hasSpecificRole)
                                          vm.hasSpecificRole
                                              ? Text(
                                                  "${lang.inCity} ${vm.currentCity} ",
                                                  style: const TextStyle(
                                                      fontSize: 15.5,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Container()
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              25, 129, 127, 127),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      margin:
                                          EdgeInsets.only(left: 16, right: 16),
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsetsDirectional
                                                .only(
                                              start: 16,
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.notifications_active,
                                                    size: 25,
                                                    color: Colors.amber),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  lang.notifications,
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Card(
                                                  margin: const EdgeInsets.only(
                                                      right: 8, left: 4),
                                                  elevation: 4,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      Provider.of<TakeRoleViewModel>(
                                                              context,
                                                              listen: false)
                                                          .syncNotificationProfileNew(
                                                              userId);
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (c) {
                                                        return DashboardNotifications(
                                                          index: 0,
                                                        );
                                                      }));
                                                    },
                                                    child: Container(
                                                      height: 82,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(.85),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            lang.trips,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: ScreenConfig
                                                                  .getFontDynamic(
                                                                      17),
                                                            ),
                                                          ),
                                                          Text(
                                                            Provider.of<TakeRoleViewModel>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .notificationMessenger[
                                                                    "travel"]
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize:
                                                                    ScreenConfig
                                                                        .getFontDynamic(
                                                                            17)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Card(
                                                  margin: const EdgeInsets.only(
                                                      right: 8, left: 4),
                                                  elevation: 4,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        Provider.of<TakeRoleViewModel>(
                                                                context,
                                                                listen: false)
                                                            .syncNotificationProfileNew(
                                                                userId);

                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (c) {
                                                          return DashboardNotifications(
                                                            index: 1,
                                                          );
                                                        }));
                                                      },
                                                      child: Container(
                                                        height: 82,
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    .85),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              lang.chatsGroups,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize:
                                                                    ScreenConfig
                                                                        .getFontDynamic(
                                                                            17),
                                                              ),
                                                            ),
                                                            Text(
                                                              Provider.of<TakeRoleViewModel>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .notificationMessenger[
                                                                      "chat"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: ScreenConfig
                                                                      .getFontDynamic(
                                                                          17)),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Expanded(
                                                child: Card(
                                                  margin: const EdgeInsets.only(
                                                      right: 8, left: 4),
                                                  elevation: 4,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      Provider.of<TakeRoleViewModel>(
                                                              context,
                                                              listen: false)
                                                          .syncNotificationProfileNew(
                                                              userId);

                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (c) {
                                                        return DashboardNotifications(
                                                          index: 2,
                                                        );
                                                      }));
                                                    },
                                                    child: Container(
                                                      height: 82,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(.85),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            lang.payments,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: ScreenConfig
                                                                  .getFontDynamic(
                                                                      17),
                                                            ),
                                                          ),
                                                          Text(
                                                            Provider.of<TakeRoleViewModel>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .notificationMessenger[
                                                                    "finance"]
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize:
                                                                    ScreenConfig
                                                                        .getFontDynamic(
                                                                            17)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: Colors.grey
                                                      .withOpacity(.6),
                                                  highlightColor:
                                                      Colors.transparent,
                                                  focusColor: Colors.grey
                                                      .withOpacity(.6),
                                                  onTap: () {
                                                    Provider.of<TakeRoleViewModel>(
                                                            context,
                                                            listen: false)
                                                        .syncNotificationProfileNew(
                                                            userId);

                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return MainNav(
                                                        index: 0,
                                                      );
                                                    }));
                                                  },
                                                  child: Container(
                                                    height: ScreenConfig
                                                        .getRuntimeHeightByRatio(
                                                            130),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.explore,
                                                          size: 50,
                                                          color:
                                                              Colors.blue[200],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Text(
                                                          lang.explore,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .grey[800],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: Colors.grey
                                                      .withOpacity(.6),
                                                  highlightColor:
                                                      Colors.transparent,
                                                  focusColor: Colors.grey
                                                      .withOpacity(.6),
                                                  onTap: () {
                                                    Provider.of<TakeRoleViewModel>(
                                                            context,
                                                            listen: false)
                                                        .syncNotificationProfileNew(
                                                            userId);
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/groups_screen');
                                                  },
                                                  child: Container(
                                                    height: ScreenConfig
                                                        .getRuntimeHeightByRatio(
                                                            130),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .online_prediction_sharp,
                                                          size: 50,
                                                          color:
                                                              Colors.red[200],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              lang.groups,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                          .grey[
                                                                      800]),
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Provider.of<TakeRoleViewModel>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .numOfMessages ==
                                                                    0
                                                                ? Container()
                                                                : Container(
                                                                    height: 14,
                                                                    width: 14,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      Provider.of<TakeRoleViewModel>(
                                                                              context,
                                                                              listen: false)
                                                                          .numOfMessages
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.circular(55555)),
                                                                  ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: Colors.grey
                                                      .withOpacity(.6),
                                                  highlightColor:
                                                      Colors.transparent,
                                                  focusColor: Colors.grey
                                                      .withOpacity(.6),
                                                  onTap: () {
                                                    Provider.of<TakeRoleViewModel>(
                                                            context,
                                                            listen: false)
                                                        .syncNotificationProfileNew(
                                                            userId);

                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return MainNav(
                                                        index: 2,
                                                      );
                                                    }));
                                                  },
                                                  child: Container(
                                                    height: ScreenConfig
                                                        .getRuntimeHeightByRatio(
                                                            130),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.drive_eta,
                                                          size: 50,
                                                          color:
                                                              Colors.green[200],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Text(
                                                          lang.transferFlights,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[800]),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.hardEdge,
                                                child: PopupMenuButton<
                                                    MenuItemASD>(
                                                  onSelected: (value) async {
                                                    int type = int.parse(
                                                        value.id.toString());
                                                    print("SAASDAS D${type}");
                                                    var id = Provider.of<
                                                                AuthProvider>(
                                                            context,
                                                            listen: false)
                                                        .user
                                                        .id;
                                                    Provider.of<TakeRoleViewModel>(
                                                            context,
                                                            listen: false)
                                                        .syncEvents(
                                                            type, id, lang);

                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) {
                                                        return TableCalendarScreen(
                                                          title: value.text,
                                                          type: type,
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  itemBuilder: (context) => [
                                                    ...vm
                                                        .getLists(Provider.of<
                                                                AuthProvider>(
                                                            context,
                                                            listen: false)
                                                        .user
                                                        .id)
                                                        .map(
                                                            (e) => buildItem(e))
                                                        .toList()
                                                  ],
                                                  child: SizedBox(
                                                    height: ScreenConfig
                                                        .getRuntimeHeightByRatio(
                                                            130),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.event_note,
                                                          size: 50,
                                                          color: Colors
                                                              .orange[200],
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                          width: 4,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              lang.eventNote,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                          .grey[
                                                                      800]),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            vm.haveMarkNote
                                                                ? Container(
                                                                    height: 8,
                                                                    width: 8,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.circular(555555)),
                                                                  )
                                                                : Container(),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: Colors.grey
                                                      .withOpacity(.6),
                                                  highlightColor:
                                                      Colors.transparent,
                                                  focusColor: Colors.grey
                                                      .withOpacity(.6),
                                                  onTap: () {
                                                    Provider.of<TakeRoleViewModel>(
                                                            context,
                                                            listen: false)
                                                        .syncNotificationProfileNew(
                                                            userId);

                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return MainNav(
                                                        index: 1,
                                                      );
                                                    }));
                                                  },
                                                  child: Container(
                                                    height: ScreenConfig
                                                        .getRuntimeHeightByRatio(
                                                            130),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.swipe_left,
                                                          size: 50,
                                                          color:
                                                              Colors.brown[200],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Text(
                                                          lang.mytransferFlights,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[800]),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: Colors.grey
                                                      .withOpacity(.6),
                                                  highlightColor:
                                                      Colors.transparent,
                                                  focusColor: Colors.grey
                                                      .withOpacity(.6),
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return NewTripScreen();
                                                    }));
                                                  },
                                                  child: Container(
                                                    height: ScreenConfig
                                                        .getRuntimeHeightByRatio(
                                                            130),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 50,
                                                          color: Color.fromARGB(
                                                              100,
                                                              249,
                                                              144,
                                                              212),
                                                        ),
                                                        Text(
                                                          lang.createTrip,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[800]),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(),
                                    const SizedBox(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            }),
          ),
        ));
  }

  // Widget e ()=> ;
  Widget _buildRegisterWithNewGeneralRole(TakeRoleViewModel vm, String userId,
      AppLocalizations? lang, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
      child: DefaultButton(
        buttonWidth: double.infinity,
        elevation: 2,
        buttonText: lang!.reservationScreenAndRoleRemoval,
        onpressed: () {
          Navigator.pushNamed(context, '/take_role_screen');
        },
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
      ),
    );
  }

  Column _buildGeneralRoleExist(
      TakeRoleViewModel vm, String userId, AppLocalizations? lang) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.symmetric(
              horizontal: ScreenConfig.getRuntimeHeightByRatio(20)),
          child: Container(
            height: ScreenConfig.getRuntimeHeightByRatio(52),
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lang!.roleNumber,
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenConfig.getFontDynamic(18),
                  ),
                ),
                SizedBox(
                  width: ScreenConfig.getRuntimeWidthByRatio(18),
                ),
                Text(
                  vm.currentGeneralRole,
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenConfig.getFontDynamic(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<MenuItemASD> buildItem(item) => PopupMenuItem(
        value: item,
        enabled: item.isEnabled,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.text),
            if (item.num != null && item.num > 0)
              Container(
                padding: EdgeInsets.all(2),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(555555)),
                child: Text(item.num.toString(), textAlign: TextAlign.center,),
              )
          ],
        ),
      );
}
