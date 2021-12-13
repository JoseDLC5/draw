import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  Color selectedColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints> points = List();
  //bool showBottomList = false;
  // double opacity = 1.0;
  // StrokeCap strokeCap = StrokeCap.round;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.clear),
          backgroundColor: Colors.pink,
          onPressed: () {
            clearPoints();
          }),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  // ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  // ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null);
          });
        },
        child: RepaintBoundary(
          child: Container(

            // color: Colors.transparent,
            child: CustomPaint(
              size: Size.infinite,
              painter: DrawingPainter(
                  pointsList: points, box: context.findRenderObject()),
            ),
          ),
        ),
      ),
    );
  }

  void clearPoints() {
    setState(() {
      points.clear();
    });
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.pointsList, this.box});
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();
  RenderBox box;
  @override
  void paint(Canvas canvas, Size size) {
    //TODO FIX canvas clipping
    canvas.clipRect(this.box.semanticBounds);
    //canvas.clipRRect(rrect)

    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        // offsetPoints.clear();
        // offsetPoints.add(pointsList[i].points);
        // offsetPoints.add(Offset(
        //     pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        //canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;
  DrawingPoints({this.points, this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color }
