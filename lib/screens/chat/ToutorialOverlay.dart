import 'dart:io';

import 'package:flutter/material.dart';
import '../../utils/db_helper.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';

class TutorialOverlay extends ModalRoute<void> {
  String image;
  String id;
  String local;
  BuildContext context2;

  TutorialOverlay(this.id, this.image, this.local , this.context2);

  @override
  Duration get transitionDuration => Duration(milliseconds: 250);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.cancel, color: Colors.white, size: 24),
                ),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await  ChatsHelper().upadteImage(id, local, image);

                    Navigator.pop(context);
                    AlertDialog alert = AlertDialog(
                      title: Text(
                        "Image Saved",
                        style: textTitle(kPrimaryColor),
                      ),
                      content: Text(
                        "Image Save Successfully",
                        style: textTitle(kTitleBlackTextColor),
                      ),
                    );

                    showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        });

                  },
                  child:
                      const Icon(Icons.download, color: Colors.white, size: 24),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            constraints:   BoxConstraints(
              minHeight: 35.0,
              maxHeight: 600.0,
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Hero(
                tag: "hero1",
                child: Image(
                  image: (local.isNotEmpty
                      ? FileImage(File(local))
                      : NetworkImage(image)) as ImageProvider,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
