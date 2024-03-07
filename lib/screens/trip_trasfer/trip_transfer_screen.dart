import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../components/default_button.dart';
import '../../providers/view_models/transfer_trip_dialog_view_model.dart';
import '../../providers/view_models/trip_details_view_model.dart';
import '../../services/service_collector.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';

class TripTransferScreen extends StatefulWidget {
  TripTransferScreen(
      {Key? key,
      required this.source,
      required this.tripPaymentDate,
      required this.isOwner,
      required this.status})
      : super(key: key);
  final String source;
  final bool isOwner;
  final String status;
  final String tripPaymentDate;

  @override
  State<TripTransferScreen> createState() => _TripTransferScreenState();
}

class _TripTransferScreenState extends State<TripTransferScreen> {
  int index = 0;
  var isTransferToPublicRole22 = true;
  var toID1 = '';
  var commission22 = '';
  var note22 = '';
  var price22 = '';
  DateTime? paymentDate11;

  var isAbleToTransfer11 = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
          title: Text(lang.transferTrip),
          leading: IconButton(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: ChangeNotifierProvider.value(
        value: TransferTripDialogViewModel(),
        child: Consumer2<TransferTripDialogViewModel, TripDetailsViewModel>(
          builder: (context, vm, v5m, child) {
            return Form(
              key: vm.formState,
              child: Stepper(
                type: StepperType.horizontal,
                physics: const BouncingScrollPhysics(),
                steps: [
                  Step(
                    isActive: index == 0 || index == 1,
                    title: const Text(''),
                    content: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    lang.transferToPrivateRole,
                                    style: textTitle(kPrimaryColor),
                                  ),
                                  Switch(
                                      value: vm.isTransferToPublicRole,
                                      onChanged: (value) {
                                        isTransferToPublicRole22 = value;
                                        vm.isTransferToPublicRole = value;
                                      }),
                                  Text(
                                    lang.transferToPublicRole,
                                    style: textTitle(kPrimaryColor),
                                  ),
                                ],
                              ),
                              if (!vm.isTransferToPublicRole)
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    _buildSearchForDriverField(vm, lang),
                                    if (vm.errorDriverStatus == 'error')
                                      Text(
                                        lang.youHaveToSelectDriverS,
                                        style: textSubtitle(Colors.red),
                                      ),
                                    if (vm.drivers.isNotEmpty)
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Text(
                                              lang.searchResult,
                                              style: textTitle(kPrimaryColor),
                                            ),
                                            ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      Checkbox(
                                                          value:
                                                              vm.isIdSelected(vm
                                                                  .drivers[
                                                                      index]
                                                                  .id),
                                                          onChanged: (value) {
                                                            vm.selectUser(vm
                                                                .drivers[index]
                                                                .id);
                                                          }),
                                                      Text(
                                                        vm.drivers[index].name,
                                                        style: textTitle1(
                                                            kNormalTextColor),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const Divider();
                                                },
                                                itemCount: vm.drivers.length),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              const SizedBox(
                                height: 12,
                              ),
                              _buildPriceField(vm, lang),
                              const SizedBox(
                                height: 16,
                              ),
                              // _buildCommissionField(vm, lang),
                              // const SizedBox(
                              //   height: 16,
                              // ),
                              _buildNoteField(vm, lang),
                              const SizedBox(
                                height: 16,
                              ),
                              _buildSelectPaymentDate(vm, lang, context),
                              const SizedBox(
                                height: 16,
                              ),
                              // _buildIsAbleToTransfer(vm, lang),
                              // const SizedBox(
                              //   height: 16,
                              // ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      toID1 = vm.toId;
                                      if (vm.price != '' &&
                                          vm.note != '' &&
                                          vm.paymentDate != null) {
                                        if (!vm.isTransferToPublicRole) {
                                          if (vm.toId == '') {
                                            if (vm.paymentDate == null) {
                                              String currentLang =
                                                  ServiceCollector.getInstance()
                                                      .currentLanguage;

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(currentLang ==
                                                              'en'
                                                          ? "Please select the payment date"
                                                          : "يرجى تحديد تاريخ التسديد")));
                                            }
                                            vm.formState.currentState!
                                                .validate();
                                          } else {
                                            commission22 = vm.commission;
                                            note22 = vm.note;
                                            price22 = vm.price;
                                            toID1 = vm.toId;
                                            isAbleToTransfer11 =
                                                vm.isAbleToTransfer;

                                            //       isTransferToPublicRole22 = vm.isTransferToPublicRole;
                                            paymentDate11 = vm.paymentDate;
                                            setState(() {
                                              index < 1 ? index++ : index;
                                            });
                                          }
                                        } else {
                                          commission22 = vm.commission;
                                          note22 = vm.note;
                                          price22 = vm.price;
                                          toID1 = vm.toId;
                                          isAbleToTransfer11 =
                                              vm.isAbleToTransfer;
                                          paymentDate11 = vm.paymentDate;

                                          setState(() {
                                            index < 1 ? index++ : index;
                                          });
                                        }
                                      } else {
                                        if (vm.paymentDate == null) {
                                          String currentLang =
                                              ServiceCollector.getInstance()
                                                  .currentLanguage;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(currentLang ==
                                                          'en'
                                                      ? "Please select the payment date"
                                                      : "يرجى تحديد تاريخ التسديد")));
                                        }
                                        vm.formState.currentState!.validate();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: kPrimaryColor,
                                      ),
                                      child: Text(
                                        lang.addNewMony,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[400],
                                      ),
                                      child: Text(
                                        lang.canceltextButton,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Step(
                      isActive: index == 1,
                      title: const Text(
                        '',
                      ),
                      content: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  lang.addMony,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                const SizedBox(
                                  height: 16,
                                ),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor
                                                    .withOpacity(.8),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          lang.transferScreenName,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Container(
                                                          height: 46,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: TextFormField(
                                                            controller:
                                                                vm.listItemControllers[
                                                                    index][0],
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText: '',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              fillColor:
                                                                  Colors.white,
                                                              isDense: true,
                                                              filled: true,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          lang.transferScreenPrice,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Container(
                                                          height: 46,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          alignment:
                                                              Alignment.center,
                                                          child: TextFormField(
                                                            controller:
                                                                vm.listItemControllers[
                                                                    index][1],
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText: '',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              fillColor:
                                                                  Colors.white,
                                                              isDense: true,
                                                              filled: true,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          lang.paymentType,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        _buildPaymentTypeSelector(
                                                            vm, lang, index),
                                                        // Row(
                                                        //   children: [
                                                        //     Expanded(
                                                        //       child: Container(
                                                        //         height: 46,
                                                        //         decoration: const BoxDecoration(
                                                        //             color: Colors
                                                        //                 .white,
                                                        //             borderRadius: BorderRadius.only(
                                                        //                 topRight:
                                                        //                     Radius.circular(
                                                        //                         8),
                                                        //                 bottomRight:
                                                        //                     Radius.circular(8))),
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .center,
                                                        //         child:
                                                        //             TextFormField(
                                                        //           controller: vm
                                                        //                   .listItemControllers[
                                                        //               index][2],
                                                        //           keyboardType:
                                                        //               TextInputType
                                                        //                   .datetime,
                                                        //           decoration: InputDecoration(
                                                        //               hintText: vm.listItemControllers[index][2].text.isEmpty
                                                        //                   ? ServiceCollector.getInstance().currentLanguage == 'en'
                                                        //                       ? "not set"
                                                        //                       : "لم يتم اختيار التاريخ "
                                                        //                   : vm.listItemControllers[index][2].text,
                                                        //               border: InputBorder.none,
                                                        //               fillColor: Colors.white,
                                                        //               isDense: true,
                                                        //               filled: true,
                                                        //               enabled: false),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //     Container(
                                                        //       height: 46,
                                                        //       padding: const EdgeInsets
                                                        //               .symmetric(
                                                        //           horizontal:
                                                        //               6),
                                                        //       decoration: const BoxDecoration(
                                                        //           color: Colors
                                                        //               .white,
                                                        //           borderRadius: BorderRadius.only(
                                                        //               topLeft:
                                                        //                   Radius.circular(
                                                        //                       8),
                                                        //               bottomLeft:
                                                        //                   Radius.circular(
                                                        //                       8))),
                                                        //       alignment: Alignment
                                                        //           .centerLeft,
                                                        //       child: InkWell(
                                                        //         onTap: () {
                                                        //           vm.setPaymentDatePrice(
                                                        //               context,
                                                        //               index);
                                                        //         },
                                                        //         child: Text(
                                                        //           lang.select,
                                                        //           style: textTitle(
                                                        //               Colors
                                                        //                   .black),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      vm.listItemControllers
                                                                      .length -
                                                                  1 ==
                                                              index
                                                          ? InkWell(
                                                              onTap: () {
                                                                vm.add(context);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 2,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.white,
                                                                          width:
                                                                              1,
                                                                        )),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      lang.addNewMony,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .add_rounded,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      vm.listItemControllers
                                                                      .length -
                                                                  1 ==
                                                              index
                                                          ? InkWell(
                                                              onTap: () {
                                                                vm.delete();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 2,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.red,
                                                                          width:
                                                                              1,
                                                                        )),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      lang.delete,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                ]),
                                          ),
                                        ]);
                                  },
                                  itemCount: vm.listItemControllers.length,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // word here
                                vm.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : DefaultButton(
                                        buttonWidth: double.infinity,
                                        buttonText: lang.transfer,
                                        onpressed: () {
                                          print(
                                              "AAAAAAAAAAAAAAAAAAAAAAAAA ${toID1}");
                                          if (vm.check()) {
                                            if (int.parse(
                                                    commission22.toString()) >
                                                int.parse(price22.toString())) {
                                              String currentLang =
                                                  ServiceCollector.getInstance()
                                                      .currentLanguage;
                                              Fluttertoast.showToast(
                                                msg: currentLang == 'en'
                                                    ? 'The commission cannot be greater than the flight price'
                                                    : 'لا يمكن ان تكون العمولة اكبر من سعر الرحلة',
                                                toastLength: Toast.LENGTH_SHORT,
                                              );
                                            } else {
                                              vm.submitForm12(
                                                context: context,
                                                path: widget.source,
                                                isTransferToPublicRole22:
                                                    isTransferToPublicRole22,
                                                commission22: commission22,
                                                isUpdate: widget.isOwner &&
                                                    (widget.status == "1" ||widget.status == "17" ||
                                                        widget.status == "2" ||
                                                        widget.status == "12" ||
                                                        widget.status == "22"),
                                                isAbleToTransfer11:
                                                    isAbleToTransfer11,
                                                note22: note22,
                                                price22: price22,
                                                toID1: toID1,
                                                paymentDate11:
                                                    paymentDate11.toString(),
                                              );
                                            }
                                          } else {
                                            String currentLang =
                                                ServiceCollector.getInstance()
                                                    .currentLanguage;

                                            Fluttertoast.showToast(
                                              msg: currentLang == 'en'
                                                  ? 'please fill data'
                                                  : 'املأ البيانات',
                                              toastLength: Toast.LENGTH_SHORT,
                                            );
                                          }
                                        }),
                              ]),
                        ),
                      ),
                      state: StepState.complete),
                ],
                onStepContinue: () {
                  print("AAAAAAAAAAAAAAAAAAAAAAAAA ${toID1}");
                  if (index == 1 && vm.check()) {
                    toID1 = vm.toId;
                    if (int.parse(commission22.toString()) >
                        int.parse(price22.toString())) {
                      String currentLang =
                          ServiceCollector.getInstance().currentLanguage;
                      Fluttertoast.showToast(
                        msg: currentLang == 'en'
                            ? 'The commission cannot be greater than the flight price'
                            : 'لا يمكن ان تكون العمولة اكبر من سعر الرحلة',
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else {
                      vm.submitForm12(
                        context: context,
                        path: widget.source,
                        isTransferToPublicRole22: isTransferToPublicRole22,
                        commission22: commission22,
                        isAbleToTransfer11: isAbleToTransfer11,
                        note22: note22,
                        price22: price22,   isUpdate: widget.isOwner &&
                          (widget.status == "1" ||widget.status == "17" ||
                              widget.status == "2" ||
                              widget.status == "12" ||
                              widget.status == "22"),
                        toID1: toID1,
                        paymentDate11: paymentDate11.toString(),
                      );
                    }
                  } else {
                    String currentLang =
                        ServiceCollector.getInstance().currentLanguage;
                    Fluttertoast.showToast(
                      msg: currentLang == 'en'
                          ? 'please fill data'
                          : 'املأ البيانات',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
                onStepCancel: () {
                  Navigator.pop(context);
                },
                controlsBuilder: (c, v) {
                  return index == 0
                      ? Column(
                          children: [
                            vm.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : DefaultButton(
                                    buttonWidth: double.infinity,
                                    buttonText: lang.transfer,
                                    onpressed: () {
                                      if (vm.price != '' &&
                                          vm.note != '' &&
                                          vm.paymentDate != null) {
                                        if (!vm.isTransferToPublicRole) {
                                          if (vm.toId == '') {
                                            if (vm.paymentDate == null) {
                                              String currentLang =
                                                  ServiceCollector.getInstance()
                                                      .currentLanguage;

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(currentLang ==
                                                              'en'
                                                          ? "Please select the payment date"
                                                          : "يرجى تحديد تاريخ التسديد")));
                                            }
                                            vm.formState.currentState!
                                                .validate();
                                          } else {
                                            commission22 = vm.commission;
                                            note22 = vm.note;
                                            price22 = vm.price;
                                            toID1 = vm.toId;
                                            isAbleToTransfer11 =
                                                vm.isAbleToTransfer;
                                            paymentDate11 = vm.paymentDate;
                                          }
                                        } else {
                                          commission22 = vm.commission;
                                          note22 = vm.note;
                                          price22 = vm.price;
                                          toID1 = vm.toId;
                                          isAbleToTransfer11 =
                                              vm.isAbleToTransfer;
                                          paymentDate11 = vm.paymentDate;
                                        }
                                        if (int.parse(commission22.toString()) >
                                            int.parse(price22.toString())) {
                                          String currentLang =
                                              ServiceCollector.getInstance()
                                                  .currentLanguage;
                                          Fluttertoast.showToast(
                                            msg: currentLang == 'en'
                                                ? 'The commission cannot be greater than the flight price'
                                                : 'لا يمكن ان تكون العمولة اكبر من سعر الرحلة',
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                        } else {
                                          vm.submitForm12(
                                            context: context,
                                            path: widget.source,
                                            isTransferToPublicRole22:
                                                isTransferToPublicRole22,
                                            commission22: commission22,
                                            isAbleToTransfer11:
                                                isAbleToTransfer11,   isUpdate: widget.isOwner &&
                                              (widget.status == "1" ||widget.status == "17" ||
                                                  widget.status == "2" ||
                                                  widget.status == "12" ||
                                                  widget.status == "22"),
                                            note22: note22,
                                            price22: price22,
                                            toID1: toID1,
                                            paymentDate11:
                                                paymentDate11.toString(),
                                          );
                                        }
                                      } else {
                                        if (vm.paymentDate == null) {
                                          String currentLang =
                                              ServiceCollector.getInstance()
                                                  .currentLanguage;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(currentLang ==
                                                          'en'
                                                      ? "Please select the payment date"
                                                      : "يرجى تحديد تاريخ التسديد")));
                                        }
                                        vm.formState.currentState!.validate();
                                      }
                                    }),
                          ],
                        )
                      : Container();
                },
                currentStep: index,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchForDriverField(
      TransferTripDialogViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 0))
            ]),
      ),
      TextFormField(
        cursorColor: kPrimaryColor,
        onFieldSubmitted: (value) {
          vm.searchByName(value);
        },
        onChanged: (value) {
          if (value.length % 2 != 0) {
            vm.searchByName(value);
          }
        },
        onSaved: (value) {
          //   vm.toId = value!;
        },
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          labelText: lang!.searchForDriver,
          labelStyle: const TextStyle(color: kPrimaryColor),
          suffixIcon: const Icon(
            Icons.search,
            color: kPrimaryColor,
          ),
          fillColor: Colors.white,
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      )
    ]);
  }

  Widget _buildPriceField(
      TransferTripDialogViewModel vm, AppLocalizations? lang) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 49,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 5,
                    offset: Offset(0, 0))
              ]),
        ),
        TextFormField(
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: true,
          ),
          cursorColor: kPrimaryColor,
          onChanged: (value) {
            vm.price = value;
          },
          validator: (value) {
            if (value!.isEmpty) return lang!.fieldIsEmpty;
            return null;
          },
          decoration: InputDecoration(
            labelText: lang!.price,
            labelStyle: const TextStyle(color: kPrimaryColor),
            suffixIcon: const Icon(
              Icons.note,
              color: kPrimaryColor,
            ),
            fillColor: Colors.white,
            isDense: true,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent)),
          ),
        ),
      ],
    );
  }

  Widget _buildCommissionField(
      TransferTripDialogViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 5,
                  offset: const Offset(0, 0))
            ]),
      ),
      TextFormField(
        initialValue: '0',
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: true,
        ),
        cursorColor: kPrimaryColor,
        onChanged: (value) {
          vm.commission = value;
        },
        validator: (value) {
          if (value!.isEmpty) return lang!.fieldIsEmpty;
          return null;
        },
        decoration: InputDecoration(
          labelText: lang!.commission,
          labelStyle: const TextStyle(color: kPrimaryColor),
          suffixIcon: const Icon(
            Icons.note,
            color: kPrimaryColor,
          ),
          fillColor: Colors.white,
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      )
    ]);
  }

  Widget _buildNoteField(
      TransferTripDialogViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 5,
                  offset: const Offset(0, 0))
            ]),
      ),
      TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        minLines: 1,
        cursorColor: kPrimaryColor,
        onChanged: (value) {
          vm.note = value;
        },
        validator: (value) {
          if (value!.isEmpty) return lang!.fieldIsEmpty;
          return null;
        },
        decoration: InputDecoration(
          labelText: lang!.note,
          labelStyle: const TextStyle(color: kPrimaryColor),
          suffixIcon: const Icon(
            Icons.note,
            color: kPrimaryColor,
          ),
          fillColor: Colors.white,
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      )
    ]);
  }

  Padding _buildSelectPaymentDate(TransferTripDialogViewModel vm,
      AppLocalizations lang, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Text(
            lang.paymentDate,
            style: textTitle(kPrimaryColor),
          ),
          Expanded(
            child: Text(
              vm.paymentDateText,
              style: textTitle(kNormalTextColor),
            ),
          ),
          Material(
            child: InkWell(
              onTap: () {
                vm.setPaymentDate(context, widget.tripPaymentDate);
              },
              child: Text(
                lang.select,
                style: textTitle(kPrimaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _buildIsAbleToTransfer(
      TransferTripDialogViewModel vm, AppLocalizations? lang) {
    return Row(
      children: [
        Checkbox(
            value: vm.isAbleToTransfer,
            onChanged: (value) {
              vm.isAbleToTransfer = value;
            }),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: lang!.isAbleToTransfer,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kNormalTextColor,
            ),
          ),
        ]))
      ],
    );
  }
}

Container _buildPaymentTypeSelector(
    TransferTripDialogViewModel vm, AppLocalizations? lang, int index) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
          underline: Container(),
          isExpanded: true,
          value: vm.listItemControllers[index][2].text.isEmpty
              ? "1"
              : vm.listItemControllers[index][2].text,
          items: vm.menuItems,
          onChanged: (value) {
            vm.paymentType(value, index);
          }),
    ),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8)),
  );
}
