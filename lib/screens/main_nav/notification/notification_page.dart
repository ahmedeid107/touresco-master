import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../models/notification_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/view_models/notifications_view_model.dart';
import '../../../providers/view_models/take_role_view_model.dart';
import '../../../services/service_collector.dart';
import '../../../utils/theme.dart';
import '../../../utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationsViewModel>(context, listen: false)
          .syncNotification(
              Provider.of<AuthProvider>(context, listen: false).user.id, "");
    });

    var lang = AppLocalizations.of(context)!;
    return Consumer<NotificationsViewModel>(
      builder: (context, vm, child) {
        return vm.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : NestedScrollView(
                floatHeaderSlivers: true,
                // This builds the scrollable content above the body
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        expandedHeight: 60.0,
                        floating: true,
                        pinned: true,
                        snap: true,
                        title: Text(lang.notificationsGlobal),
                        actions: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () {
                                  String userId = Provider.of<AuthProvider>(
                                          context,
                                          listen: false)
                                      .user
                                      .id;
                                  Provider.of<TakeRoleViewModel>(context,
                                          listen: false)
                                      .syncNotificationProfileNew(userId); Provider.of<TakeRoleViewModel>(context, listen: false)
                                      .checkRoleStatus(Provider.of<AuthProvider>(context, listen: false).user.id);

                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.dashboard,
                                )),
                          )
                        ],
                        automaticallyImplyLeading: false,
                        elevation: 0,
                      ),
        SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(children: [
                                Expanded(
                                  child:
                                  TextFormField(
                                    controller: searchController,
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .nextFocus();
                                    },
                                    keyboardType: TextInputType.text,
                                    cursorColor: kPrimaryColor,
                                    onSaved: (value) {},
                                    onChanged: (value) {
                                      String userId =
                                          Provider.of<AuthProvider>(context, listen: false).user.id;

                                      vm.searchForTrips(value ,userId );
                                    },
                                    decoration: InputDecoration(
                                      labelText: lang.search,
                                      labelStyle: const TextStyle(
                                          color: kPrimaryColor),
                                      suffixIcon: const Icon(
                                        Icons.search,
                                        color: kPrimaryColor,
                                      ),
                                      fillColor: Colors.white,
                                      isDense: true,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color:
                                              Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color:
                                              Colors.transparent),
                                          borderRadius:
                                          BorderRadius.circular(
                                              20)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color:
                                              Colors.transparent)),
                                      focusedErrorBorder:
                                      OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              20),
                                          borderSide:
                                          const BorderSide(
                                              color: Colors
                                                  .transparent)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color:
                                              Colors.transparent)),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Container(
                                  height: 49,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      child: Text(
                                        lang.selectDelete,
                                        style: const TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onTap: () {
                                        vm.changeIsSelected();
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            vm.deletedNotificationsId.containsValue(true)
                                ? InkWell(
                                    onTap: () async {
                                      await vm.deleteNotificationsButton(
                                          Provider.of<AuthProvider>(context,
                                                  listen: false)
                                              .user
                                              .id,
                                          "");
                                      Provider.of<NotificationsViewModel>(
                                              context,
                                              listen: false)
                                          .deletedNotificationsId
                                          .clear();
                                      Provider.of<NotificationsViewModel>(
                                              context,
                                              listen: false)
                                          .searchedNotifications
                                          .clear();
                                      Provider.of<NotificationsViewModel>(
                                              context,
                                              listen: false)
                                          .notifications
                                          .clear();
                                      Provider.of<NotificationsViewModel>(
                                              context,
                                              listen: false)
                                          .syncNotification(
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .user
                                                  .id,
                                              "");
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 48,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          lang.delete,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                // The content of the scroll view
                body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                     // overscroll.disallowGlow();
                      return false;
                    },
                    child: vm.notifications.isEmpty
                        ? SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 250,
                                    width: 250,
                                    child: Lottie.asset(
                                        'assets/animations/lottie_empty2.json',
                                        repeat: false)),
                                Text(
                                  lang.thereAreNoDatanOTI,
                                  style: textTitle(kPrimaryColor),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                searchController.text.isNotEmpty && vm.searchedNotifications.isNotEmpty
                                    ? GroupedListView<NotificationModel,
                                        DateTime>(
                                        reverse: false,

                                        shrinkWrap: true,
                                        order: GroupedListOrder.DESC,
                                        physics: NeverScrollableScrollPhysics(),
                                        //physics of the scroll
                                        useStickyGroupSeparators: true,
                                        floatingHeader: true,
                                        padding: const EdgeInsets.all(8),
                                        elements: vm.searchedNotifications,
                                        groupBy: (notification) => DateTime(
                                          notification.addedDate.year,
                                          notification.addedDate.month,
                                          notification.addedDate.day,
                                        ),
                                        groupHeaderBuilder: (message) =>
                                            _buildGroupHeader(message),
                                        itemComparator: (n1, n2) => n1.addedDate
                                            .compareTo(n2.addedDate),
                                        itemBuilder: (context, notifciation) =>
                                            Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        46, 70, 135, 225),
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3))
                                              ]),
                                          child: Container(
                                            height: 55,
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: InkWell(
                                              onTap: () {
                                                Provider.of<NotificationsViewModel>(
                                                        context,
                                                        listen: false)
                                                    .syncNotificationSeen(
                                                        notifciation.id);
                                                notifciation
                                                        .notficiationStatus =
                                                    NotificationStatus.seen;

                                                if (notifciation
                                                        .tripId.isNotEmpty &&
                                                    notifciation.path != '99') {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/trip_details_screen',
                                                          arguments: {
                                                        'id':
                                                            notifciation.tripId,
                                                        'path':
                                                            notifciation.path,
                                                      }).then((value) {
                                                    Provider.of<NotificationsViewModel>(
                                                            context,
                                                            listen: false)
                                                        .syncNotification(
                                                            Provider.of<AuthProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .user
                                                                .id,
                                                            "");
                                                  });
                                                }
                                              },
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    notifciation.notficiationStatus ==
                                                            NotificationStatus
                                                                .notSeen
                                                        ? Stack(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .notifications_active,
                                                                color:
                                                                    kPrimaryColor,
                                                                size: 28,
                                                              ),
                                                              Container(
                                                                height: 6,
                                                                width: 6,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5555),
                                                                    color: Colors.red.withOpacity(.8),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          blurRadius:
                                                                              1,
                                                                          color:
                                                                              Colors.grey[200]!)
                                                                    ]),
                                                              ),
                                                            ],
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color:
                                                                kPrimaryColor,
                                                            size: 28,
                                                          ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .centerStart,
                                                            child: Text(
                                                              notifciation.text,
                                                              style: textTitle(
                                                                  kTitleBlackTextColor),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    vm.isSelected
                                                        ? Center(
                                                            child: InkWell(
                                                            onTap: () {
                                                              vm.deletedNotifications(
                                                                  notifciation
                                                                      .id);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: vm.deletedNotificationsId[notifciation
                                                                            .id] ==
                                                                        true
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .white,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: vm.deletedNotificationsId[
                                                                            notifciation.id] ==
                                                                        true
                                                                    ? const Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            18.0,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .check_box_outline_blank,
                                                                        size:
                                                                            18.0,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                              ),
                                                            ),
                                                          ))
                                                        : Container(),
                                                    const SizedBox(
                                                      width: 8,
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ):searchController.text.isEmpty?
                                GroupedListView<NotificationModel,
                                        DateTime>(
                                        reverse: false,
                                        primary: false,
                                        order: GroupedListOrder.DESC,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //physics of the scroll
                                        useStickyGroupSeparators: true,
                                        floatingHeader: true,
                                        padding: const EdgeInsets.all(8),
                                        elements: vm.notifications,
                                        groupBy: (notification) => DateTime(
                                          notification.addedDate.year,
                                          notification.addedDate.month,
                                          notification.addedDate.day,
                                        ),
                                        groupHeaderBuilder: (message) =>
                                            _buildGroupHeader(message),
                                        itemComparator: (n1, n2) => n1.addedDate
                                            .compareTo(n2.addedDate),
                                        itemBuilder: (context, notifciation) =>
                                            Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        46, 70, 135, 225),
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3))
                                              ]),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: InkWell(
                                              onTap: () {
                                                Provider.of<NotificationsViewModel>(
                                                        context,
                                                        listen: false)
                                                    .syncNotificationSeen(
                                                        notifciation.id);
                                                notifciation
                                                        .notficiationStatus =
                                                    NotificationStatus.seen;

                                                if (notifciation
                                                        .tripId.isNotEmpty &&
                                                    notifciation.path != '99') {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/trip_details_screen',
                                                          arguments: {
                                                        'id':
                                                            notifciation.tripId,
                                                        'path':
                                                            notifciation.path,
                                                      }).then((value) {
                                                    Provider.of<NotificationsViewModel>(
                                                            context,
                                                            listen: false)
                                                        .syncNotification(
                                                            Provider.of<AuthProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .user
                                                                .id,
                                                            "");
                                                  });
                                                }
                                              },
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    notifciation.notficiationStatus ==
                                                            NotificationStatus
                                                                .notSeen
                                                        ? Stack(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .notifications_active,
                                                                color:
                                                                    kPrimaryColor,
                                                                size: 28,
                                                              ),
                                                              Container(
                                                                height: 6,
                                                                width: 6,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5555),
                                                                    color: Colors.red.withOpacity(.8),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          blurRadius:
                                                                              1,
                                                                          color:
                                                                              Colors.grey[200]!)
                                                                    ]),
                                                              ),
                                                            ],
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .notifications_active,
                                                            color:
                                                                kPrimaryColor,
                                                            size: 28,
                                                          ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .centerStart,
                                                              child: Text(
                                                                notifciation
                                                                    .text,
                                                                style: textTitle(
                                                                    kTitleBlackTextColor),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    vm.isSelected
                                                        ? Center(
                                                            child: InkWell(
                                                            onTap: () {
                                                              vm.deletedNotifications(
                                                                  notifciation
                                                                      .id);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: vm.deletedNotificationsId[notifciation
                                                                            .id] ==
                                                                        true
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .white,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: vm.deletedNotificationsId[
                                                                            notifciation.id] ==
                                                                        true
                                                                    ? const Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            18.0,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .check_box_outline_blank,
                                                                        size:
                                                                            18.0,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                              ),
                                                            ),
                                                          ))
                                                        : Container(),
                                                    const SizedBox(
                                                      width: 8,
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ):
                                searchController.text.isNotEmpty && vm.searchedNotifications.isEmpty ? SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 250,
                                          width: 250,
                                          child: Lottie.asset(
                                              'assets/animations/lottie_empty2.json',
                                              repeat: false)),
                                      Text(
                                        lang.thereAreNoDatanOTI,
                                        style: textTitle(kPrimaryColor),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ):Container(),
                              ],
                            ),
                          )
                )

        );
      },
    );
  }

  // Widget _buildChatGroupHeader(SingleMessageData message) {
  //   return Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           margin: const EdgeInsets.only(bottom: 8),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             color: kPrimaryColor,
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
  //             child: Text(
  //               DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
  //                   .format(message.sendDate),
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //       ]);
  // }

  Widget _buildGroupHeader(
    NotificationModel notification,
  ) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kPrimaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(
                DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
                    .format(notification.addedDate),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]);
  }
}
// Container(
// padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// margin: const EdgeInsets.symmetric(vertical: 8),
// decoration: BoxDecoration(
// color: kPrimaryColor,
// borderRadius: BorderRadius.circular(5),
// ),
// child: Text(
// DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
// .format(notification.addedDate),
// style: const TextStyle(color: Colors.white),
// ),
// );

