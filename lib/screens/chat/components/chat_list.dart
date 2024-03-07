import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/chat_group_model.dart';
import 'package:touresco/providers/view_models/chat_view_model.dart';
import 'package:touresco/screens/chat/components/message_container.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:touresco/utils/theme.dart';
import '../../../utils/db_helper.dart';
import '../ToutorialOverlay.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key, required this.vm,required this.groupID}) : super(key: key);
  final ChatViewModel vm;
  final String ? groupID;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SingleMessageData>?>(
      stream: widget.vm.chatStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null) {
            widget.vm.chats = snapshot.data!;
          }
        }
        return Consumer<ChatViewModel>(
          builder: (context, value, child) {
            return Expanded(
              child: GroupedListView<SingleMessageData, DateTime>(
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                padding: const EdgeInsets.all(8),
                elements: widget.vm.chats,
                groupBy: (message) => DateTime(
                  DateTime.parse(message.sendDate).year,
                  DateTime.parse(message.sendDate).month,
                  DateTime.parse(message.sendDate).day,
                ),
                groupHeaderBuilder: (message) => _buildChatGroupHeader(message),
                itemBuilder: (context, message) {
                  ChatsHelper().saveMessage(message, widget.groupID);
                  if (message.type == "3" &&
                      message.localPath == null &&
                      message.imageUrl != null) {
                    ChatsHelper()
                        .upadteImage(
                            message.id, message.localPath, message.imageUrl!)
                        .then((value) {
                      message.localPath = value;
                    });
                  }

                  if (message.type == "2" &&
                      message.localPath != null &&
                      message.audioUrl != null) {
                   }
                   if (message.type == "2" &&
                      message.localPath == null &&
                      message.audioUrl != null) {
                    ChatsHelper()
                        .updateAudio(
                            message.id, message.localPath, message.audioUrl! , message.duration!)
                        .then((value) {
                       message.localPath = value;
                    });
                  }
                  return message.type == '1'
                      ? MessageContainer(
                          isSentByCurrentUser:
                              message.senderId == widget.vm.userId,
                          message: message)
                      : message.type == '2'
                          ? buildVoice(message)
                          : buildImage(message);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildImage(SingleMessageData message) {
    return InkWell(
      onTap: () {
        _showOverlay(context, message.imageUrl!, message.localPath ?? "",
            context, message.id);
      },
      child: Align(
          alignment: message.senderId == widget.vm.userId
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
              margin: EdgeInsets.only(
                  left: message.senderId == widget.vm.userId
                      ? ScreenConfig.getRuntimeWidthByRatio(56)
                      : 8,
                  right: message.senderId != widget.vm.userId
                      ? ScreenConfig.getRuntimeWidthByRatio(56)
                      : 8,
                  bottom: 16),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(46, 70, 135, 225),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3))
                ],
                color: message.senderId == widget.vm.userId
                    ? kPrimaryColor.withOpacity(.2)
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: message.senderId == widget.vm.userId
                      ? const Radius.circular(20)
                      : Radius.zero,
                  topRight: message.senderId != widget.vm.userId
                      ? const Radius.circular(20)
                      : Radius.zero,
                  bottomRight: const Radius.circular(20),
                  bottomLeft: const Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: message.senderId == widget.vm.userId
                  ? message.sented && message.senderId == widget.vm.userId
                      ? Container(
                          constraints: const BoxConstraints(
                              maxHeight: 230, minHeight: 190),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: message.senderId == widget.vm.userId
                                  ? const Radius.circular(20)
                                  : Radius.zero,
                              topRight: message.senderId != widget.vm.userId
                                  ? const Radius.circular(20)
                                  : Radius.zero,
                              bottomRight: const Radius.circular(20),
                              bottomLeft: const Radius.circular(20),
                            ),
                          ),
                          child: message.localPath != null
                              ? Image(
                                  image: FileImage(File(message.localPath!)))
                              : Container(),
                        )
                      : Container(
                          constraints: const BoxConstraints(
                              maxHeight: 200, minHeight: 190),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: message.senderId == widget.vm.userId
                                  ? const Radius.circular(20)
                                  : Radius.zero,
                              topRight: message.senderId != widget.vm.userId
                                  ? const Radius.circular(20)
                                  : Radius.zero,
                              bottomRight: const Radius.circular(20),
                              bottomLeft: const Radius.circular(20),
                            ),
                          ),
                        )
                  : Container(
                      constraints:
                          const BoxConstraints(maxHeight: 230, minHeight: 190),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: message.senderId == widget.vm.userId
                              ? const Radius.circular(20)
                              : Radius.zero,
                          topRight: message.senderId != widget.vm.userId
                              ? const Radius.circular(20)
                              : Radius.zero,
                          bottomRight: const Radius.circular(20),
                          bottomLeft: const Radius.circular(20),
                        ),
                      ),
                      child: message.localPath != null
                          ? Image(image: FileImage(File(message.localPath!)))
                          : Container(),
                    ))),
    );
  }

  Widget buildVoice(SingleMessageData message) {
     return Align(
      alignment: message.senderId == widget.vm.userId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
            left: message.senderId == widget.vm.userId
                ? ScreenConfig.getRuntimeWidthByRatio(56)
                : 8,
            right: message.senderId != widget.vm.userId
                ? ScreenConfig.getRuntimeWidthByRatio(56)
                : 8,
            bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(46, 70, 135, 225),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3))
          ],
          color: message.senderId == widget.vm.userId
              ? kPrimaryColor.withOpacity(.2)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: message.senderId == widget.vm.userId
                ? const Radius.circular(20)
                : Radius.zero,
            topRight: message.senderId != widget.vm.userId
                ? const Radius.circular(20)
                : Radius.zero,
            bottomRight: const Radius.circular(20),
            bottomLeft: const Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            if(message.senderId != widget.vm.userId)
            Container(padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0), alignment: Alignment.topRight, child: Text(message.senderName, style: textTitle(kPrimaryColor)),),

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: message.sented
                          ? Slider(
                              min: 0,
                              max: double.parse(message.duration!),
                              value:
                                  Provider.of<ChatViewModel>(context, listen: false)
                                              .voicesPosition[message.id] ==
                                          null
                                      ? 0
                                      : Provider.of<ChatViewModel>(context,
                                              listen: true)
                                          .voicesPosition[message.id]!
                                          .inSeconds
                                          .toDouble(),
                              onChanged: (double value) {
                                print("asdasdasdasd ${message.id}");
                                print("asdasdasdasdvalue ${value}");
                                Provider.of<ChatViewModel>(context, listen: false)
                                    .seekChatVoiceToSecond(
                                  value,
                                  message.id,
                                );
                              },
                              activeColor: Colors.blue,
                              inactiveColor: Colors.grey,
                            )
                          : Container(
                              margin: const EdgeInsets.only(left: 8, right: 10),
                              child: const LinearProgressIndicator(),
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(55555),
                      ),
                      child: InkWell(
                          onTap: () {
                            if (message.sented) {
                              Provider.of<ChatViewModel>(context, listen: false)
                                  .playChatVoice(
                                      url: message.audioUrl,
                                      id: message.id,
                                      localPath: message.localPath);
                            }
                          },
                          child: Icon(
                            Provider.of<ChatViewModel>(context, listen: false)
                                            .voicesState[message.id] ==
                                        false ||
                                    Provider.of<ChatViewModel>(context,
                                                listen: false)
                                            .voicesState[message.id] ==
                                        null
                                ? Icons.play_arrow_outlined
                                : Icons.stop,
                            size: 18,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                if (message.sented)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        Provider.of<ChatViewModel>(context, listen: true)
                                    .voicesPosition[message.id] ==
                                null
                            ? "00:00"
                            : Provider.of<ChatViewModel>(context, listen: true)
                                        .voicesPosition[message.id]!
                                        .inSeconds <
                                    10
                                ? "00:0${Provider.of<ChatViewModel>(context, listen: true).voicesPosition[message.id]!.inSeconds}"
                                : "00:${Provider.of<ChatViewModel>(context, listen: true).voicesPosition[message.id]!.inSeconds}",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "00:${message.duration}",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(4, "0");
  }

  Widget _buildChatGroupHeader(SingleMessageData message) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kPrimaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(
                DateFormat.yMEd(ServiceCollector.getInstance().currentLanguage)
                    .format(DateTime.parse(message.sendDate)),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]);
  }

  void _showOverlay(BuildContext context, String image, String local,
      BuildContext context2, id) {
    Navigator.of(context).push(TutorialOverlay(id, image, local, context2));
  }
}
