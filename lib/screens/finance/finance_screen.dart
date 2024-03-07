import 'package:flutter/material.dart';
import 'package:touresco/screens/finance/components/finanace_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang!.payments),
        actions:   const [

          /*
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.filter_alt,
            color: kTitleBlackTextColor,
          ),
        )*/

/*
          PopupMenuButton<MenuItem>(
            icon: const Icon(Icons.filter_alt),
            onSelected: (value) {
              if (value.id == 'low') {
                Provider.of<FinacneViewModel>(context, listen: false)
                    .sortingFinances(false);
              }
              if (value.id == 'high') {
                Provider.of<FinacneViewModel>(context, listen: false)
                    .sortingFinances(true);
              }
            },
            itemBuilder: (context) => [
              ...Provider.of<FinacneViewModel>(context, listen: false)
                  .menuItems
                  .map(buildItem)
                  .toList()
            ],
          ),*/
        ],
      ),
      body: const SafeArea(child: FinanceBody()),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
        value: item,
        child: Text(item.text),
        enabled: item.isEnabled,
      );
}

class MenuItem {
  String id;
  String text;
  bool isEnabled;

  MenuItem({
    required this.id,
    required this.text,
    required this.isEnabled,
  });
}
