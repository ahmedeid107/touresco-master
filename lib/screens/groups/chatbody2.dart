import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/chat_view_model.dart';
import 'package:touresco/screens/chat/components/chat_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/constants.dart';

class ChatBody2 extends StatefulWidget {
  ChatBody2({Key? key, required this.type, this.groupId}) : super(key: key);
  final String type;
  final String? groupId;

  @override
  State<ChatBody2> createState() => _ChatBody2State();
}

class _ChatBody2State extends State<ChatBody2> {
  TextEditingController text = TextEditingController();
  late ChatViewModel chatViewModel;
  int selectedPlayerIdx = 0;

  var boolean = true;

  @override
  void initState() {
    super.initState();
    chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
    chatViewModel.init();
  }

  @override
  void didChangeDependencies() {
    chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    chatViewModel.disp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: boolean ? chatViewModel.syncGroupData() : null,
      builder: (context, snapshot) {
        if ((snapshot.connectionState != ConnectionState.done) && boolean) {
          boolean = false;
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              ChatList(
                  vm: Provider.of<ChatViewModel>(context, listen: true),
                  groupID: widget.groupId),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(start: 8),
                      child: Stack(children: [
                        chatViewModel.audioRecord == null
                            ? Container(
                                width: double.infinity,
                                height: 49,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300]!,
                                          blurRadius: 5,
                                          offset: Offset(0, 0))
                                    ]),
                              )
                            : Container(),
                        chatViewModel.audioRecord == null
                            ? TextFormField(
                                controller: text,
                                onFieldSubmitted: (value) {
                                  // onSubmit(value);
                                  text.clear();
                                },
                                style: TextStyle(color: Colors.black),
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  labelText: lang.typeMessageHere,
                                  labelStyle:
                                      const TextStyle(color: kPrimaryColor),
                                  fillColor: Colors.white,
                                  isDense: true,
                                  filled: true,
                                  suffixIcon: widget.type == "1"
                                      ? SizedBox.shrink()
                                      : IconButton(
                                          icon: const Icon(
                                            Icons.image,
                                            color: kPrimaryColor,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                isDismissible: true,
                                                context: context,
                                                builder:
                                                    (BuildContext contesxt) {
                                                  return SizedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 20,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            lang.selectPath,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 32,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  // Card(
                                                                  //   shape:
                                                                  //   RoundedRectangleBorder(
                                                                  //     borderRadius:
                                                                  //     BorderRadius
                                                                  //         .circular(8),
                                                                  //   ),
                                                                  //   child: InkWell(
                                                                  //     splashColor:
                                                                  //     Colors.transparent,
                                                                  //     focusColor:
                                                                  //     Colors.transparent,
                                                                  //     highlightColor:
                                                                  //     Colors.transparent,
                                                                  //     child: Container(
                                                                  //       width: 50,
                                                                  //       height: 50,
                                                                  //       decoration:
                                                                  //       BoxDecoration(
                                                                  //         color:
                                                                  //         kPrimaryColor,
                                                                  //         borderRadius:
                                                                  //         BorderRadius
                                                                  //             .circular(
                                                                  //             8),
                                                                  //       ),
                                                                  //       child: const Icon(
                                                                  //         Icons.image,
                                                                  //         color: Colors.white,
                                                                  //         size: 25,
                                                                  //       ),
                                                                  //     ),
                                                                  //     onTap: () {
                                                                  //       Provider.of<ChatViewModel>(
                                                                  //           context,
                                                                  //           listen: false)
                                                                  //           .getImage(false,
                                                                  //           context);
                                                                  //     },
                                                                  //   ),
                                                                  // ),
                                                                  const SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Text(
                                                                    lang.album,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Card(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              kPrimaryColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              25,
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Provider.of<
                                                                            ChatViewModel>(
                                                                          context,
                                                                          listen:
                                                                              false,
                                                                        ).getImage(
                                                                          true,
                                                                          context,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Text(
                                                                    lang.camera,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 32,
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
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(20)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                ),
                              )
                            : _buildAudioVoice(),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  chatViewModel.audioRecord == null
                      ? Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                              color: kPrimaryColor, shape: BoxShape.circle),
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              chatViewModel.record(context);
                              // AlertDialog alert = AlertDialog(
                              //   title: Text(
                              //     lang.deleteMessage,
                              //     style: textTitle(kPrimaryColor),
                              //   ),
                              //   content: Text(
                              //     lang.doYouWantDeleteMessage,
                              //     style: textTitle(kTitleBlackTextColor),
                              //   ),
                              //
                              // );
                              //
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return alert;
                              //     ّ
                            },
                            child: Icon(
                              Provider.of<ChatViewModel>(context, listen: true)
                                  .icon,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(),
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
                        if (text.text.isNotEmpty ||
                            chatViewModel.audioRecord != null ||
                            chatViewModel.image != null) {
                          chatViewModel.sendMessage(text.text);
                        }
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
      },
    );
  }

  // Widget _buildMessageField(Function onSubmit, AppLocalizations lang) {
  //   return Stack(children: [
  //     chatViewModel.audioRecord == null
  //         ? Container(
  //             width: double.infinity,
  //             height: 49,
  //             decoration: BoxDecoration(
  //                 color: Colors.transparent,
  //                 borderRadius: BorderRadius.circular(20),
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Colors.grey[300]!,
  //                       blurRadius: 5,
  //                       offset: Offset(0, 0))
  //                 ]),
  //           )
  //         : Container(),
  //     chatViewModel.audioRecord == null
  //         ? TextFormField(
  //             controller: text,
  //             onFieldSubmitted: (value) {
  //               onSubmit(value);
  //               text.clear();
  //             },
  //             style: const TextStyle(
  //               color: Colors.black,
  //             ),
  //             cursorColor: kPrimaryColor,
  //             decoration: InputDecoration(
  //               labelText: lang.typeMessageHere,
  //               labelStyle: const TextStyle(color: kPrimaryColor),
  //               fillColor: Colors.white,
  //               isDense: true,
  //               filled: true,
  //               suffixIcon: widget.type == "1"
  //                   ? Container()
  //                   : IconButton(
  //                       icon: const Icon(
  //                         Icons.image,
  //                         color: kPrimaryColor,
  //                         size: 24,
  //                       ),
  //                       onPressed: () {
  //                         showModalBottomSheet<void>(
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(8)),
  //                             isDismissible: true,
  //                             context: context,
  //                             builder: (BuildContext contesxt) {
  //                               return SizedBox(
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                     horizontal: 16,
  //                                     vertical: 20,
  //                                   ),
  //                                   child: Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     mainAxisSize: MainAxisSize.min,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: <Widget>[
  //                                       Text(
  //                                         lang.selectPath,
  //                                         style: const TextStyle(
  //                                           fontSize: 16,
  //                                         ),
  //                                       ),
  //                                       const SizedBox(
  //                                         height: 32,
  //                                       ),
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           Column(
  //                                             children: [
  //                                               // Card(
  //                                               //   shape:
  //                                               //   RoundedRectangleBorder(
  //                                               //     borderRadius:
  //                                               //     BorderRadius
  //                                               //         .circular(8),
  //                                               //   ),
  //                                               //   child: InkWell(
  //                                               //     splashColor:
  //                                               //     Colors.transparent,
  //                                               //     focusColor:
  //                                               //     Colors.transparent,
  //                                               //     highlightColor:
  //                                               //     Colors.transparent,
  //                                               //     child: Container(
  //                                               //       width: 50,
  //                                               //       height: 50,
  //                                               //       decoration:
  //                                               //       BoxDecoration(
  //                                               //         color:
  //                                               //         kPrimaryColor,
  //                                               //         borderRadius:
  //                                               //         BorderRadius
  //                                               //             .circular(
  //                                               //             8),
  //                                               //       ),
  //                                               //       child: const Icon(
  //                                               //         Icons.image,
  //                                               //         color: Colors.white,
  //                                               //         size: 25,
  //                                               //       ),
  //                                               //     ),
  //                                               //     onTap: () {
  //                                               //       Provider.of<ChatViewModel>(
  //                                               //           context,
  //                                               //           listen: false)
  //                                               //           .getImage(false,
  //                                               //           context);
  //                                               //     },
  //                                               //   ),
  //                                               // ),
  //                                               const SizedBox(
  //                                                 height: 4,
  //                                               ),
  //                                               Text(
  //                                                 lang.album,
  //                                                 style: const TextStyle(
  //                                                   fontSize: 15,
  //                                                 ),
  //                                               )
  //                                             ],
  //                                           ),
  //                                           Column(
  //                                             children: [
  //                                               Card(
  //                                                 shape: RoundedRectangleBorder(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           8),
  //                                                 ),
  //                                                 child: InkWell(
  //                                                   splashColor:
  //                                                       Colors.transparent,
  //                                                   focusColor:
  //                                                       Colors.transparent,
  //                                                   highlightColor:
  //                                                       Colors.transparent,
  //                                                   child: Container(
  //                                                     width: 50,
  //                                                     height: 50,
  //                                                     decoration: BoxDecoration(
  //                                                       color: kPrimaryColor,
  //                                                       borderRadius:
  //                                                           BorderRadius
  //                                                               .circular(8),
  //                                                     ),
  //                                                     child: const Icon(
  //                                                       Icons.camera_alt,
  //                                                       color: Colors.white,
  //                                                       size: 25,
  //                                                     ),
  //                                                   ),
  //                                                   onTap: () {
  //                                                     Provider.of<
  //                                                         ChatViewModel>(
  //                                                       context,
  //                                                       listen: false,
  //                                                     ).getImage(
  //                                                       true,
  //                                                       context,
  //                                                     );
  //                                                   },
  //                                                 ),
  //                                               ),
  //                                               const SizedBox(
  //                                                 height: 4,
  //                                               ),
  //                                               Text(
  //                                                 lang.camera,
  //                                                 style: TextStyle(
  //                                                   fontSize: 15,
  //                                                 ),
  //                                               )
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       const SizedBox(
  //                                         height: 32,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               );
  //                             });
  //                       },
  //                       splashColor: Colors.transparent,
  //                       focusColor: Colors.transparent,
  //                       highlightColor: Colors.transparent,
  //                     ),
  //               border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                   borderSide: const BorderSide(color: Colors.transparent)),
  //               focusedBorder: OutlineInputBorder(
  //                   borderSide: const BorderSide(color: Colors.transparent),
  //                   borderRadius: BorderRadius.circular(20)),
  //               enabledBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                   borderSide: const BorderSide(color: Colors.transparent)),
  //               focusedErrorBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                   borderSide: const BorderSide(color: Colors.transparent)),
  //               errorBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                   borderSide: const BorderSide(color: Colors.transparent)),
  //             ),
  //           )
  //         : _buildAudioVoice(),
  //   ]);
  // }

  Widget _buildAudioVoice() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Container(
        child: Row(children: [
          Expanded(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Slider(
                min: 0,
                max: Provider.of<ChatViewModel>(context, listen: true)
                    .duration
                    .inSeconds
                    .toDouble(),
                value: Provider.of<ChatViewModel>(context, listen: true)
                    .position
                    .inSeconds
                    .toDouble(),
                onChanged: (double value) {
                  chatViewModel.seekToSecond(
                    value,
                  );
                },
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    formatTime(Provider.of<ChatViewModel>(context, listen: true)
                        .position
                        .inSeconds),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    formatTime(Provider.of<ChatViewModel>(context, listen: true)
                        .duration
                        .inSeconds),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55555),
                ),
                child: InkWell(
                  onTap: () {
                    chatViewModel.deletePath(chatViewModel.audioRecord!.path);
                    chatViewModel.removeFile();
                  },
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Icon(Icons.cancel),
                ),
              )
            ],
          )),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(55555),
            ),
            child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  chatViewModel.playOrStopToggle();
                },
                child: Icon(
                  Provider.of<ChatViewModel>(context, listen: true).playIcon,
                  size: 18,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            width: 16,
          )
        ]),
      ),
    );
  }

  String formatTime(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(4, "0");
  }
}
