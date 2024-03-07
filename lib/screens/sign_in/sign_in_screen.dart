import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/sign_in_view_model.dart';
import 'package:touresco/screens/sign_in/components/sign_in_body.dart';
import 'package:touresco/services/service_collector.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: SignInViewModel(
            authService: ServiceCollector
                .getInstance()
                .authService,),
          child: const SignInBody(),),),
    );
  }
}
