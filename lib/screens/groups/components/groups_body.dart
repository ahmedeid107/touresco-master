import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/view_models/groups_view_model.dart';

import 'package:touresco/screens/groups/components/groups_list.dart';

class GroupsBody extends StatelessWidget {
  const GroupsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<GroupsViewModel>(context, listen: false).syncGroups(
          Provider.of<AuthProvider>(context, listen: false).user.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<GroupsViewModel>(
            builder: (context, vm, child) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),

                child: Column(
                  children: [
                    // GroupsFilter(vm: vm),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    SizedBox(height: 16,),
                    GroupsList(groups: vm.groupsDependOnFilter()),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
