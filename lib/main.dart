import 'package:anim_playground/new_route.dart';
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
        new AnimatedLogoOnBuilder(animation: animation),
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
    } else {
      _controller.reverse();
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
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SecondScreen()));
        },
        child: FlutterLogo(
          size: animation.value,
        ),
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
        return Center(
          child: Container(
            height: animation.value,
            width: animation.value,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) =>
                        SecondScreen(),
                    transitionDuration: Duration(seconds: 2),
                    transitionsBuilder:
                        (ctx, animation, seconadaryAnimation, child) =>
                            SlideTransition(
                      position:
                          Tween(begin: Offset(1, 0.5), end: Offset.zero)
                              .animate(animation),
                      child: child,
                    ),
                  ),
                );
              },
              child: child,
            ),
          ),
        );
      },
      animation: animation,
      child: FlutterLogo(),
    );
  }
}
