import 'package:easy_tooltip/src/tooltip_overlay.dart';
import 'package:flutter/material.dart';

class EasyTooltip extends StatefulWidget {
  const EasyTooltip({
    super.key,
    required this.text,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    this.bubbleHeight = 200,
    this.bubbleWidth = 200,
    this.arrowHeight = 10.0,
    this.backgroundColor = const Color(0xFF385E9D),
    this.textStyle = const TextStyle(color: Colors.white),
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.onDismiss,
    this.onEasyTooltipTap,
  });

  // tooltip tapping object
  final Widget child;

  // display string of the bubble
  final String text;

  // maximum height of the bubble
  final double bubbleHeight;

  // maximum width of the bubble
  final double bubbleWidth;

  // height of the triangle
  final double arrowHeight;

  // padding of the bubble
  final EdgeInsetsGeometry padding;

  // defaul style of the text
  final TextStyle textStyle;

  // bubble border radius
  final BorderRadius borderRadius;

  // background color of the bubble
  final Color backgroundColor;

  // callback action upon events
  final VoidCallback? onDismiss;
  final VoidCallback? onEasyTooltipTap;

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
        showMoreText(widget.text, key);
        widget.onEasyTooltipTap?.call();
      },
      child: widget.child,
    );
  }

  void showMoreText(String text, key) {
    TooltipOverlay popup = TooltipOverlay(
      context,
      text: widget.text,
      textStyle: widget.textStyle,
      backgroundColor: widget.backgroundColor,
      padding: widget.padding,
      borderRadius: widget.borderRadius,
      bubbleHeight: widget.bubbleHeight,
      bubbleWidth: widget.bubbleWidth,
      onDismiss: widget.onDismiss,
    );
    popup.show(
      widgetKey: key,
    );
  }
}
