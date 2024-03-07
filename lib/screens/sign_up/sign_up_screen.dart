import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/sign_up_view_model.dart';
import 'package:touresco/screens/sign_up/components/sign_up_body.dart';
import 'package:touresco/services/service_collector.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ChangeNotifierProvider.value(
            value: SignUpViewModel(
                authService: ServiceCollector.getInstance().authService,
                metaDataService:
                    ServiceCollector.getInstance().metaDataService),
            child: const SignUpBody()),
      ),
    );
  }
}
