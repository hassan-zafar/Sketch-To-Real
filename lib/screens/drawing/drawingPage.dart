import 'package:flutter/material.dart';
import 'package:fyp_sketch_to_real/screens/drawing/drawingArea.dart';

class DrawingPage extends StatefulWidget {
  // const DrawingPage({ Key key }) : super(key: key);

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<DrawingArea> points = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 256,
          height: 256,
          child: GestureDetector(
            onPanEnd: (details) {
              this.setState(() {
                points.add(null);
              });
            },
            onPanDown: (details) {
              this.setState(() {
                points.add(DrawingArea(
                    points: details.localPosition,
                    areaPaint: Paint()
                      ..color = Colors.white
                      ..strokeCap = StrokeCap.round
                      ..isAntiAlias = true
                      ..strokeWidth = 2.0));
              });
            },
          ),
        ),
      ),
    );
  }
}
