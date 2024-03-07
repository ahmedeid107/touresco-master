import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/chat_group_model.dart';

import 'package:touresco/providers/view_models/chat_view_model.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer(
      {Key? key, required this.isSentByCurrentUser, required this.message})
      : super(key: key);

  final bool isSentByCurrentUser;

  final SingleMessageData message;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return isSentByCurrentUser
        ? _buildCurrentUserMessage(context, lang!, message)
        : _buildOtherUserMessage();
  }

  Align _buildCurrentUserMessage(
      BuildContext context, AppLocalizations lang, SingleMessageData message) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onLongPress: () => showDeleteDialogBox(context, lang, message),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),

              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(46, 70, 135, 225),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3))
              ],
              color: kPrimaryColor),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.only(top: 2, left: 5, right: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.message,
                        style: textTitle(Colors.white).copyWith(fontSize: 13),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat.Hm().format(DateTime.parse(message.sendDate)),
                        style: textSubtitle(Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (message.status == MessageStatus.pending)
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      if (message.status == MessageStatus.hasBeenSent)
                        const Icon(
                          Icons.done,
                          size: 14,
                          color: Colors.white,
                        ),
                      if (message.status == MessageStatus.deleted)
                        Row(
                          children: [
                            Text(
                              lang.deleted,
                              style: textTitle(Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.delete_rounded,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Align _buildOtherUserMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(46, 70, 135, 225),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              message.senderName,
              style: textTitle(kPrimaryColor),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 2, left: 5, right: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.message,
                      style: textTitle(kNormalTextColor).copyWith(fontSize: 13),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat.Hm().format(DateTime.parse(message.sendDate)),
                      style: textSubtitle(kLightGreyColor),
                    )
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  void showDeleteDialogBox(
      BuildContext context, AppLocalizations lang, SingleMessageData message) {
    Widget delete = TextButton(
        onPressed: () {
          Provider.of<ChatViewModel>(context, listen: false)
              .deleteMessage(context, message);
        },
        child: Text(
          lang.delete,
          style: textTitle(Colors.red),
        ));
    Widget cancel = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "asdasdsad",
          style: textTitle(Colors.grey),
        ));

    AlertDialog alert = AlertDialog(
      title: Text(
        lang.deleteMessage,
        style: textTitle(kPrimaryColor),
      ),
      content: Text(
        lang.doYouWantDeleteMessage,
        style: textTitle(kTitleBlackTextColor),
      ),
      actions: [cancel, delete],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
