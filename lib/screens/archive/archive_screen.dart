import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/archive_view_model.dart';
import 'package:touresco/screens/archive/components/archive_body.dart';

class ArchiveScreen extends StatelessWidget {
    ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(lang!.archive)),
      body: ChangeNotifierProvider.value(
        value: ArchiveViewModel(),
        child: const ArchiveBody(),
      ),
    );
  }
}
