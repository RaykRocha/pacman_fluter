import 'package:flutter/material.dart';
import 'dart:math' as math;

class PacMan extends StatefulWidget {
  const PacMan({Key? key}) : super(key: key);

  @override
  _PacManState createState() => _PacManState();
}

class _PacManState extends State<PacMan> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 1.0, end: 1.2).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return SizedBox(
            child: CustomPaint(
              painter: PacManPainter(openAngle: _animation.value),
            ),
          );
        });
  }
}

class PacManPainter extends CustomPainter {
  late Paint _pacMan;
  double openAngle;

  PacManPainter({required this.openAngle});

  @override
  void paint(canvas, size) {
    _pacMan = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    Offset _center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
        Rect.fromCenter(
            center: _center, width: size.width, height: size.height),
        math.pi,
        math.pi / openAngle,
        true,
        _pacMan);

    canvas.drawArc(
        Rect.fromCenter(
            center: _center, width: size.width, height: size.height),
        -math.pi,
        -math.pi / openAngle,
        true,
        _pacMan);
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return true;
  }
}
