import 'package:flutter/material.dart';

import 'coin.dart';
import 'constants.dart';
import 'player.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    return const Coin();
                  }
                }),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Score: ",
                    style: TextStyle(fontSize: 40, color: Colors.white)),
                GestureDetector(
                  onTap: startGame(),
                  child: const Text("P L A Y",
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

startGame() {}

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
