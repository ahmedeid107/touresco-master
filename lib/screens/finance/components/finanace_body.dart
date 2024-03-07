// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:touresco/components/search_bar.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/finance_view_model.dart';
import 'package:touresco/screens/finance/components/finance_filter.dart';
import 'package:touresco/screens/finance/components/finance_list.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/services/app_exception.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';

import 'package:touresco/utils/screen_config.dart';

class FinanceBody extends StatefulWidget {
  const FinanceBody({Key? key}) : super(key: key);

  @override
  State<FinanceBody> createState() => _FinanceBodyState();
}

class _FinanceBodyState extends State<FinanceBody> {
   //String availableTripAccount = "0";
   //String bookedTripAccount = "0";

  @override
  void initState() {
    super.initState();
    //fetchAccountData();
  }

  // Future<void> fetchAccountData() async {
  //    final url = Uri.parse(mainUrl);
  //   final Map<String, dynamic> postData = {
  //     'userID': Provider.of<AuthProvider>(context, listen: false).user.id,
  //     'Testaccount': '',
  //   };
  //   try {
  //     final res = await http.post(url, body: postData);
  //   if (res.statusCode == 200 && !res.body.isEmpty)
  //   {
  //           final mapData = json.decode(res.body) as Map;
  //     setState(() {
  //             availableTripAccount = mapData['available_trip_account'];
  //         bookedTripAccount = mapData['booked_trip_account'];
  //     });
  //   }
  //   else
  //   {
  //       throw AppException(AppExceptionData.serverNotRespond);
  //   }
  //   } on AppException catch (error) {
  //     throw error.toString();
  //   } catch (error) {
  //     throw AppException(AppExceptionData.unkown).toString();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        String userId =
            Provider.of<AuthProvider>(context, listen: false).user.id;
        Provider.of<FinacneViewModel>(context, listen: false)
            .syncFinances(userId);
      },
    );
    return Column(
      // added by me
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(16),
        //       boxShadow: const [
        //         BoxShadow(
        //             color: Color.fromRGBO(46, 70, 135, 225),
        //             spreadRadius: 5,
        //             blurRadius: 7,
        //             offset: Offset(0, 3))
        //       ]),
        //   height: 75,
        //   margin: EdgeInsets.only(left: 20, right: 20),
        //   width: double.infinity,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         lang!.availableTripAccount,
        //         style: const TextStyle(
        //             letterSpacing: 0.1,
        //             fontWeight: FontWeight.w600,
        //             color: kTitleBlackTextColor),
        //       ),
        //       Text(
        //         availableTripAccount,
        //         style: const TextStyle(
        //             letterSpacing: 0.1,
        //             fontWeight: FontWeight.w600,
        //             color: kPrimaryColor),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 6,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(16),
        //       boxShadow: const [
        //         BoxShadow(
        //             color: Color.fromRGBO(46, 70, 135, 225),
        //             spreadRadius: 5,
        //             blurRadius: 7,
        //             offset: Offset(0, 3))
        //       ]),
        //   height: 75,
        //   margin: EdgeInsets.only(left: 20, right: 20),
        //   width: double.infinity,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         lang!.bookedTripAccount,
        //         style: const TextStyle(
        //             letterSpacing: 0.1,
        //             fontWeight: FontWeight.w600,
        //             color: kTitleBlackTextColor),
        //       ),
        //       Text(
        //         bookedTripAccount,
        //         style: const TextStyle(
        //             letterSpacing: 0.1,
        //             fontWeight: FontWeight.w600,
        //             color: kPrimaryColor),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Divider(
        //   indent: 20,
        //   endIndent: 20,
        //   color: Color.fromARGB(255, 198, 196, 193),
        //   height: 25,
        //   thickness: 2,
        // ),

        // old code
        Consumer<FinacneViewModel>(
          builder: (context, vm, child) {
            return vm.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        if (vm.filter != 'select')
                          SearchBars(
                              hintText: lang!.nameFinancial,
                              onSubmit: (value) {
                                vm.searchByName(value);
                              },
                              onChange: (value) {
                                vm.searchByName(value);
                              }),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: FinanceFilter(
                              value: vm.filter,
                              items: vm.filterItems,
                              onChanged: (value) {
                                vm.filter = value;
                              }),
                        ),
                        if (vm.filter != 'select')
                          Column(
                            children: [
                              vm.finances.isEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Lottie.asset(
                                              'assets/animations/lottie_empty2.json',
                                              repeat: false),
                                        ),
                                        SizedBox(
                                          height: 24,
                                          child: Text(
                                            lang!.youDontHaveFinances,
                                            style: textTitle(kPrimaryColor),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        if (vm.financeSearched.isNotEmpty)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10,
                                                  left: 10,
                                                  top: 10,
                                                  bottom: 10,
                                                ),
                                                child: Text(
                                                  '${lang?.youSearchedFor} "${vm.searchText}"',
                                                  style: textTitle(
                                                          kTitleBlackTextColor)
                                                      .copyWith(
                                                          fontSize: ScreenConfig
                                                              .getFontDynamic(
                                                                  18)),
                                                ),
                                              ),
                                              FinanceList(
                                                finances: vm.financeSearched,
                                                title: '',
                                                filter: vm.filter,
                                              )
                                            ],
                                          ),
                                        FinanceList(
                                          finances: vm.finances,
                                          title: vm.filterNameDisplay,
                                          filter: vm.filter,
                                        ),
                                      ],
                                    ),
                            ],
                          )
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }
}
