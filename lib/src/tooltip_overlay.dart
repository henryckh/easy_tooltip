import 'dart:core';
import 'dart:ui';

import 'package:easy_tooltip/src/painter/triangle_painter.dart';
import 'package:flutter/material.dart';

class TooltipOverlay {
  final double popupWidth = 200;
  final double popupHeight = 200;
  final double arrowHeight = 10.0;
  bool _isDownArrow = false;
  bool _isVisible = false;

  late String text;
  late OverlayEntry entry;
  late Offset offset;
  late Rect showRect;
  late Size screenSize;
  late EdgeInsetsGeometry padding;

  final BuildContext context;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final Color backgroundColor;

  VoidCallback? dismissCallback;
  VoidCallback? onDismiss;

  TooltipOverlay(
    this.context, {
    double height = 35,
    double width = 180,
    VoidCallback? dismissCallback,
    VoidCallback? onDismiss,
    this.textStyle = const TextStyle(
        fontWeight: FontWeight.normal, color: Color(0xFF000000)),
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    required this.backgroundColor,
    required this.text,
    this.padding = const EdgeInsets.all(4.0),
  });

  void show({Rect? rect, required GlobalKey widgetKey}) {
    showRect = rect ?? _getWidgetGlobalRect(widgetKey);
    screenSize = window.physicalSize / window.devicePixelRatio;

    _calculatePosition(context);

    entry = OverlayEntry(builder: (context) {
      return buildPopupLayout(offset);
    });

    Overlay.of(context)!.insert(entry);
    _isVisible = true;
  }

  void _calculatePosition(BuildContext context) {
    offset = _calculateOffset(context);
  }

  Rect _getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = (key.currentContext?.findRenderObject()) as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  Offset _calculateOffset(BuildContext context) {
    double dx = showRect.left + showRect.width / 2.0 - popupWidth / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + popupWidth > screenSize.width && dx > 10.0) {
      double tempDx = screenSize.width - popupWidth - 10;
      if (tempDx > 10) dx = tempDx;
    }

    double dy = showRect.top - popupHeight;
    dy = arrowHeight + showRect.height + showRect.top + 4;
    _isDownArrow = false;

    return Offset(dx, dy);
  }

  /// Builds Layout of popup for specific [offset]
  LayoutBuilder buildPopupLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (detail) {
          dismiss();
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              // triangle arrow
              Positioned(
                left: showRect.left + showRect.width / 2.0 - 7.5,
                top: _isDownArrow
                    ? offset.dy + popupHeight
                    : offset.dy - arrowHeight,
                child: CustomPaint(
                  size: Size(15.0, arrowHeight),
                  painter: TrianglePainter(
                      isDownArrow: _isDownArrow, color: backgroundColor),
                ),
              ),
              // popup content
              Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: SizedBox(
                    width: popupWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: padding,
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: borderRadius),
                            child: Text(
                              text,
                              style: textStyle,
                            ))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }

  /// Dismisses the popup
  void dismiss() {
    if (!_isVisible) {
      return;
    }
    entry.remove();
    _isVisible = false;
    dismissCallback?.call();
  }
}
