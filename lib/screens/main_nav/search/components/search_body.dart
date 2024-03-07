import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/list_item_default.dart';
 import 'package:touresco/providers/view_models/search_view_model.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../components/search_bar.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return SingleChildScrollView(child: Consumer<SearchViewModel>(
      builder: (context, vm, child) {
        return Column(
          children: [
            SearchBars(
                onSubmit: (value) {
                  vm.searchByName(value);
                },
                onChange: (value) {
                  vm.searchByName(value);
                },
                hintText: lang!.searchForDriver),
            vm.searchedDrivers.isEmpty
                ? SizedBox(
                    height: ScreenConfig.screenDeviceHeight * 0.7,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Lottie.asset(
                                'assets/animations/lottie_noresult.json'),
                          ),
                          Text(
                            lang.searchNoResult,
                            style: textTitle(kPrimaryColor),
                          )
                        ]),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vm.searchedDrivers.length,
                      itemBuilder: (context, index) {
                        return ListItemDefault(
                          leadingImg: 'assets/images/img_user.png',
                          displayData: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vm.searchedDrivers[index].name,
                                  style: textTitle(kPrimaryColor),
                                ),
                                Text(
                                  '${lang.id}${vm.searchedDrivers[index].id}',
                                  style: textSubtitle(kNormalTextColor),
                                ),
                              ]),
                          onPressed: () {
                            vm.copyDriverIdToCilpboard(
                                vm.searchedDrivers[index].id,
                                vm.searchedDrivers[index].name,
                                context);
                          },
                          actionIcon: Icons.copy,
                        );
                      },
                    ),
                  )
          ],
        );
      },
    ));
  }
}
