// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:touresco/screens/sign_in/sign_in_screen.dart';
import 'package:touresco/utils/screen_config.dart';

import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/view_models/update_profile_view_model.dart';
import '../../services/service_collector.dart';
import '../../utils/constants.dart';

class DeleteAccountScreen extends StatelessWidget {
  var alertShwon = false ;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(

          title: Text(lang.deleteTheAccount),
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
        value: UpdateProfileViewModel(),
        child: _buildBody(
          lang,
        ),
      ),
    );
  }

  Widget _buildBody(lang) {

    return Consumer<UpdateProfileViewModel>(builder: (context, vm, child) {

      return LayoutBuilder(
          builder: (context, constraints) { return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConfig.getRuntimeWidthByRatio(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(23),
              ),
              Text(
                lang.deletionTerms,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black.withOpacity(.8),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(16),
              ),
              // trims
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(14),
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(8),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: ScreenConfig.getRuntimeHeightByRatio(10),
                    width: ScreenConfig.getRuntimeHeightByRatio(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5555),
                        color: Colors.grey[700],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 0),
                            blurRadius: 55,
                          )
                        ]),
                  ),
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(12),
                  ),
                  Expanded(
                    child: Text(
                      lang.term0,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(14),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(8),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: ScreenConfig.getRuntimeHeightByRatio(10),
                    width: ScreenConfig.getRuntimeHeightByRatio(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5555),
                        color: Colors.grey[700],
                        boxShadow:const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 0),
                            blurRadius: 55,
                          )
                        ]),
                  ),
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(12),
                  ),
                  Expanded(
                    child: Text(
                      lang.term1,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800]),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(32),
              ),
              Text(
                lang.learnAbout,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black.withOpacity(.8),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(12),
              ),

              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(14),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(8),
                  ),
                  Container(
                    margin:const EdgeInsets.symmetric(vertical: 5),
                    height: ScreenConfig.getRuntimeHeightByRatio(10),
                    width: ScreenConfig.getRuntimeHeightByRatio(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5555),
                        color: Colors.grey[700],
                        boxShadow:const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 0),
                            blurRadius: 55,
                          )
                        ]),
                  ),
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(12),
                  ),
                  Expanded(
                    child: Text(
                      lang.learn0,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(14),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(8),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: ScreenConfig.getRuntimeHeightByRatio(10),
                    width: ScreenConfig.getRuntimeHeightByRatio(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5555),
                        color: Colors.grey[700],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 0),
                            blurRadius: 55,
                          )
                        ]),
                  ),
                  SizedBox(
                    width: ScreenConfig.getRuntimeWidthByRatio(12),
                  ),
                  Expanded(
                    child: Text(
                      lang.learn1,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800]),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 64,
              ),
              Container(
                height: 48,
                width: double.infinity,
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: lang.password,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: .8,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: .8,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: .8,
                          )),
                      hintStyle: const TextStyle(
                        fontSize: 14,
                      )),
                ),
              ),
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(16),
              ),
              Container(
                width: double.infinity,
                height: ScreenConfig.getRuntimeHeightByRatio(52),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.red,
                ),
                child: InkWell(
                  onTap: () async {

                  if(passwordController.text.length >= 6)  {
                    var statusCode = await Provider.of<AuthProvider>(context,
                        listen: false)
                        .deleteAccount(context: context, password: passwordController.text);

                      if (statusCode == "600") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          ServiceCollector.getInstance().currentLanguage == 'en'
                              ? "You have financial liabilities, please pay them"
                              : "يوجد لديك ذمم مالية يرجى تسديدها",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[100],
                          ),
                        )));
                      } else if (statusCode == "601") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          ServiceCollector.getInstance().currentLanguage == 'en'
                              ? "Have efficient flights"
                              : "لديك رحلات فعالة",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[100],
                          ),
                        )));
                      } else if (statusCode == "602") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          ServiceCollector.getInstance().currentLanguage == 'en'
                              ? "You have diversified flights"
                              : "لديك رحلات محولة",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[100],
                          ),
                        )));
                      }
                      else if (statusCode == "603") {
                        // delete account
                        alertShwon = true;
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 19,
                                  ),
                                  Text(
                                    ServiceCollector.getInstance()
                                                .currentLanguage ==
                                            'en'
                                        ? "Your account has been successfully deleted"
                                        : "لقد تم حذف حسابك بنجاح",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            ScreenConfig.getRuntimeWidthByRatio(
                                                8),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 9),
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5555),
                                            color: Colors.grey[700],
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(2, 0),
                                                blurRadius: 55,
                                              )
                                            ]),
                                      ),
                                      SizedBox(
                                        width:
                                            ScreenConfig.getRuntimeWidthByRatio(
                                                12),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ServiceCollector.getInstance()
                                                      .currentLanguage ==
                                                  'en'
                                              ? "Your account will be permanently deleted after 14 days"
                                              : "سيتم حذف حسابك بشكل نهائي بعد ١٤ يوم",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            ScreenConfig.getRuntimeWidthByRatio(
                                                8),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 9),
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5555),
                                            color: Colors.grey[700],
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(2, 0),
                                                blurRadius: 55,
                                              )
                                            ]),
                                      ),
                                      SizedBox(
                                        width:
                                            ScreenConfig.getRuntimeWidthByRatio(
                                                12),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ServiceCollector.getInstance()
                                                      .currentLanguage ==
                                                  'en'
                                              ? "Your account will be activated again if you log in during the deletion period."
                                              : "سيتم تفعيل حسابك مره اخرى اذا تم تسجيل الدخول خلال فترةالحذف.",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: InkWell(
                                      highlightColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {

                                        Navigator.pop(context);
                                        logout(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 9),
                                        child: Text(
                                          ServiceCollector.getInstance()
                                                      .currentLanguage ==
                                                  'en'
                                              ? "okay"
                                              : "حسنا",
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text((Provider.of<LanguageProvider>(context, listen: false)
                          .currentLanguage ==
                          "en"
                          ? "Please enter a password"
                          : "يرجى ادخال كلمة مرور صحيحة")),
                      backgroundColor: Colors.red.shade300,
                    ));
                  }
                  },
                  child: Center(
                    child: Text(
                      lang.delete,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenConfig.getRuntimeHeightByRatio(16),
              ),

            ],
          ),
        ),
      ); });
    });
  }

  // Functions
  static void logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>SignInScreen() ));

    });
     }
}