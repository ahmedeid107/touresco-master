// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:touresco/components/default_button.dart';
// import 'package:touresco/providers/view_models/transfer_trip_dialog_view_model.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import 'package:touresco/theme.dart';
// import 'package:touresco/utils/constants.dart';
//
// class TransferTripDialog extends StatelessWidget {
//   const TransferTripDialog(
//       {Key? key, required this.previousContext, required this.tripSource})
//       : super(key: key);
//
//   final BuildContext previousContext;
//   final String tripSource;
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = AppLocalizations.of(context);
//     return ChangeNotifierProvider.value(
//       value: TransferTripDialogViewModel(),
//       child: Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Consumer<TransferTripDialogViewModel>(
//               builder: (context, vm, child) {
//                 return Form(
//                   key: vm.formState,
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const SizedBox(height: 12),
//                           Text(
//                             lang!.transferTrip,
//                             style: textTitle(kPrimaryColor),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 lang.transferToPrivateRole,
//                                 style: textTitle(kPrimaryColor),
//                               ),
//                               Switch(
//                                   value: vm.isTransferToPublicRole,
//                                   onChanged: (value) {
//                                     vm.isTransferToPublicRole = value;
//                                   }),
//                               Text(
//                                 lang.transferToPublicRole,
//                                 style: textTitle(kPrimaryColor),
//                               ),
//                             ],
//                           ),
//                           if (!vm.isTransferToPublicRole)
//                             Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 12,
//                                 ),
//                                 _buildSearchForDriverField(vm, lang),
//                                 if (vm.errorDriverStatus == 'error')
//                                   Text(
//                                     lang.youHaveToSelectDriverS,
//                                     style: textSubtitle(Colors.red),
//                                   ),
//                                 if (vm.drivers.isNotEmpty)
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 10),
//                                     padding: const EdgeInsets.all(8),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           lang.searchResult,
//                                           style: textTitle(kPrimaryColor),
//                                         ),
//                                         ListView.separated(
//                                             shrinkWrap: true,
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             itemBuilder: (context, index) {
//                                               return Row(
//                                                 children: [
//                                                   Checkbox(
//                                                       value: vm.isIdSelected(
//                                                           vm.drivers[index].id),
//                                                       onChanged: (value) {
//                                                         vm.selectUser(vm
//                                                             .drivers[index].id);
//                                                       }),
//                                                   Text(
//                                                     vm.drivers[index].name,
//                                                     style: textTitle(
//                                                         kNormalTextColor),
//                                                   ),
//                                                 ],
//                                               );
//                                             },
//                                             separatorBuilder: (context, index) {
//                                               return const Divider();
//                                             },
//                                             itemCount: vm.drivers.length),
//                                       ],
//                                     ),
//                                   )
//                               ],
//                             ),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           _buildPriceField(vm, lang),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           _buildCommissionField(vm, lang),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           _buildNoteField(vm, lang),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           _buildSelectPaymentDate(vm, lang, context),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           _buildIsAbleToTransfer(vm, lang),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           vm.isLoading
//                               ? const CircularProgressIndicator()
//                               : DefaultButton(
//                                   buttonWidth: double.infinity,
//                                   buttonText: lang.transfer,
//                                   onpressed: () {
//                                     vm.submitForm(
//                                         context, previousContext, tripSource,
//
//                                     );
//                                   }),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                         ]),
//                   ),
//                 );
//               },
//             )),
//       ),
//     );
//   }
//
//   Widget _buildSearchForDriverField(
//       TransferTripDialogViewModel vm, AppLocalizations? lang) {
//     return Stack(
//         children: [
//       Container(
//         width: double.infinity,
//         height: 49,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 0))
//             ]),
//       ),
//       TextFormField(
//         cursorColor: kPrimaryColor,
//         onFieldSubmitted: (value) {
//           vm.searchByName(value);
//         },
//         onChanged: (value){
//                 if(value.length%2!=0){
//                   vm.searchByName(value);
//                 }
//         },
//         onSaved: (value) {
//
//           //   vm.toId = value!;
//         },
//         validator: (value) {
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: lang!.searchForDriver,
//           labelStyle: const TextStyle(color: kPrimaryColor),
//           suffixIcon: const Icon(
//             Icons.search,
//             color: kPrimaryColor,
//           ),
//           fillColor: Colors.white,
//           isDense: true,
//           filled: true,
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(20)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//         ),
//       )
//     ]);
//   }
//
//   Widget _buildPriceField(
//       TransferTripDialogViewModel vm, AppLocalizations? lang) {
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 49,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey[300]!,
//                     blurRadius: 5,
//                     offset: Offset(0, 0))
//               ]),
//         ),
//         TextFormField(
//           keyboardType: const TextInputType.numberWithOptions(
//             signed: false,
//             decimal: true,
//           ),
//           cursorColor: kPrimaryColor,
//           onSaved: (value) {
//             vm.price = value!;
//           },
//           validator: (value) {
//             if (value!.isEmpty) return lang!.fieldIsEmpty;
//             return null;
//           },
//           decoration: InputDecoration(
//             labelText: lang!.price,
//             labelStyle: const TextStyle(color: kPrimaryColor),
//             suffixIcon: const Icon(
//               Icons.note,
//               color: kPrimaryColor,
//             ),
//             fillColor: Colors.white,
//             isDense: true,
//             filled: true,
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: const BorderSide(color: Colors.transparent)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.transparent),
//                 borderRadius: BorderRadius.circular(20)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: const BorderSide(color: Colors.transparent)),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: const BorderSide(color: Colors.transparent)),
//             errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: const BorderSide(color: Colors.transparent)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCommissionField(
//       TransferTripDialogViewModel vm, AppLocalizations? lang) {
//     return Stack(
//         children: [
//       Container(
//         width: double.infinity,
//         height: 49,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 0))
//             ]),
//       ),
//       TextFormField(
//         initialValue: '0',
//         keyboardType: const TextInputType.numberWithOptions(
//           signed: false,
//           decimal: true,
//         ),
//         cursorColor: kPrimaryColor,
//         onSaved: (value) {
//           vm.commission = value!;
//         },
//         validator: (value) {
//           if (value!.isEmpty) return lang!.fieldIsEmpty;
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: lang!.commission,
//           labelStyle: const TextStyle(color: kPrimaryColor),
//           suffixIcon: const Icon(
//             Icons.note,
//             color: kPrimaryColor,
//           ),
//           fillColor: Colors.white,
//           isDense: true,
//           filled: true,
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(20)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//         ),
//       )
//     ]);
//   }
//
//   Widget _buildNoteField(
//       TransferTripDialogViewModel vm, AppLocalizations? lang) {
//     return Stack(children: [
//       Container(
//         width: double.infinity,
//         height: 49,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 0))
//             ]),
//       ),
//       TextFormField(
//         keyboardType: TextInputType.multiline,
// maxLines: 3,
//         minLines: 1,
//         cursorColor: kPrimaryColor,
//         onSaved: (value) {
//           vm.note = value!;
//         },
//         validator: (value) {
//           if (value!.isEmpty) return lang!.fieldIsEmpty;
//           return null;
//         },
//         decoration: InputDecoration(
//             labelText: lang!.note,
//             labelStyle: const TextStyle(color: kPrimaryColor),
//             suffixIcon: const Icon(
//               Icons.note,
//               color: kPrimaryColor,
//             ),fillColor: Colors.white,
//           isDense: true,
//           filled: true,
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(20)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(color: Colors.transparent)),
//         ),
//       )
//     ]);
//   }
//
//   Padding _buildSelectPaymentDate(TransferTripDialogViewModel vm,
//       AppLocalizations lang, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: Row(
//         children: [
//           Text(
//             lang.paymentDate,
//             style: textTitle(kPrimaryColor),
//           ),
//           Expanded(
//             child: Text(
//               vm.paymentDateText,
//               style: textTitle(kNormalTextColor),
//             ),
//           ),
//           Material(
//             child: InkWell(
//               onTap: () {
//                 vm.setPaymentDate(context , "");
//               },
//               child: Text(
//                 lang.select,
//                 style: textTitle(kPrimaryColor),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Row _buildIsAbleToTransfer(
//       TransferTripDialogViewModel vm, AppLocalizations? lang) {
//     return Row(
//       children: [
//         Checkbox(
//             value: vm.isAbleToTransfer,
//             onChanged: (value) {
//               vm.isAbleToTransfer = value;
//             }),
//         RichText(
//             text: TextSpan(children: [
//           TextSpan(
//               text: lang!.isAbleToTransfer, style: textTitle(kNormalTextColor)),
//         ]))
//       ],
//     );
//   }
// }
