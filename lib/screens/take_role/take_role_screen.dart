import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/take_role_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:touresco/utils/theme.dart';

import '../../components/default_button.dart';
import '../../components/exbandable_item_default.dart';
import '../../providers/auth_provider.dart';
import '../../providers/trips_provider.dart';
import '../../services/service_collector.dart';
import '../../utils/constants.dart';
import '../../utils/screen_config.dart';

class TakeRoleScreen extends StatelessWidget {
  const TakeRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    String userId = Provider.of<AuthProvider>(context, listen: false).user.id;
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        Provider.of<TakeRoleViewModel>(context, listen: false)
            .checkRoleStatus(userId);
      },
    );
    return PopScope(
      onPopInvoked: (canPop) async {
        String id = Provider.of<AuthProvider>(context, listen: false).user.id;
        Provider.of<TripsProvider>(context, listen: false)
            .syncAndFetchTrips(id);

        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            Provider.of<TakeRoleViewModel>(context, listen: false)
                .checkRoleStatus(id);
          },
        );
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(lang!.takeARole),
          leading: IconButton(
            onPressed: () {
              String id =
                  Provider.of<AuthProvider>(context, listen: false).user.id;
              Provider.of<TripsProvider>(context, listen: false)
                  .syncAndFetchTrips(id);

              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .checkRoleStatus(id);
                },
              );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            String id =
                Provider.of<AuthProvider>(context, listen: false).user.id;

            Provider.of<TakeRoleViewModel>(context, listen: false)
                .checkRoleStatus(id);
          },
          child: ScrollConfiguration(
            behavior: AppBehavior(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                  padding: EdgeInsets.only(
                    top: ScreenConfig.getRuntimeHeightByRatio(180),
                    left: ScreenConfig.getXByPerecentScreen(0.02),
                    right: ScreenConfig.getXByPerecentScreen(0.02),
                  ),
                  child: Consumer<TakeRoleViewModel>(
                    builder: (context, vm, child) {
                      return vm.isLoading
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: ScreenConfig.getRuntimeHeightByRatio(180),
                              ),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lang.saveCC,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                ExpandableItemDefault(
                                  isCurrentExpand: true,
                                  mainTitle: lang!.generalRole,
                                  reverseExpandableList: () {},
                                  expandableWidget: Column(children: [
                                    const SizedBox(height: 20),
                                    vm.hasGeneralRole
                                        ? _buildGeneralRoleExist(
                                            vm, userId, lang)
                                        : _buildRegisterWithNewGeneralRole(
                                            vm, userId, lang),
                                    const SizedBox(height: 20),
                                  ]),
                                ),
                                const SizedBox(height: 20),
                                ExpandableItemDefault(
                                  isCurrentExpand: true,
                                  mainTitle: lang.specificRole,
                                  reverseExpandableList: () {},
                                  expandableWidget: Column(children: [
                                    const SizedBox(height: 20),
                                    vm.hasSpecificRole
                                        ? _buildHasSpecifcRole(vm, userId, lang)
                                        : _buildRegisterWithSpecificRole(
                                            vm, context, userId, lang),
                                    const SizedBox(height: 20),
                                  ]),
                                )
                              ],
                            );
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildGeneralRoleExist(
      TakeRoleViewModel vm, String userId, AppLocalizations? lang) {
    return Column(
      children: [
        Text(
          lang!.currentRole,
          style: textTitle(kPrimaryColor),
        ),
        const SizedBox(height: 10),
        Text(
          vm.currentGeneralRole,
          style: textTitle(kNormalTextColor)
              .copyWith(fontSize: ScreenConfig.getFontDynamic(30)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: DefaultButton(
            buttonWidth: double.infinity,
            buttonText: lang.removeGeneralRole,
            onpressed: () {
              vm.removeGeneralRole(userId);
            },
            backgroundColor: Colors.red,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }

  Column _buildRegisterWithNewGeneralRole(
      TakeRoleViewModel vm, String userId, AppLocalizations? lang) {
    return Column(
      children: [
        Text(
          lang!.hintGeneralTakeRole,
          style: textTitle(kPrimaryColor),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: DefaultButton(
            buttonWidth: double.infinity,
            buttonText: lang.takeGeneralRole,
            onpressed: () {
              vm.takeGeneralRole(userId);
            },
            textColor: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          lang.saveCCB,
          style: textTitle(Colors.black),
        ),
      ],
    );
  }

  Column _buildHasSpecifcRole(
      TakeRoleViewModel vm, String userId, AppLocalizations? lang) {
    return Column(
      children: [
        Text(
          lang!.hasSpecificRoleHint,
          style: textTitle(kPrimaryColor),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: DefaultButton(
            buttonWidth: double.infinity,
            buttonText: lang.removeSpecificRole,
            onpressed: () {
              vm.removeSpecificRole(userId);
            },
            backgroundColor: Colors.red,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }

  Column _buildRegisterWithSpecificRole(TakeRoleViewModel vm,
      BuildContext context, String userId, AppLocalizations? lang) {
    return Column(
      children: [
        Text(
          lang!.selectCityAndDistrict,
          style: textTitle(kPrimaryColor),
        ),
        const SizedBox(height: 10),

//City
        _buildDropListCities(vm, lang),

        if (vm.districts.isNotEmpty) _buildDropListDistrict(vm, lang),

        if (vm.districts.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: DefaultButton(
              buttonWidth: double.infinity,
              buttonText: lang.takeSpecificRole,
              onpressed: () {
                vm.takeSpecificRole(userId);
              },
              textColor: Colors.white,
            ),
          )
      ],
    );
  }

  Padding _buildDropListDistrict(TakeRoleViewModel vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.selectDistrict,
            style: textTitle(kPrimaryColor),
          ),
          Expanded(
            child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                hint: Text(
                    ServiceCollector.getInstance().currentLanguage == 'en'
                        ? 'Select District'
                        : 'اختر المنطقة'),
                value: vm.selectedDistrictId,
                items: vm.districts
                    .map((e) => DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.districtName),
                        ))
                    .toList(),
                onChanged: (value) {
                  vm.selectedDistrictId = value;
                }),
          )
        ],
      ),
    );
  }

  Padding _buildDropListCities(TakeRoleViewModel vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.selectCity,
            style: textTitle(kPrimaryColor),
          ),
          Expanded(
            child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                value: vm.selectedCity,
                hint: Text(
                    ServiceCollector.getInstance().currentLanguage == 'en'
                        ? 'Select City'
                        : 'اختر المدينة'),
                items: vm.cities
                    .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                              value: e.id,
                              child: Text(e.cityName),
                            ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  vm.selectedCity = value;
                  vm.syncDistricts(value as String);
                }),
          )
        ],
      ),
    );
  }
}

class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
