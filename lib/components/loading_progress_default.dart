import 'package:flutter/material.dart';

class LoadingProgressDefault extends StatelessWidget {
  const LoadingProgressDefault(
      {Key? key, required this.processText, required this.action})
      : super(key: key);

  final String processText;
  final Future action;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: action,
      builder: (context, value) {
        if (value.connectionState == ConnectionState.waiting) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 20),
                    Text(processText),
                    const SizedBox(height: 20),
                  ]),
            ),
          );
        } else {
          Navigator.of(context).pop();
          return Container();
        }
      },
    );
  }
}