// import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:touresco/providers/view_models/chat_view_model.dart';
// import '../../../models/notification_model.dart';
// import '../../../providers/auth_provider.dart';
// import '../../../providers/view_models/notifications_view_model.dart';
// import '../../../providers/view_models/take_role_view_model.dart';
// import '../../../services/service_collector.dart';
// import '../../../theme.dart';
// import '../../../utils/constants.dart';
// import '../../finance/components/finance_filter.dart';
// import 'componant/notification_fillter/fillter_componant.dart';
// import 'componant/notifications_componant.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class NotificationPage extends StatefulWidget {
//   const NotificationPage({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   var searchController = TextEditingController();
//  @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<NotificationsViewModel>(context, listen: false)
//           .syncNotification(
//               Provider.of<AuthProvider>(context, listen: false).user.id, "");
//     });
//
//     var lang = AppLocalizations.of(context)!;
//     return Consumer<NotificationsViewModel>(
//       builder: (context, vm, child) {
//         return vm.loading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : NestedScrollView(
//                 floatHeaderSlivers: true,
//                 // This builds the scrollable content above the body
//                 headerSliverBuilder: (context, innerBoxIsScrolled) => [
//                       SliverAppBar(
//                         expandedHeight: 60.0,
//                         floating: true,
//                         pinned: true,
//                         snap: true,
//                         title: Text(lang.notificationsGlobal),
//                         actions: [
//                           Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 8),
//                             child: InkWell(
//                                 highlightColor: Colors.transparent,
//                                 splashColor: Colors.transparent,
//                                 focusColor: Colors.transparent,
//                                 onTap: () {
//                                   String userId = Provider.of<AuthProvider>(
//                                           context,
//                                           listen: false)
//                                       .user
//                                       .id;
//                                   Provider.of<TakeRoleViewModel>(context,
//                                           listen: false)
//                                       .syncNotificationProfileNew(userId);
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: const Icon(
//                                   Icons.dashboard,
//                                 )),
//                           )
//                         ],
//                         automaticallyImplyLeading: false,
//                         elevation: 0,
//                       ),
//                       SliverToBoxAdapter(
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: Row(children: [
//                                 Expanded(
//                                   child:
//                                   TextFormField(
//                                     controller: searchController,
//                                     onEditingComplete: () {
//                                       FocusScope.of(context)
//                                           .nextFocus();
//                                     },
//                                     keyboardType: TextInputType.text,
//                                     cursorColor: kPrimaryColor,
//                                     onSaved: (value) {},
//                                     onChanged: (value) {
//                                       String userId =
//                                           Provider.of<AuthProvider>(context, listen: false).user.id;
//
//                                       vm.searchForTrips(value ,userId );
//                                     },
//                                     decoration: InputDecoration(
//                                       labelText: lang.search,
//                                       labelStyle: const TextStyle(
//                                           color: kPrimaryColor),
//                                       suffixIcon: const Icon(
//                                         Icons.search,
//                                         color: kPrimaryColor,
//                                       ),
//                                       fillColor: Colors.white,
//                                       isDense: true,
//                                       filled: true,
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(20),
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Colors.transparent)),
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Colors.transparent),
//                                           borderRadius:
//                                           BorderRadius.circular(
//                                               20)),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(20),
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Colors.transparent)),
//                                       focusedErrorBorder:
//                                       OutlineInputBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(
//                                               20),
//                                           borderSide:
//                                           const BorderSide(
//                                               color: Colors
//                                                   .transparent)),
//                                       errorBorder: OutlineInputBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(20),
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Colors.transparent)),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 49,
//                                   alignment: Alignment.center,
//                                   decoration: const BoxDecoration(),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: InkWell(
//                                       child: Text(
//                                         lang.selectDelete,
//                                         style: const TextStyle(
//                                             color: Colors.blueAccent,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14),
//                                       ),
//                                       onTap: () {
//                                         vm.changeIsSelected();
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                             const SizedBox(
//                               height: 2,
//                             ),
//                             vm.deletedNotificationsId.containsValue(true)
//                                 ? //                                           vider.of<AuthProvider>(context,(
//                                     onTap: () async {
//                                       await vm.deleteNotificationsButton(
//                                           Provider.of<AuthProvider>(context,
//                                                   listen: false)
//                                               .user
//                                               .id,
//                                           "");
//                                       Provider.of<NotificationsViewModel>(
//                                               context,
//                                               listen: false)
//                                           .deletedNotificationsId
//                                           .clear();
//                                       Provider.of<NotificationsViewModel>(
//                                               context,
//                                               listen: false)
//                                           .searchedNotifications
//                                           .clear();
//                                       Provider.of<NotificationsViewModel>(
//                                               context,
//                                               listen: false)
//                                           .notifications
//                                           .clear();
//                                       Provider.of<NotificationsViewModel>(
//                                               context,
//                                               listen: false)
//                                           .syncNotification(
//                                               Provider.of<AuthProvider>(context,
//                                                       listen: false)
//                                                   .user
//                                                   .id,
//                                               "");
//                                     },
//                                     child: Container(
//                                         height: 35,
//                                         width: 48,
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             color: Colors.redAccent,
//                                             borderRadius:
//                                                 BorderRadius.circular(8)),
//                                         child: Text(
//                                           lang.delete,
//                                           style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16),
//                                         )),
//                                   )
//                                 : Container(),
//                             const SizedBox(
//                               height: 2,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                 // The content of the scroll view
//                 body: NotificationListener<OverscrollIndicatorNotification>(
//                     onNotification: (overscroll) {
//                       overscroll.disallowGlow();
//                       return false;
//                     },
//                   child: Expanded(
//                     child: vm.searchedNotifications.isNotEmpty ? GroupedListView<NotificationModel,
//                         DateTime>(
//                       reverse: false,
//                       order: GroupedListOrder.DESC,
//                       physics: ClampingScrollPhysics(),
//                       //physics of the scroll
//                       useStickyGroupSeparators: true,
//                       floatingHeader: true,
//                       padding: const EdgeInsets.all(8),
//                       elements: vm.searchedNotifications,
//                       groupBy: (notification) => DateTime(
//                         notification.addedDate.year,
//                         notification.addedDate.month,
//                         notification.addedDate.day,
//                       ),
//                       groupHeaderBuilder: (message) =>
//                           _buildGroupHeader(message),
//                       itemComparator: (n1, n2) =>
//                           n1.addedDate.compareTo(n2.addedDate),
//                       itemBuilder: (context, notifciation) =>
//                           Container(
//                             margin:
//                             const EdgeInsets.only(bottom: 10),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius:
//                                 BorderRadius.circular(20),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Color.fromRGBO(
//                                           46, 70, 135, 225),
//                                       spreadRadius: 1,
//                                       blurRadius: 5,
//                                       offset: Offset(0, 3))
//                                 ]),
//                             child: Container(
//                               height: 55,
//                               decoration: const BoxDecoration(
//                                   color: Colors.white),
//                               child: InkWell(
//                                 onTap: () {
//                                   if (notifciation
//                                       .tripId.isNotEmpty &&
//                                       notifciation.path != '99') {
//                                     Provider.of<NotificationsViewModel>(
//                                         context,
//                                         listen: false)
//                                         .syncNotificationSeen(
//                                         notifciation.id);
//                                     notifciation
//                                         .notficiationStatus =
//                                         NotificationStatus.seen;
//
//                                     Navigator.of(context).pushNamed(
//                                         '/trip_details_screen',
//                                         arguments: {
//                                           'id': notifciation.tripId,
//                                           'path': notifciation.path,
//                                         }).then((value) {
//                                       // Provider.of<NotificationsViewModel>(
//                                       //     context,
//                                       //     listen: false)
//                                       //     .syncNotification(
//                                       //     Provider.of<AuthProvider>(
//                                       //         context,
//                                       //         listen: false)
//                                       //         .user
//                                       //         .id,
//                                       //     "");
//                                     });
//                                   }
//                                 },
//                                 child: Row(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.center,
//                                     children: [
//                                       notifciation.notficiationStatus ==
//                                           NotificationStatus
//                                               .notSeen
//                                           ? Stack(
//                                         children: [
//                                           const Icon(
//                                             Icons
//                                                 .notifications_active,
//                                             color:
//                                             kPrimaryColor,
//                                             size: 28,
//                                           ),
//                                           Container(
//                                             height: 6,
//                                             width: 6,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                 BorderRadius.circular(
//                                                     5555),
//                                                 color: Colors.red.withOpacity(.8),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       blurRadius:
//                                                       1,
//                                                       color: Colors
//                                                           .grey[200]!)
//                                                 ]),
//                                           ),
//                                         ],
//                                       )
//                                           : const Icon(
//                                         Icons
//                                             .notifications_active,
//                                         color: kPrimaryColor,
//                                         size: 28,
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                         mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .center,
//                                         children: [
//                                           Align(
//                                             alignment:
//                                             AlignmentDirectional
//                                                 .centerStart,
//                                             child: Text(
//                                               notifciation.text,
//                                               style: textTitle(
//                                                   kTitleBlackTextColor),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       vm.isSelected
//                                           ? Center(
//                                           child: InkWell(
//                                             onTap: () {
//                                               vm.deletedNotifications(
//                                                   notifciation
//                                                       .id);
//                                             },
//                                             child: Container(
//                                               decoration:
//                                               BoxDecoration(
//                                                 shape: BoxShape
//                                                     .circle,
//                                                 color: vm.deletedNotificationsId[
//                                                 notifciation
//                                                     .id] ==
//                                                     true
//                                                     ? Colors.blue
//                                                     : Colors
//                                                     .white,
//                                               ),
//                                               child: Padding(
//                                                 padding:
//                                                 EdgeInsets
//                                                     .all(3.0),
//                                                 child: vm.deletedNotificationsId[
//                                                 notifciation
//                                                     .id] ==
//                                                     true
//                                                     ? const Icon(
//                                                   Icons
//                                                       .check,
//                                                   size:
//                                                   18.0,
//                                                   color: Colors
//                                                       .white,
//                                                 )
//                                                     : const Icon(
//                                                   Icons
//                                                       .check_box_outline_blank,
//                                                   size:
//                                                   18.0,
//                                                   color: Colors
//                                                       .blue,
//                                                 ),
//                                               ),
//                                             ),
//                                           ))
//                                           : Container(),
//                                       const SizedBox(
//                                         width: 8,
//                                       )
//                                     ]),
//                               ),
//                             ),
//                           ),
//                     )
//                         : vm.searchedNotifications.isEmpty && searchController.text.isNotEmpty ?SizedBox(
//                       width: double.infinity,
//                       child: Column(
//                         mainAxisAlignment:
//                         MainAxisAlignment.center,
//                         crossAxisAlignment:
//                         CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                               height: 250,
//                               width: 250,
//                               child: Lottie.asset(
//                                   'assets/animations/lottie_empty2.json',
//                                   repeat: false)),
//                           Text(
//                             lang.thereAreNoData,
//                             style: textTitle(kPrimaryColor),
//                           ),
//                           const SizedBox(
//                             height: 50,
//                           ),
//                         ],
//                       ),
//                     ) : GroupedListView<NotificationModel,
//                         DateTime>(
//                       reverse: false,
//                       order: GroupedListOrder.DESC,
//                       physics: ClampingScrollPhysics(),
//                       //physics of the scroll
//                       useStickyGroupSeparators: true,
//                       floatingHeader: true,
//                       padding: const EdgeInsets.all(8),
//                       elements: vm.notifications,
//                       groupBy: (notification) => DateTime(
//                         notification.addedDate.year,
//                         notification.addedDate.month,
//                         notification.addedDate.day,
//                       ),
//                       groupHeaderBuilder: (message) =>
//                           _buildGroupHeader(message),
//                       itemComparator: (n1, n2) =>
//                           n1.addedDate.compareTo(n2.addedDate),
//                       itemBuilder: (context, notifciation) =>
//                           Container(
//                             margin:
//                             const EdgeInsets.only(bottom: 10),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius:
//                                 BorderRadius.circular(20),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Color.fromRGBO(
//                                           46, 70, 135, 225),
//                                       spreadRadius: 1,
//                                       blurRadius: 5,
//                                       offset: Offset(0, 3))
//                                 ]),
//                             child: Container(
//                               height: 55,
//                               decoration: const BoxDecoration(
//                                   color: Colors.white),
//                               child: InkWell(
//                                 onTap: () {
//                                   if (notifciation
//                                       .tripId.isNotEmpty &&
//                                       notifciation.path != '99') {
//                                     Provider.of<NotificationsViewModel>(
//                                         context,
//                                         listen: false)
//                                         .syncNotificationSeen(
//                                         notifciation.id);
//                                     notifciation
//                                         .notficiationStatus =
//                                         NotificationStatus.seen;
//
//                                     Navigator.of(context).pushNamed(
//                                         '/trip_details_screen',
//                                         arguments: {
//                                           'id': notifciation.tripId,
//                                           'path': notifciation.path,
//                                         }).then((value) {
//                                       // Provider.of<NotificationsViewModel>(
//                                       //     context,
//                                       //     listen: false)
//                                       //     .syncNotification(
//                                       //     Provider.of<AuthProvider>(
//                                       //         context,
//                                       //         listen: false)
//                                       //         .user
//                                       //         .id,
//                                       //     "");
//                                     });
//                                   }
//                                 },
//                                 child: Row(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.center,
//                                     children: [
//                                       notifciation.notficiationStatus ==
//                                           NotificationStatus
//                                               .notSeen
//                                           ? Stack(
//                                         children: [
//                                           const Icon(
//                                             Icons
//                                                 .notifications_active,
//                                             color:
//                                             kPrimaryColor,
//                                             size: 28,
//                                           ),
//                                           Container(
//                                             height: 6,
//                                             width: 6,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                 BorderRadius.circular(
//                                                     5555),
//                                                 color: Colors.red.withOpacity(.8),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       blurRadius:
//                                                       1,
//                                                       color: Colors
//                                                           .grey[200]!)
//                                                 ]),
//                                           ),
//                                         ],
//                                       )
//                                           : const Icon(
//                                         Icons
//                                             .notifications_active,
//                                         color: kPrimaryColor,
//                                         size: 28,
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                         mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .center,
//                                         children: [
//                                           Align(
//                                             alignment:
//                                             AlignmentDirectional
//                                                 .centerStart,
//                                             child: Text(
//                                               notifciation.text,
//                                               style: textTitle(
//                                                   kTitleBlackTextColor),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       vm.isSelected
//                                           ? Center(
//                                           child: InkWell(
//                                             onTap: () {
//                                               vm.deletedNotifications(
//                                                   notifciation
//                                                       .id);
//                                             },
//                                             child: Container(
//                                               decoration:
//                                               BoxDecoration(
//                                                 shape: BoxShape
//                                                     .circle,
//                                                 color: vm.deletedNotificationsId[
//                                                 notifciation
//                                                     .id] ==
//                                                     true
//                                                     ? Colors.blue
//                                                     : Colors
//                                                     .white,
//                                               ),
//                                               child: Padding(
//                                                 padding:
//                                                 EdgeInsets
//                                                     .all(3.0),
//                                                 child: vm.deletedNotificationsId[
//                                                 notifciation
//                                                     .id] ==
//                                                     true
//                                                     ? const Icon(
//                                                   Icons
//                                                       .check,
//                                                   size:
//                                                   18.0,
//                                                   color: Colors
//                                                       .white,
//                                                 )
//                                                     : const Icon(
//                                                   Icons
//                                                       .check_box_outline_blank,
//                                                   size:
//                                                   18.0,
//                                                   color: Colors
//                                                       .blue,
//                                                 ),
//                                               ),
//                                             ),
//                                           ))
//                                           : Container(),
//                                       const SizedBox(
//                                         width: 8,
//                                       )
//                                     ]),
//                               ),
//                             ),
//                           ),
//                     ),
//                   ),
//                   // vm.notifications.isNotEmpty? Expanded(
//                   //   child: vm.searchedNotifications.isNotEmpty
//                   //       ? GroupedListView<NotificationModel,
//                   //       DateTime>(
//                   //     reverse: false,
//                   //     order: GroupedListOrder.DESC,
//                   //     physics: ClampingScrollPhysics(),
//                   //     //physics of the scroll
//                   //     useStickyGroupSeparators: true,
//                   //     floatingHeader: true,
//                   //     padding: const EdgeInsets.all(8),
//                   //     elements: vm.searchedNotifications,
//                   //     groupBy: (notification) => DateTime(
//                   //       notification.addedDate.year,
//                   //       notification.addedDate.month,
//                   //       notification.addedDate.day,
//                   //     ),
//                   //     groupHeaderBuilder: (message) =>
//                   //         _buildGroupHeader(message),
//                   //     itemComparator: (n1, n2) =>
//                   //         n1.addedDate.compareTo(n2.addedDate),
//                   //     itemBuilder: (context, notifciation) =>
//                   //         Container(
//                   //           margin:
//                   //           const EdgeInsets.only(bottom: 10),
//                   //           padding: const EdgeInsets.all(8),
//                   //           decoration: BoxDecoration(
//                   //               color: Colors.white,
//                   //               borderRadius:
//                   //               BorderRadius.circular(20),
//                   //               boxShadow: const [
//                   //                 BoxShadow(
//                   //                     color: Color.fromRGBO(
//                   //                         46, 70, 135, 225),
//                   //                     spreadRadius: 1,
//                   //                     blurRadius: 5,
//                   //                     offset: Offset(0, 3))
//                   //               ]),
//                   //           child: Container(
//                   //             height: 55,
//                   //             decoration: const BoxDecoration(
//                   //                 color: Colors.white),
//                   //             child: InkWell(
//                   //               onTap: () {
//                   //                 if (notifciation
//                   //                     .tripId.isNotEmpty &&
//                   //                     notifciation.path != '99') {
//                   //                   Provider.of<NotificationsViewModel>(
//                   //                       context,
//                   //                       listen: false)
//                   //                       .syncNotificationSeen(
//                   //                       notifciation.id);
//                   //                   notifciation
//                   //                       .notficiationStatus =
//                   //                       NotificationStatus.seen;
//                   //
//                   //                   Navigator.of(context).pushNamed(
//                   //                       '/trip_details_screen',
//                   //                       arguments: {
//                   //                         'id': notifciation.tripId,
//                   //                         'path': notifciation.path,
//                   //                       }).then((value) {
//                   //                     // Provider.of<NotificationsViewModel>(
//                   //                     //     context,
//                   //                     //     listen: false)
//                   //                     //     .syncNotification(
//                   //                     //     Provider.of<AuthProvider>(
//                   //                     //         context,
//                   //                     //         listen: false)
//                   //                     //         .user
//                   //                     //         .id,
//                   //                     //     "");
//                   //                   });
//                   //                 }
//                   //               },
//                   //               child: Row(
//                   //                   crossAxisAlignment:
//                   //                   CrossAxisAlignment.center,
//                   //                   children: [
//                   //                     notifciation.notficiationStatus ==
//                   //                         NotificationStatus
//                   //                             .notSeen
//                   //                         ? Stack(
//                   //                       children: [
//                   //                         const Icon(
//                   //                           Icons
//                   //                               .notifications_active,
//                   //                           color:
//                   //                           kPrimaryColor,
//                   //                           size: 28,
//                   //                         ),
//                   //                         Container(
//                   //                           height: 6,
//                   //                           width: 6,
//                   //                           decoration: BoxDecoration(
//                   //                               borderRadius:
//                   //                               BorderRadius.circular(
//                   //                                   5555),
//                   //                               color: Colors.red.withOpacity(.8),
//                   //                               boxShadow: [
//                   //                                 BoxShadow(
//                   //                                     blurRadius:
//                   //                                     1,
//                   //                                     color: Colors
//                   //                                         .grey[200]!)
//                   //                               ]),
//                   //                         ),
//                   //                       ],
//                   //                     )
//                   //                         : const Icon(
//                   //                       Icons
//                   //                           .notifications_active,
//                   //                       color: kPrimaryColor,
//                   //                       size: 28,
//                   //                     ),
//                   //                     const SizedBox(
//                   //                       width: 10,
//                   //                     ),
//                   //                     Expanded(
//                   //                       child: Column(
//                   //                         crossAxisAlignment:
//                   //                         CrossAxisAlignment
//                   //                             .start,
//                   //                         mainAxisAlignment:
//                   //                         MainAxisAlignment
//                   //                             .center,
//                   //                         children: [
//                   //                           Expanded(
//                   //                             child: Align(
//                   //                               alignment:
//                   //                               AlignmentDirectional
//                   //                                   .centerStart,
//                   //                               child: Text(
//                   //                                 notifciation.text,
//                   //                                 style: textTitle(
//                   //                                     kTitleBlackTextColor),
//                   //                               ),
//                   //                             ),
//                   //                           )
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     vm.isSelected
//                   //                         ? Center(
//                   //                         child: InkWell(
//                   //                           onTap: () {
//                   //                             vm.deletedNotifications(
//                   //                                 notifciation
//                   //                                     .id);
//                   //                           },
//                   //                           child: Container(
//                   //                             decoration:
//                   //                             BoxDecoration(
//                   //                               shape: BoxShape
//                   //                                   .circle,
//                   //                               color: vm.deletedNotificationsId[
//                   //                               notifciation
//                   //                                   .id] ==
//                   //                                   true
//                   //                                   ? Colors.blue
//                   //                                   : Colors
//                   //                                   .white,
//                   //                             ),
//                   //                             child: Padding(
//                   //                               padding:
//                   //                               EdgeInsets
//                   //                                   .all(3.0),
//                   //                               child: vm.deletedNotificationsId[
//                   //                               notifciation
//                   //                                   .id] ==
//                   //                                   true
//                   //                                   ? const Icon(
//                   //                                 Icons
//                   //                                     .check,
//                   //                                 size:
//                   //                                 18.0,
//                   //                                 color: Colors
//                   //                                     .white,
//                   //                               )
//                   //                                   : const Icon(
//                   //                                 Icons
//                   //                                     .check_box_outline_blank,
//                   //                                 size:
//                   //                                 18.0,
//                   //                                 color: Colors
//                   //                                     .blue,
//                   //                               ),
//                   //                             ),
//                   //                           ),
//                   //                         ))
//                   //                         : Container(),
//                   //                     const SizedBox(
//                   //                       width: 8,
//                   //                     )
//                   //                   ]),
//                   //             ),
//                   //           ),
//                   //         ),
//                   //   )
//                   //       : vm.searchedNotifications.isEmpty && searchController.text.isNotEmpty ?SizedBox(
//                   //     width: double.infinity,
//                   //     child: Column(
//                   //       mainAxisAlignment:
//                   //       MainAxisAlignment.center,
//                   //       crossAxisAlignment:
//                   //       CrossAxisAlignment.center,
//                   //       children: [
//                   //         SizedBox(
//                   //             height: 250,
//                   //             width: 250,
//                   //             child: Lottie.asset(
//                   //                 'assets/animations/lottie_empty2.json',
//                   //                 repeat: false)),
//                   //         Text(
//                   //           lang.thereAreNoData,
//                   //           style: textTitle(kPrimaryColor),
//                   //         ),
//                   //         const SizedBox(
//                   //           height: 50,
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ) : GroupedListView<NotificationModel,
//                   //       DateTime>(
//                   //     reverse: false,
//                   //     order: GroupedListOrder.DESC,
//                   //     physics: ClampingScrollPhysics(),
//                   //     //physics of the scroll
//                   //     useStickyGroupSeparators: true,
//                   //     floatingHeader: true,
//                   //     padding: const EdgeInsets.all(8),
//                   //     elements: vm.notifications,
//                   //     groupBy: (notification) => DateTime(
//                   //       notification.addedDate.year,
//                   //       notification.addedDate.month,
//                   //       notification.addedDate.day,
//                   //     ),
//                   //     groupHeaderBuilder: (message) =>
//                   //         _buildGroupHeader(message),
//                   //     itemComparator: (n1, n2) =>
//                   //         n1.addedDate.compareTo(n2.addedDate),
//                   //     itemBuilder: (context, notifciation) =>
//                   //         Container(
//                   //           margin:
//                   //           const EdgeInsets.only(bottom: 10),
//                   //           padding: const EdgeInsets.all(8),
//                   //           decoration: BoxDecoration(
//                   //               color: Colors.white,
//                   //               borderRadius:
//                   //               BorderRadius.circular(20),
//                   //               boxShadow: const [
//                   //                 BoxShadow(
//                   //                     color: Color.fromRGBO(
//                   //                         46, 70, 135, 225),
//                   //                     spreadRadius: 1,
//                   //                     blurRadius: 5,
//                   //                     offset: Offset(0, 3))
//                   //               ]),
//                   //           child: Container(
//                   //             height: 55,
//                   //             decoration: const BoxDecoration(
//                   //                 color: Colors.white),
//                   //             child: InkWell(
//                   //               onTap: () {
//                   //                 if (notifciation
//                   //                     .tripId.isNotEmpty &&
//                   //                     notifciation.path != '99') {
//                   //                   Provider.of<NotificationsViewModel>(
//                   //                       context,
//                   //                       listen: false)
//                   //                       .syncNotificationSeen(
//                   //                       notifciation.id);
//                   //                   notifciation
//                   //                       .notficiationStatus =
//                   //                       NotificationStatus.seen;
//                   //
//                   //                   Navigator.of(context).pushNamed(
//                   //                       '/trip_details_screen',
//                   //                       arguments: {
//                   //                         'id': notifciation.tripId,
//                   //                         'path': notifciation.path,
//                   //                       }).then((value) {
//                   //                     // Provider.of<NotificationsViewModel>(
//                   //                     //     context,
//                   //                     //     listen: false)
//                   //                     //     .syncNotification(
//                   //                     //     Provider.of<AuthProvider>(
//                   //                     //         context,
//                   //                     //         listen: false)
//                   //                     //         .user
//                   //                     //         .id,
//                   //                     //     "");
//                   //                   });
//                   //                 }
//                   //               },
//                   //               child: Row(
//                   //                   crossAxisAlignment:
//                   //                   CrossAxisAlignment.center,
//                   //                   children: [
//                   //                     notifciation.notficiationStatus ==
//                   //                         NotificationStatus
//                   //                             .notSeen
//                   //                         ? Stack(
//                   //                       children: [
//                   //                         const Icon(
//                   //                           Icons
//                   //                               .notifications_active,
//                   //                           color:
//                   //                           kPrimaryColor,
//                   //                           size: 28,
//                   //                         ),
//                   //                         Container(
//                   //                           height: 6,
//                   //                           width: 6,
//                   //                           decoration: BoxDecoration(
//                   //                               borderRadius:
//                   //                               BorderRadius.circular(
//                   //                                   5555),
//                   //                               color: Colors.red.withOpacity(.8),
//                   //                               boxShadow: [
//                   //                                 BoxShadow(
//                   //                                     blurRadius:
//                   //                                     1,
//                   //                                     color: Colors
//                   //                                         .grey[200]!)
//                   //                               ]),
//                   //                         ),
//                   //                       ],
//                   //                     )
//                   //                         : const Icon(
//                   //                       Icons
//                   //                           .notifications_active,
//                   //                       color: kPrimaryColor,
//                   //                       size: 28,
//                   //                     ),
//                   //                     const SizedBox(
//                   //                       width: 10,
//                   //                     ),
//                   //                     Expanded(
//                   //                       child: Column(
//                   //                         crossAxisAlignment:
//                   //                         CrossAxisAlignment
//                   //                             .start,
//                   //                         mainAxisAlignment:
//                   //                         MainAxisAlignment
//                   //                             .center,
//                   //                         children: [
//                   //                           Expanded(
//                   //                             child: Align(
//                   //                               alignment:
//                   //                               AlignmentDirectional
//                   //                                   .centerStart,
//                   //                               child: Text(
//                   //                                 notifciation.text,
//                   //                                 style: textTitle(
//                   //                                     kTitleBlackTextColor),
//                   //                               ),
//                   //                             ),
//                   //                           )
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     vm.isSelected
//                   //                         ? Center(
//                   //                         child: InkWell(
//                   //                           onTap: () {
//                   //                             vm.deletedNotifications(
//                   //                                 notifciation
//                   //                                     .id);
//                   //                           },
//                   //                           child: Container(
//                   //                             decoration:
//                   //                             BoxDecoration(
//                   //                               shape: BoxShape
//                   //                                   .circle,
//                   //                               color: vm.deletedNotificationsId[
//                   //                               notifciation
//                   //                                   .id] ==
//                   //                                   true
//                   //                                   ? Colors.blue
//                   //                                   : Colors
//                   //                                   .white,
//                   //                             ),
//                   //                             child: Padding(
//                   //                               padding:
//                   //                               EdgeInsets
//                   //                                   .all(3.0),
//                   //                               child: vm.deletedNotificationsId[
//                   //                               notifciation
//                   //                                   .id] ==
//                   //                                   true
//                   //                                   ? const Icon(
//                   //                                 Icons
//                   //                                     .check,
//                   //                                 size:
//                   //                                 18.0,
//                   //                                 color: Colors
//                   //                                     .white,
//                   //                               )
//                   //                                   : const Icon(
//                   //                                 Icons
//                   //                                     .check_box_outline_blank,
//                   //                                 size:
//                   //                                 18.0,
//                   //                                 color: Colors
//                   //                                     .blue,
//                   //                               ),
//                   //                             ),
//                   //                           ),
//                   //                         ))
//                   //                         : Container(),
//                   //                     const SizedBox(
//                   //                       width: 8,
//                   //                     )
//                   //                   ]),
//                   //             ),
//                   //           ),
//                   //         ),
//                   //   ),
//                   // ):SizedBox(
//                   //   width: double.infinity,
//                   //   child: Column(
//                   //     mainAxisAlignment:
//                   //     MainAxisAlignment.center,
//                   //     crossAxisAlignment:
//                   //     CrossAxisAlignment.center,
//                   //     children: [
//                   //       SizedBox(
//                   //           height: 250,
//                   //           width: 250,
//                   //           child: Lottie.asset(
//                   //               'assets/animations/lottie_empty2.json',
//                   //               repeat: false)),
//                   //       Text(
//                   //         lang.thereAreNoData,
//                   //         style: textTitle(kPrimaryColor),
//                   //       ),
//                   //       const SizedBox(
//                   //         height: 50,
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ) ,
//                   //-----------
//                     // child: vm.notifications.isEmpty
//                     //     ? SizedBox(
//                     //         width: double.infinity,
//                     //         child: Column(
//                     //           mainAxisAlignment: MainAxisAlignment.center,
//                     //           crossAxisAlignment: CrossAxisAlignment.center,
//                     //           children: [
//                     //             SizedBox(
//                     //                 height: 250,
//                     //                 width: 250,
//                     //                 child: Lottie.asset(
//                     //                     'assets/animations/lottie_empty2.json',
//                     //                     repeat: false)),
//                     //             Text(
//                     //               lang.thereAreNoDatanOTI,
//                     //               style: textTitle(kPrimaryColor),
//                     //             ),
//                     //             const SizedBox(
//                     //               height: 50,
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       )
//                     //     : SingleChildScrollView(
//                     //         child: Column(
//                     //           children: [
//                     //             vm.notifications.isEmpty
//                     //                 ? GroupedListView<NotificationModel,
//                     //                     DateTime>(
//                     //                     reverse: false,
//                     //
//                     //                     shrinkWrap: false,
//                     //                     order: GroupedListOrder.DESC,
//                     //                     physics: NeverScrollableScrollPhysics(),
//                     //                     //physics of the scroll
//                     //                     useStickyGroupSeparators: true,
//                     //                     floatingHeader: true,
//                     //                     padding: const EdgeInsets.all(8),
//                     //                     elements: vm.notifications,
//                     //                     groupBy: (notification) => DateTime(
//                     //                       notification.addedDate.year,
//                     //                       notification.addedDate.month,
//                     //                       notification.addedDate.day,
//                     //                     ),
//                     //                     groupHeaderBuilder: (message) =>
//                     //                         _buildGroupHeader(message),
//                     //                     itemComparator: (n1, n2) => n1.addedDate
//                     //                         .compareTo(n2.addedDate),
//                     //                     itemBuilder: (context, notifciation) =>
//                     //                         Container(
//                     //                       margin:
//                     //                           const EdgeInsets.only(bottom: 10),
//                     //                       padding: const EdgeInsets.all(8),
//                     //                       decoration: BoxDecoration(
//                     //                           color: Colors.white,
//                     //                           borderRadius:
//                     //                               BorderRadius.circular(20),
//                     //                           boxShadow: const [
//                     //                             BoxShadow(
//                     //                                 color: Color.fromRGBO(
//                     //                                     46, 70, 135, 225),
//                     //                                 spreadRadius: 1,
//                     //                                 blurRadius: 5,
//                     //                                 offset: Offset(0, 3))
//                     //                           ]),
//                     //                       child: Container(
//                     //                         height: 55,
//                     //                         decoration: const BoxDecoration(
//                     //                             color: Colors.white),
//                     //                         child: InkWell(
//                     //                           onTap: () {
//                     //                             Provider.of<NotificationsViewModel>(
//                     //                                     context,
//                     //                                     listen: false)
//                     //                                 .syncNotificationSeen(
//                     //                                     notifciation.id);
//                     //                             notifciation
//                     //                                     .notficiationStatus =
//                     //                                 NotificationStatus.seen;
//                     //
//                     //                             if (notifciation
//                     //                                     .tripId.isNotEmpty &&
//                     //                                 notifciation.path != '99') {
//                     //                               Navigator.of(context)
//                     //                                   .pushNamed(
//                     //                                       '/trip_details_screen',
//                     //                                       arguments: {
//                     //                                     'id':
//                     //                                         notifciation.tripId,
//                     //                                     'path':
//                     //                                         notifciation.path,
//                     //                                   }).then((value) {
//                     //                                 Provider.of<NotificationsViewModel>(
//                     //                                         context,
//                     //                                         listen: false)
//                     //                                     .syncNotification(
//                     //                                         Provider.of<AuthProvider>(
//                     //                                                 context,
//                     //                                                 listen:
//                     //                                                     false)
//                     //                                             .user
//                     //                                             .id,
//                     //                                         "");
//                     //                               });
//                     //                             }
//                     //                           },
//                     //                           child: Row(
//                     //                               crossAxisAlignment:
//                     //                                   CrossAxisAlignment.center,
//                     //                               children: [
//                     //                                 notifciation.notficiationStatus ==
//                     //                                         NotificationStatus
//                     //                                             .notSeen
//                     //                                     ? Stack(
//                     //                                         children: [
//                     //                                           const Icon(
//                     //                                             Icons
//                     //                                                 .notifications_active,
//                     //                                             color:
//                     //                                                 kPrimaryColor,
//                     //                                             size: 28,
//                     //                                           ),
//                     //                                           Container(
//                     //                                             height: 6,
//                     //                                             width: 6,
//                     //                                             decoration: BoxDecoration(
//                     //                                                 borderRadius:
//                     //                                                     BorderRadius.circular(5555),
//                     //                                                 color: Colors.red.withOpacity(.8),
//                     //                                                 boxShadow: [
//                     //                                                   BoxShadow(
//                     //                                                       blurRadius:
//                     //                                                           1,
//                     //                                                       color:
//                     //                                                           Colors.grey[200]!)
//                     //                                                 ]),
//                     //                                           ),
//                     //                                         ],
//                     //                                       )
//                     //                                     : const Icon(
//                     //                                         Icons
//                     //                                             .notifications_active,
//                     //                                         color:
//                     //                                             kPrimaryColor,
//                     //                                         size: 28,
//                     //                                       ),
//                     //                                 const SizedBox(
//                     //                                   width: 10,
//                     //                                 ),
//                     //                                 Expanded(
//                     //                                   child: Column(
//                     //                                     crossAxisAlignment:
//                     //                                         CrossAxisAlignment
//                     //                                             .start,
//                     //                                     mainAxisAlignment:
//                     //                                         MainAxisAlignment
//                     //                                             .center,
//                     //                                     children: [
//                     //                                       Align(
//                     //                                         alignment:
//                     //                                             AlignmentDirectional
//                     //                                                 .centerStart,
//                     //                                         child: Text(
//                     //                                           notifciation.text,
//                     //                                           style: textTitle(
//                     //                                               kTitleBlackTextColor),
//                     //                                         ),
//                     //                                       )
//                     //                                     ],
//                     //                                   ),
//                     //                                 ),
//                     //                                 vm.isSelected
//                     //                                     ? Center(
//                     //                                         child: InkWell(
//                     //                                         onTap: () {
//                     //                                           vm.deletedNotifications(
//                     //                                               notifciation
//                     //                                                   .id);
//                     //                                         },
//                     //                                         child: Container(
//                     //                                           decoration:
//                     //                                               BoxDecoration(
//                     //                                             shape: BoxShape
//                     //                                                 .circle,
//                     //                                             color: vm.deletedNotificationsId[notifciation
//                     //                                                         .id] ==
//                     //                                                     true
//                     //                                                 ? Colors
//                     //                                                     .blue
//                     //                                                 : Colors
//                     //                                                     .white,
//                     //                                           ),
//                     //                                           child: Padding(
//                     //                                             padding:
//                     //                                                 const EdgeInsets
//                     //                                                         .all(
//                     //                                                     3.0),
//                     //                                             child: vm.deletedNotificationsId[
//                     //                                                         notifciation.id] ==
//                     //                                                     true
//                     //                                                 ? const Icon(
//                     //                                                     Icons
//                     //                                                         .check,
//                     //                                                     size:
//                     //                                                         18.0,
//                     //                                                     color: Colors
//                     //                                                         .white,
//                     //                                                   )
//                     //                                                 : const Icon(
//                     //                                                     Icons
//                     //                                                         .check_box_outline_blank,
//                     //                                                     size:
//                     //                                                         18.0,
//                     //                                                     color: Colors
//                     //                                                         .blue,
//                     //                                                   ),
//                     //                                           ),
//                     //                                         ),
//                     //                                       ))
//                     //                                     : Container(),
//                     //                                 const SizedBox(
//                     //                                   width: 8,
//                     //                                 )
//                     //                               ]),
//                     //                         ),
//                     //                       ),
//                     //                     ),
//                     //                   )
//                     //                 : GroupedListView<NotificationModel,
//                     //                     DateTime>(
//                     //                     reverse: false,
//                     //                     primary: false,
//                     //                     order: GroupedListOrder.DESC,
//                     //                     physics: NeverScrollableScrollPhysics(),
//                     //                     shrinkWrap: true,
//                     //                     //physics of the scroll
//                     //                     useStickyGroupSeparators: true,
//                     //                     floatingHeader: true,
//                     //                     padding: const EdgeInsets.all(8),
//                     //                     elements: vm.notifications,
//                     //                     groupBy: (notification) => DateTime(
//                     //                       notification.addedDate.year,
//                     //                       notification.addedDate.month,
//                     //                       notification.addedDate.day,
//                     //                     ),
//                     //                     groupHeaderBuilder: (message) =>
//                     //                         _buildGroupHeader(message),
//                     //                     itemComparator: (n1, n2) => n1.addedDate
//                     //                         .compareTo(n2.addedDate),
//                     //                     itemBuilder: (context, notifciation) =>
//                     //                         Container(
//                     //                       margin:
//                     //                           const EdgeInsets.only(bottom: 10),
//                     //                       padding: const EdgeInsets.all(8),
//                     //                       decoration: BoxDecoration(
//                     //                           color: Colors.white,
//                     //                           borderRadius:
//                     //                               BorderRadius.circular(20),
//                     //                           boxShadow: const [
//                     //                             BoxShadow(
//                     //                                 color: Color.fromRGBO(
//                     //                                     46, 70, 135, 225),
//                     //                                 spreadRadius: 1,
//                     //                                 blurRadius: 5,
//                     //                                 offset: Offset(0, 3))
//                     //                           ]),
//                     //                       child: Container(
//                     //                         decoration: const BoxDecoration(
//                     //                             color: Colors.white),
//                     //                         child: InkWell(
//                     //                           onTap: () {
//                     //                             Provider.of<NotificationsViewModel>(
//                     //                                     context,
//                     //                                     listen: false)
//                     //                                 .syncNotificationSeen(
//                     //                                     notifciation.id);
//                     //                             notifciation
//                     //                                     .notficiationStatus =
//                     //                                 NotificationStatus.seen;
//                     //
//                     //                             if (notifciation
//                     //                                     .tripId.isNotEmpty &&
//                     //                                 notifciation.path != '99') {
//                     //                               Navigator.of(context)
//                     //                                   .pushNamed(
//                     //                                       '/trip_details_screen',
//                     //                                       arguments: {
//                     //                                     'id':
//                     //                                         notifciation.tripId,
//                     //                                     'path':
//                     //                                         notifciation.path,
//                     //                                   }).then((value) {
//                     //                                 Provider.of<NotificationsViewModel>(
//                     //                                         context,
//                     //                                         listen: false)
//                     //                                     .syncNotification(
//                     //                                         Provider.of<AuthProvider>(
//                     //                                                 context,
//                     //                                                 listen:
//                     //                                                     false)
//                     //                                             .user
//                     //                                             .id,
//                     //                                         "");
//                     //                               });
//                     //                             }
//                     //                           },
//                     //                           child: Row(
//                     //                               crossAxisAlignment:
//                     //                                   CrossAxisAlignment.center,
//                     //                               children: [
//                     //                                 notifciation.notficiationStatus ==
//                     //                                         NotificationStatus
//                     //                                             .notSeen
//                     //                                     ? Stack(
//                     //                                         children: [
//                     //                                           const Icon(
//                     //                                             Icons
//                     //                                                 .notifications_active,
//                     //                                             color:
//                     //                                                 kPrimaryColor,
//                     //                                             size: 28,
//                     //                                           ),
//                     //                                           Container(
//                     //                                             height: 6,
//                     //                                             width: 6,
//                     //                                             decoration: BoxDecoration(
//                     //                                                 borderRadius:
//                     //                                                     BorderRadius.circular(5555),
//                     //                                                 color: Colors.red.withOpacity(.8),
//                     //                                                 boxShadow: [
//                     //                                                   BoxShadow(
//                     //                                                       blurRadius:
//                     //                                                           1,
//                     //                                                       color:
//                     //                                                           Colors.grey[200]!)
//                     //                                                 ]),
//                     //                                           ),
//                     //                                         ],
//                     //                                       )
//                     //                                     : const Icon(
//                     //                                         Icons
//                     //                                             .notifications_active,
//                     //                                         color:
//                     //                                             kPrimaryColor,
//                     //                                         size: 28,
//                     //                                       ),
//                     //                                 const SizedBox(
//                     //                                   width: 10,
//                     //                                 ),
//                     //                                 Expanded(
//                     //                                   child: Container(
//                     //                                     child: Column(
//                     //                                       crossAxisAlignment:
//                     //                                           CrossAxisAlignment
//                     //                                               .start,
//                     //                                       mainAxisAlignment:
//                     //                                           MainAxisAlignment
//                     //                                               .center,
//                     //                                       children: [
//                     //                                         Align(
//                     //                                           alignment:
//                     //                                               AlignmentDirectional
//                     //                                                   .centerStart,
//                     //                                           child: Text(
//                     //                                             notifciation
//                     //                                                 .text,
//                     //                                             style: textTitle(
//                     //                                                 kTitleBlackTextColor),
//                     //                                           ),
//                     //                                         )
//                     //                                       ],
//                     //                                     ),
//                     //                                   ),
//                     //                                 ),
//                     //                                 vm.isSelected
//                     //                                     ? Center(
//                     //                                         child: InkWell(
//                     //                                         onTap: () {
//                     //                                           vm.deletedNotifications(
//                     //                                               notifciation
//                     //                                                   .id);
//                     //                                         },
//                     //                                         child: Container(
//                     //                                           decoration:
//                     //                                               BoxDecoration(
//                     //                                             shape: BoxShape
//                     //                                                 .circle,
//                     //                                             color: vm.deletedNotificationsId[notifciation
//                     //                                                         .id] ==
//                     //                                                     true
//                     //                                                 ? Colors
//                     //                                                     .blue
//                     //                                                 : Colors
//                     //                                                     .white,
//                     //                                           ),
//                     //                                           child: Padding(
//                     //                                             padding:
//                     //                                                 const EdgeInsets
//                     //                                                         .all(
//                     //                                                     3.0),
//                     //                                             child: vm.deletedNotificationsId[
//                     //                                                         notifciation.id] ==
//                     //                                                     true
//                     //                                                 ? const Icon(
//                     //                                                     Icons
//                     //                                                         .check,
//                     //                                                     size:
//                     //                                                         18.0,
//                     //                                                     color: Colors
//                     //                                                         .white,
//                     //                                                   )
//                     //                                                 : const Icon(
//                     //                                                     Icons
//                     //                                                         .check_box_outline_blank,
//                     //                                                     size:
//                     //                                                         18.0,
//                     //                                                     color: Colors
//                     //                                                         .blue,
//                     //                                                   ),
//                     //                                           ),
//                     //                                         ),
//                     //                                       ))
//                     //                                     : Container(),
//                     //                                 const SizedBox(
//                     //                                   width: 8,
//                     //                                 )
//                     //                               ]),
//                     //                         ),
//                     //                       ),
//                     //                     ),
//                     //                   ),
//                     //           ],
//                     //         ),
//                     //       ),
//                     //
//
//                 )
//
//         );
//       },
//     );
//   }
//
//   // Widget _buildChatGroupHeader(SingleMessageData message) {
//   //   return Row(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       mainAxisSize: MainAxisSize.min,
//   //       children: [
//   //         Container(
//   //           margin: const EdgeInsets.only(bottom: 8),
//   //           decoration: BoxDecoration(
//   //             borderRadius: BorderRadius.circular(5),
//   //             color: kPrimaryColor,
//   //           ),
//   //           child: Padding(
//   //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//   //             child: Text(
//   //               DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
//   //                   .format(message.sendDate),
//   //               style: const TextStyle(color: Colors.white),
//   //             ),
//   //           ),
//   //         ),
//   //       ]);
//   // }
//
//   Widget _buildGroupHeader(
//     NotificationModel notification,
//   ) {
//     return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: kPrimaryColor,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//               child: Text(
//                 DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
//                     .format(notification.addedDate),
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ]);
//   }
// }
// // Container(
// // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// // margin: const EdgeInsets.symmetric(vertical: 8),
// // decoration: BoxDecoration(
// // color: kPrimaryColor,
// // borderRadius: BorderRadius.circular(5),
// // ),
// // child: Text(
// // DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
// // .format(notification.addedDate),
// // style: const TextStyle(color: Colors.white),
// // ),
// // );
