import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/finance_details_view_model.dart';
import 'package:touresco/screens/finance_details/components/finance_details_body.dart';

import '../../providers/view_models/finance_view_model.dart';

class FinanceDetailsScreen extends StatelessWidget {
  const FinanceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['title'];

    String tripSourceAsString = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['tripSource'];

    String officeId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['id'];
    String ownerType = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['ownerType'];
    String filter = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['filter'];


    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            Provider.of<FinacneViewModel>(context, listen: false)
                .syncFinances(
              Provider.of<AuthProvider>(context, listen: false).user.id,
            );
      },
    );

    return ChangeNotifierProvider.value(
      value: FinanceDetailsViewModel(
          tripSourceAsString: tripSourceAsString,
          officeId: officeId,
          userId: Provider.of<AuthProvider>(context, listen: false).user.id),
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body:   SafeArea(child: FinanceDetailsBody(ownerType: ownerType, filter: filter, )),
      ),
    );
  }
}




///            'id': finances[index].id,
//                       'title': finances[index].name,
//                       'tripSource': finances[index].tripSource.index.toString(),