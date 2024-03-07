import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/select_office_sheet_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectOfficeSheet extends StatelessWidget {
  SelectOfficeSheet({Key? key, required this.onCallBack   ,required this.search}) : super(key: key);
  TextEditingController search  ;

  final Function onCallBack;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(10),

      height: ScreenConfig.getYByPercentScreen(0.8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(21.0),
          topRight: Radius.circular(21.0),
        ),
      ),
      child: Consumer<SelectOfficeSheetViewModel>(
        builder: (context, vm, child) {
          return Column(children: [
            Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      lang!.searchInOffices,
                      style: textTitle(kPrimaryColor).copyWith(
                        fontSize: ScreenConfig.getFontDynamic(20),
                      ),
                    ),
                    Row(children: [
                      Expanded(child:Stack(children: [
                        Container(
                          width: double.infinity,
                          height: 49,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300]!, blurRadius: 6, offset: Offset(0, 2))
                              ]),
                        ),
                        TextFormField(
                          controller: search,
                          cursorColor: kPrimaryColor,
                          onFieldSubmitted: (value) {},
                          onChanged: (value) {
                            if (value.length % 2 != 0) {
                              vm.syncAndFecthOffices(value);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: lang.search,
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            fillColor: Colors.white,
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
                      ])),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                            onPressed: () {
                              // vm.syncAndFecthOffices(search.text);
                            },
                            icon:
                                const Icon(Icons.search, color: kPrimaryColor)),
                      )
                    ]),
                  ],
                )),
            vm.offices.isEmpty
                ? Flexible(
                    flex: 4,
                    child: Lottie.asset('assets/animations/lottie_empty.json'),
                  )
                : Flexible(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        itemCount: vm.offices.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              onCallBack(vm.offices[index]);
                              Navigator.of(context).pop();
                            },
                            child: ListTile(
                              leading: const Icon(
                                Icons.account_box,
                                color: kPrimaryColor,
                                size: 30,
                              ),
                              title: Text(
                                ServiceCollector.getInstance()
                                            .currentLanguage ==
                                        'en'
                                    ? vm.offices[index].officeNameEn
                                    : vm.offices[index].officeNameAr,
                                style: textTitle(kNormalTextColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ))
          ]);
        },
      ),
    );
  }


}
