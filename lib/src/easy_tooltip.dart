import 'package:easy_tooltip/src/tooltip_overlay.dart';
import 'package:flutter/material.dart';

class EasyTooltip extends StatefulWidget {
  final String content;
  final Widget child;

  const EasyTooltip({super.key, required this.content, required this.child});

  @override
  State<StatefulWidget> createState() => EasyTooltipState();
}

class EasyTooltipState extends State<EasyTooltip> {
  bool clicked = false;
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: () {
        setState(() {
          clicked = true;
        });
        showMoreText(widget.content, key);
      },
      child: widget.child,
    );
  }

  void showMoreText(String text, key) {
    TooltipOverlay popup = TooltipOverlay(context,
        text: 'hello world',
        textStyle: const TextStyle(color: Colors.white),
        height: 35,
        width: 180,
        backgroundColor: const Color(0xFF385E9D),
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 10),
        borderRadius: BorderRadius.circular(8.0), onDismiss: () {
      setState(() {
        clicked = false;
      });
    });

    popup.show(
      widgetKey: key,
    );
  }
}
