import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberOfRows = 11;
  int numberOfSquares = 15 * numberOfRows;

  List<int> barries = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    21,
    32,
    43,
    54,
    65,
    76,
    87,
    98,
    109,
    120,
    131,
    142,
    153,
    164,
    163,
    162,
    161,
    160,
    159,
    158,
    157,
    156,
    154,
    155,
    154,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    88,
    99,
    110,
    121,
    132,
    143,
    154,
    67,
    68,
    69,
    75,
    74,
    73,
    72,
    97,
    96,
    95,
    94,
    89,
    90,
    91,
    92,
    70,
    37,
    39,
    28,
    24,
    35,
    46,
    30,
    41,
    52,
    26,
    59,
    61,
    38,
    112,
    123,
    134,
    136,
    125,
    126,
    127,
    168,
    103,
    105,
    118,
    129,
    140,
    138
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GridView.builder(
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberOfRows),
                itemBuilder: (context, index) {
                  if (barries.contains(index)) {
                    return Barries(
                      innerColor: Colors.blue[800],
                      outerColor: Colors.blue[900],
                    );
                  } else if (index == 82) {
                    return const PacMan();
                  } else {
                    return const Coin(
                      color: Colors.yellow,
                    );
                  }
                }),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Score: ",
                    style: TextStyle(fontSize: 40, color: Colors.white)),
                Text("P L A Y",
                    style: TextStyle(fontSize: 40, color: Colors.white))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Barries extends StatelessWidget {
  final Widget? child;
  final Color? outerColor;
  final Color? innerColor;

  const Barries(
      {Key? key,
      this.child,
      required this.innerColor,
      required this.outerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: outerColor,
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: innerColor,
              padding: const EdgeInsets.all(4),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

class Coin extends StatelessWidget {
  final Color? color;

  const Coin({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: color,
        ),
      ),
    );
  }
}

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
