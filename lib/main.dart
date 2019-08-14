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

  bool _completed = false;
  double top = 0, bottom = 400;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(_controller)
      ..addStatusListener((status) {
        // setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.slowMiddle,
            top: top,
            bottom: bottom,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.indigo,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _run,
        tooltip: 'Start',
        child: Icon(_completed ? Icons.refresh : Icons.play_arrow),
      ),
    );
  }

  void _run() {
    if (!_completed) {
      top = 400;
      bottom = 0;
      // _controller.forward();
    } else {
      // _controller.reverse();
      top = 0;
      bottom = 400;
    }
    setState(() {
      _completed = !_completed;
    });
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
                      position: Tween(begin: Offset(1, 0.5), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'hero',
                child: child,
              ),
            ),
          ),
        );
      },
      animation: animation,
      child: FlutterLogo(),
    );
  }
}
