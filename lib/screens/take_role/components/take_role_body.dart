import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/take_role_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TakeRoleBody extends StatelessWidget {
  const TakeRoleBody({Key? key}) : super(key: key);

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
    return Container(
        padding: EdgeInsets.only(
          left: ScreenConfig.getXByPerecentScreen(0.02),
          right: ScreenConfig.getXByPerecentScreen(0.02),
        ),
        child: Consumer<TakeRoleViewModel>(
          builder: (context, vm, child) {
            return vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ExpandableItemDefault(
                        isCurrentExpand: true,
                        mainTitle: lang!.generalRole,
                        reverseExpandableList: () {},
                        expandableWidget: Column(children: [
                          const SizedBox(height: 20),
                          vm.hasGeneralRole
                              ? _buildGeneralRoleExist(vm, userId, lang)
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
        ));
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
        )
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
