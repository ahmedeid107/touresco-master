import 'package:flutter/material.dart';
import 'package:touresco/utils/constants.dart';

class SearchBars extends StatelessWidget {
  const SearchBars({Key? key, required this.onSubmit, required this.hintText,required this.onChange})
      : super(key: key);

  final String hintText;
  final Function(String) onSubmit;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(46, 70, 135, 225),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      child: TextFormField(
        onFieldSubmitted: (value) => onSubmit(value),
        onChanged: (value)=>onChange(value),
        style: const TextStyle(
            letterSpacing: 0.1,
            fontWeight: FontWeight.w600,
            color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              const TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w600),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
