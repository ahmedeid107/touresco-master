import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/providers/view_models/sign_up_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/car_size_model.dart';
import '../../../models/car_type_model.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  List<CarSizeModel> carSizes = [];
  List<CarTypeModel> _carModels = [];

  List<CarTypeModel> get carModels => [..._carModels];
  var carSize = "";
  var carType = "1";

  @override
  void initState() {
    ServiceCollector.getInstance()
        .metaDataService
        .getAllCarType()
        .then((value) {
      setState(() {
        _carModels = value;
      });
    });
    // TODO: implement initState
    ServiceCollector.getInstance().authService.getAllSize("1").then((value) {
      setState(() {
        carSizes = value;
        if (value.isNotEmpty) {
          carSize = value[value.length - 1].id;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<SignUpViewModel>(context, listen: false)
            .syncAndFetchCarTypes();
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<SignUpViewModel>(context, listen: false)
            .syncAndFetchCarSizes();
      },
    );

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getRuntimeWidthByRatio(20)),
      child: Consumer<SignUpViewModel>(
        builder: (context, vm, child) {
          return Form(
            key: vm.formState,
            child: Column(
              children: [
                Stack(
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
                                offset: const Offset(0, 0))
                          ]),
                    ),
                    TextFormField(
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {
                        vm.fullName = value;
                      },
                      validator: (value) {
                        if (value == null) return 'Name is empty';
                        if (value.length < 8) return 'Name is too short';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang!.fullname,
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        suffixIcon: const Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        fillColor: Colors.white,
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Stack(
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
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: kPrimaryColor,
                      onChanged: (value) {
                        vm.tempEmail = value;
                      },
                      onSaved: (value) {
                        vm.email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Email is empty';
                        bool isEmailValid = RegExp(emailRegex).hasMatch(value);
                        if (!isEmailValid) return 'Email format is wrong';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang!.email,
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        suffixIcon: const Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        fillColor: Colors.white,
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Stack(children: [
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
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    obscureText: vm.isPasswordVisible,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {
                      vm.password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Email is empty';
                      if (value.length < 8)
                        return 'Password is less than 8 character';

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: lang!.password,
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      suffixIcon: InkWell(
                        onTap: () {
                          vm.isPasswordVisible = !vm.isPasswordVisible;
                        },
                        child: vm.isPasswordVisible
                            ? const Icon(
                                Icons.visibility_off,
                                color: kPrimaryColor,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: kPrimaryColor,
                              ),
                      ),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  )
                ]),

                const SizedBox(
                  height: 12,
                ),
                Stack(children: [
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
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {
                      vm.phone = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Phone number is empty';
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: lang!.phoneNumber,
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      suffixIcon: const Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 12,
                ),
                Stack(children: [
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
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {
                      if (value!.isEmpty) return;
                      vm.phone2 = value;
                    },
                    decoration: InputDecoration(
                      labelText: lang!.phoneNumber2,
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      suffixIcon: const Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 10,
                ),
                Stack(
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
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {
                        //   vm.cardId = int.parse(value!);
                        vm.cardId = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Card id is empty';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang!.carLiscenseNumber,
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        suffixIcon: const Icon(
                          Icons.card_travel,
                          color: kPrimaryColor,
                        ),
                        fillColor: Colors.white,
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Stack(
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
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {
                        vm.driverId = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Field is empty';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang.driverLicenseId,
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        suffixIcon: const Icon(
                          Icons.car_rental,
                          color: kPrimaryColor,
                        ),
                        fillColor: Colors.white,
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ],
                ),
                //   _buildDriverLicenseDate(vm),
                const SizedBox(
                  height: 12,
                ),
                Stack(
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
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {
                        vm.carNumber = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Field is empty';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: lang!.carNumber,
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        suffixIcon: const Icon(
                          Icons.car_rental,
                          color: kPrimaryColor,
                        ),
                        fillColor: Colors.white,
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            lang.licenseEndDate3,
                            style: textTitle(kPrimaryColor),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(vm.licenseDate == null
                              ? lang.notset
                              : DateFormat.yMEd(ServiceCollector.getInstance()
                                      .currentLanguage)
                                  .format(vm.licenseDate!)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100))
                                    .then((value) {
                                  if (value == null) return;
                                  vm.licenseDate = value;
                                });
                              },
                              child: Text(
                                lang.change,
                                style: textSubtitle(kPrimaryColor),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenConfig.getRuntimeHeightByRatio(50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton(
                      underline: Container(),
                      isExpanded: true,
                      value: carType,
                      items: carModels.map<DropdownMenuItem<String>>((e) {
                        return DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.carType),
                        );
                      }).toList(),
                      onChanged: (v) async {
                        setState(() {
                          carType = v.toString();
                          carSize = "";
                          vm.carSize = "";
                        });
                        vm.getAllCarSizes(v.toString()).then(
                          (value) {
                            carSizes = value;
                            if (value.isNotEmpty) {
                              setState(() {
                                carSize = value[value.length - 1].id;
                              });
                            }
                          },
                        );
                      }),
                ),

                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: ScreenConfig.getRuntimeHeightByRatio(50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: carSizes.isNotEmpty
                      ? DropdownButton(
                          underline: Container(),
                          isExpanded: true,
                          value: carSize != "" ? carSize : carSizes[0].id,
                          items: carSizes
                              .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem<String>(
                                        value: e.id,
                                        child: Text(
                                          e.carSeat,
                                          textAlign: TextAlign.center,
                                        ),
                                      ))
                              .toList(),
                          onChanged: (value) {
                            carSize = value.toString();
                            // vm.setCarSize = value;
                          })
                      : Container(),
                )
                // vm.isLoadingCarTypes
                //     ? Container(
                //         height: 30,
                //         width: 30,
                //         child: const CircularProgressIndicator(),
                //       )
                //     : _buildCarTypeSelector(vm, lang),
                // const SizedBox(
                //   height: 8,
                ,
                // vm.isLoadingCarSizes
                //     ? Container(
                //         height: 30,
                //         width: 30,
                //         child: const CircularProgressIndicator())
                //     : _buildCarSizeSelector(vm, lang),
                // const SizedBox(
                //   height: 4,
                // ),
                /*    _buildBirthdaySetter(vm, context, lang),*/
                _buildSelectOffie(context, vm, lang),
                const SizedBox(
                  height: 4,
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text(
                //         lang!.activateAsOwner,
                //         style: textTitle(kPrimaryColor),
                //       ),
                //       Switch(
                //           value: vm.isActivatingOwnerDashboard,
                //           onChanged: (value) async {
                //             await vm
                //                 .checkIfUserEmailNotExistingAsOwner(context);
                //        }),
                //      ],
                //    ),
                //  ),

                const SizedBox(
                  height: 4,
                ),
                _buildPrivacyPolicyChecker(vm, lang),
                const SizedBox(
                  height: 4,
                ),
                vm.isLoadingSubmit
                    ? const CircularProgressIndicator()
                    : DefaultButton(
                        buttonWidth: double.infinity,
                        buttonText: lang.signup,
                        onpressed: () {
                          vm.submitForm(context, carSize, carType);
                        }),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding _buildSelectOffie(
      BuildContext context, SignUpViewModel vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.selectOffice,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(child: Text(vm.officeName)),
          TextButton(
              onPressed: () {
                vm.showSelectOffieSheet(context);
              },
              child: Text(
                lang.select,
                style: textSubtitle(kPrimaryColor),
              ))
        ],
      ),
    );
  }

  Row _buildPrivacyPolicyChecker(SignUpViewModel vm, AppLocalizations? lang) {
    return Row(
      children: [
        Checkbox(
            value: vm.policy,
            onChanged: (value) {
              vm.policy = value;
            }),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: lang!.agreeTo, style: textTitle(kNormalTextColor)),
          TextSpan(
              text: lang.privacy,
              style: textTitle(kPrimaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () => vm.showPrivacyPolicy())
        ]))
      ],
    );
  }

// #region Builders
  Padding _buildCarTypeSelector(SignUpViewModel vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.vehicleCapacity3,
            style: textTitle(kPrimaryColor),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                value: vm.carType,
                hint: Text(
                  lang.selectCarType,
                  style: textSubtitle(kNormalTextColor),
                ),
                items: vm.carTypes
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  vm.carType = value as String;
                  vm.carTypeId = vm.getCarTypesId(value);
                }),
          )
        ],
      ),
    );
  }

  Padding _buildCarSizeSelector(SignUpViewModel vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.selectCarSize,
            style: textTitle(kPrimaryColor),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: DropdownButton(
                isExpanded: true,
                value: vm.carSize,
                underline: Container(),
                items: vm.carSizes
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  vm.carSize = value as String;
                }),
          )
        ],
      ),
    );
  }
}
