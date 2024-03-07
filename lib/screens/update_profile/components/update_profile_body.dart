import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/update_profile_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/screens/deleteAccount/delete_account_screen.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import '../../../utils/screen_config.dart';

class UpdateProfileBody extends StatelessWidget {
  const UpdateProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return FutureBuilder(
      future: Provider.of<UpdateProfileViewModel>(context, listen: false)
          .syncProfileData(
              Provider.of<AuthProvider>(context, listen: false).user.id , context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Consumer<UpdateProfileViewModel>(
              builder: (context, vm, child) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                    key: vm.formState,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            lang!.profileData,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: kPrimaryColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            InkWell(
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showModalBottomSheet<void>(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    isDismissible: true,
                                    context: context,
                                    builder: (BuildContext contesxt) {
                                      return SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 20,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                lang.selectPath,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 32,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  kPrimaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: const Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.white,
                                                              size: 25,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            vm.getImage(
                                                                false, context);
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        lang.album,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  kPrimaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: const Icon(
                                                              Icons.camera_alt,
                                                              color:
                                                                  Colors.white,
                                                              size: 25,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            vm.getImage(
                                                              true,
                                                              context,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        lang.camera,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 32,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: ScreenConfig.getFontDynamic(50),
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  backgroundImage:
                                  vm.image != null?FileImage(vm.image!) as ImageProvider:
                                  Provider.of<AuthProvider>(context)
                                      .user
                                      .imgUrl ==
                                      null? const AssetImage(
                                      'assets/images/user_profile.png'):NetworkImage(
                                      Provider.of<AuthProvider>(context)
                                          .user
                                          .imgUrl!) as ImageProvider,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.edit_sharp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        _buildPhoneNumber(vm, lang),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        _buildPhone2Number(vm, lang),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        _buildCarLicenseNumber(vm, lang),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        _buildDriverLicenseId(vm, lang),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        _buildCarNumberField(vm, lang),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        _buildLicenseEndDateSelector(vm, context, lang),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        _buildSelectOffie(context, vm, lang),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(22)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                              ScreenConfig.getRuntimeWidthByRatio(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.carType,
                                style: textTitle(kPrimaryColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  value: vm.carType,
                                  items: vm.carModels
                                      .map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.id,
                                      child: Text(e.carType),
                                    );
                                  }).toList(),
                                  onChanged: (v) {
                                      vm.setCarType = v;
                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(10)),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang.carSize,
                                  style: textTitle(kPrimaryColor),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 10,),
                                vm.carSizes.isNotEmpty? DropdownButton(
                                    underline: Container(),
                                    isExpanded: true,
                                    value: vm.carSize!=""?vm.carSize :vm.carSizes[0].id ,
                                    items: vm.carSizes
                                        .map<DropdownMenuItem<String>>(
                                            (e) => DropdownMenuItem<String>(
                                          value: e.id,
                                          child: Text(e.carSeat),
                                        ))
                                        .toList(),
                                    onChanged: (value) {
                                      // vm.setCarSize = value;
                                    }):Container(),
                                // Text(Provider.of<LanguageProvider>(context, listen: false)
                                //     .currentLanguage ==
                                //     "en"?vm.carSizes.firstWhere((element) => vm.carSize==element.id).carSeatEnglish:vm.carSizes.firstWhere((element) => vm.carSize==element.id).carSeatArabic,
                                //   textAlign: TextAlign.start,
                                //   style: TextStyle(
                                //     color: Colors.grey[800],
                                //   ),
                                //
                                // ),
                                const SizedBox(height: 10,)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(10)),
                        vm.isLoading
                            ? const CircularProgressIndicator()
                            : DefaultButton(
                                buttonWidth: double.infinity,
                                buttonText: lang.updateData,
                                onpressed: () {
                                  vm.submit(context);
                                }),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(16)),
                        Row(
                          children: [
                            SizedBox(
                              width: ScreenConfig.getRuntimeWidthByRatio(4),
                            ),
                            Text(
                              lang.deleteAccountText,
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16),
                            ),
                            SizedBox(
                              width: ScreenConfig.getRuntimeWidthByRatio(4),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DeleteAccountScreen(),
                                    ));
                              },
                              child: Text(
                                lang.clickHere,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(20)),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildPhoneNumber(UpdateProfileViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: const Offset(0, 0))
            ]),
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        cursorColor: kPrimaryColor,
        initialValue: vm.phone,
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

  Widget _buildPhone2Number(UpdateProfileViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: const Offset(0, 0))
            ]),
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        initialValue: vm.phone2,
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

  Widget _buildCarLicenseNumber(
      UpdateProfileViewModel vm, AppLocalizations? lang) {
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
        keyboardType: TextInputType.number,
        initialValue: vm.carLisenseId,
        cursorColor: kPrimaryColor,
        onSaved: (value) {
          vm.carLisenseId = value;
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
    ]);
  }

  Widget _buildDriverLicenseId(
      UpdateProfileViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: const Offset(0, 0))
            ]),
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        initialValue: vm.driverLisenseId,
        cursorColor: kPrimaryColor,
        onSaved: (value) {
          vm.driverLisenseId = value;
        },
        validator: (value) {
          if (value!.isEmpty) return 'Field is empty';
          return null;
        },
        decoration: InputDecoration(
          labelText: lang!.driverLicenseId,
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

  Widget _buildCarNumberField(
      UpdateProfileViewModel vm, AppLocalizations? lang) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 49,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, offset: const Offset(0 , 0 ),
              ),
            ]),
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        initialValue: vm.carNumber,
        cursorColor: kPrimaryColor,
        onSaved: (value) {
          vm.carNumber = value;
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

  Widget _buildLicenseEndDateSelector(
      UpdateProfileViewModel vm, BuildContext context, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.licenseEndDate,
            style: textTitle(kPrimaryColor),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(vm.endDateAsUserDisplay),
                TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100))
                          .then((value) {
                        if (value == null) return;

                        vm.driverLisenseEndDate =
                            '${value.year}-${value.month}-${value.day}';
                      });
                    },
                    child: Text(
                      lang.change,
                      style: textSubtitle(kPrimaryColor),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _buildSelectOffie(
      BuildContext context, UpdateProfileViewModel vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.selectOffice,
            style: textTitle(kPrimaryColor),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Text((vm.officeId == '')
                  ? lang.notset
                  : vm.getSelectedOffice!.officeName)),
          if (!vm.isDriverRelatedWithOffice)
            TextButton(
                onPressed: () {
                  vm.showSelectOffieSheet(context);
                },
                child: Text(
                  lang.select,
                  style: textSubtitle(kPrimaryColor),
                )),
          if (vm.isDriverRelatedWithOffice)
            TextButton(
                onPressed: () {
                  vm.deleteOffice();
                },
                child: Text(
                  lang.delete,
                  style: textSubtitle(Colors.red),
                )),
        ],
      ),
    );
  }
}

/*

"selectedOfficeId":"1",
"selectedOfficeNameEn":"Anas Test",
"selectedOfficeNameAr":"تجربة"

*/
