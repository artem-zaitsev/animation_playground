import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _controller;

  double top = 0, left = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(_controller)
      ..addStatusListener((status) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            left: left,
            top: top,
            child: new AnimatedLogoOnBuilder(animation: animation)),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _run,
        tooltip: 'Start',
        child: Icon(_controller.isCompleted ? Icons.refresh : Icons.play_arrow),
      ),
    );
  }

  void _run() {
    if (!_controller.isCompleted) {
      _controller.forward();
      setState(() {
        top = 200;
      });
    } else {
      _controller.reverse();
      top = 0;
      setState(() {
        
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedLogoSimple extends AnimatedWidget {
  const AnimatedLogoSimple({
    Key key,
    @required this.animation,
  }) : super(key: key, listenable: animation);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterLogo(
        size: animation.value,
      ),
    );
  }
}

class AnimatedLogoOnBuilder extends StatelessWidget {
  const AnimatedLogoOnBuilder({
    Key key,
    @required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (ctx, child) {
        return Container(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: FlutterLogo(),
    );
  }
}
