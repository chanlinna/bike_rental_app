import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerGenerator {
  static Future<BitmapDescriptor> createCustomMarkerBitmap(
    int bikeCount,
    Color color,
    double size, 
  ) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = color;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size * 0.08;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, borderPaint);

    // the number text
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: bikeCount.toString(),
      style: TextStyle(
        fontSize: size * 0.45, 
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(
        (size / 2) - (painter.width / 2),
        (size / 2) - (painter.height / 2),
      ),
    );

    final img = await pictureRecorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
