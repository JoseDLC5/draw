import 'package:draw/draw_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(DrawApp());

class DrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: Center(
              child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Draw())),
        ));
  }
}
