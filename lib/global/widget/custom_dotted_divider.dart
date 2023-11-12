import 'package:flutter/material.dart';

class CustomDottedDivider extends CustomPainter {
  final Color color;
  final double dotRadius;

  CustomDottedDivider(
      {this.color = const Color(0xff855FCE), this.dotRadius = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round;

    double start = 0.0;
    while (start < size.width) {
      canvas.drawCircle(Offset(start, size.height / 2), dotRadius, paint);
      start += dotRadius * 2 * 1.5;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDottedDivider(),
      size: const Size(double.infinity, 1),
    );
  }
}
