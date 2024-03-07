import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/search_view_model.dart';
import 'package:touresco/screens/main_nav/search/components/search_body.dart';

class SearchNav extends StatelessWidget {
  const SearchNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ChangeNotifierProvider.value(
            value: SearchViewModel(), child: const SearchBody()));
  }
}
