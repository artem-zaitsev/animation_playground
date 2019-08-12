import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Another screen"),
              Hero(
                child: FlutterLogo(
                  size: 100,
                ),
                tag: 'hero',
              )
            ],
          ),
        ),
      ),
    );
  }
}
