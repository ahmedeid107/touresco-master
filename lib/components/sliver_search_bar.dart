import 'package:flutter/material.dart';
import 'package:touresco/utils/screen_config.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({Key? key, required this.onSearchingStart})
      : super(key: key);
  final Function(String value) onSearchingStart;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      pinned: true,
      expandedHeight: 0,
      titleSpacing: 20,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: EdgeInsets.only(
                left: 20, right: 20, top: ScreenConfig.topSafeArea + 5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(46, 70, 135, 225),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: TextFormField(
              onFieldSubmitted: (value) => onSearchingStart(value),
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.only(left: 20, top: 12.5),
              ),
            ),
          );
        },
      ),
    );
  }
}
