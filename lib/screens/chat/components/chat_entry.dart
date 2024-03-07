import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/view_models/chat_view_model.dart';

class ChatEntry extends StatefulWidget {
  const ChatEntry({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatEntry> createState() => _ChatEntryState();
}

class _ChatEntryState extends State<ChatEntry> {
  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMessageField(
                  Provider.of<ChatViewModel>(context, listen: false)
                      .sendMessage,
                  lang!),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: InkWell(
                onTap:
                (){
                  //Provider.of<ChatViewModel>(context, listen: false).record
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(
                      child: Text("data"),
                     color: Colors.black,
                    ),
                  ));
                },
                child: Icon(
                  Provider.of<ChatViewModel>(context, listen: true).icon,
                  size: 23,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: GestureDetector(
                onTap: () {
                  Provider.of<ChatViewModel>(context, listen: false)
                      .sendMessage(text.text);
                  FocusScope.of(context).unfocus();
                  text.clear();
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 6,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }

  Card _buildMessageField(Function onSubmit, AppLocalizations lang) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: TextFormField(
            controller: text,
            onFieldSubmitted: (value) {
              onSubmit(value);
              text.clear();
            },
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              suffix: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet'),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              labelText: lang.typeMessageHere,
              labelStyle: const TextStyle(color: kPrimaryColor),
            )),
      ),
    );
  }
}
