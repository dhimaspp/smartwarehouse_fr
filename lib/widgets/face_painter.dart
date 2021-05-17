import 'dart:ui';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FacePainter extends CustomPainter {
  FacePainter(
      {required this.imageSize, required this.face, required this.result});
  final Size? imageSize;
  double? scaleX, scaleY;
  Face? face;
  dynamic? result;
  @override
  void paint(Canvas canvas, Size size) {
    if (face == null) return;

    Paint paint;

    if (this.face!.headEulerAngleY! > 10 || this.face!.headEulerAngleY! < -10) {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.red;
    } else {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.green;
    }
    // for (String label in result.keys) {
    //   for (Face? face in result[label]) {
    scaleX = size.width / imageSize!.width;
    scaleY = size.height / imageSize!.height;

    canvas.drawRRect(
        _scaleRect(
            rect: face!.boundingBox,
            imageSize: imageSize,
            widgetSize: size,
            scaleX: scaleX!,
            scaleY: scaleY!),
        paint);
    // TextSpan span = new TextSpan(
    //     style: new TextStyle(color: Colors.orange[300], fontSize: 15),
    //     text: label); //disini label dilempar ke UI
    // TextPainter textPainter = new TextPainter(
    //     text: span,
    //     textAlign: TextAlign.left,
    //     textDirection: TextDirection.ltr);
    // textPainter.layout();
    // textPainter.paint(
    //     canvas,
    //     new Offset(
    //         size.width - (60 + face.boundingBox.left.toDouble()) * scaleX!,
    //         (face.boundingBox.top.toDouble() - 10) * scaleY!));
    //   }
    // }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.face != face;
  }
}

RRect _scaleRect(
    {required Rect rect,
    required Size? imageSize,
    required Size widgetSize,
    required double scaleX,
    required double scaleY}) {
  return RRect.fromLTRBR(
      (widgetSize.width - rect.left.toDouble() * scaleX),
      rect.top.toDouble() * scaleY,
      widgetSize.width - rect.right.toDouble() * scaleX,
      rect.bottom.toDouble() * scaleY,
      Radius.circular(10));
}
