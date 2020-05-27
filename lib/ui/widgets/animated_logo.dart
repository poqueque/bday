import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  Animatable<Color> flameColor = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.yellow,
          end: Colors.deepOrange,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.deepOrange,
          end: Colors.yellow,
        ),
      ),
    ],
  );

  AnimationController _animationController;
  AnimationController _colorController;
  AnimationController _positionController1;
  AnimationController _positionController2;
  AnimationController _positionController3;
  AnimationController _positionController4;
  Animation<Offset> _offsetAnimation1;
  Animation<Offset> _offsetAnimation2;
  Animation<Offset> _offsetAnimation3;
  Animation<Offset> _offsetAnimation4;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      lowerBound: -0.08,
      upperBound: 0.08,
      duration: Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(() {
        this.setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward(from: -1.0);

    _colorController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _positionController1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _positionController1,
      curve: Curves.elasticOut,
    ));

    _positionController2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _positionController2,
      curve: Curves.elasticOut,
    ));

    _positionController3 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _offsetAnimation3 = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _positionController3,
      curve: Curves.elasticOut,
    ));
    _positionController4 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();
    _offsetAnimation4 = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _positionController4,
      curve: Curves.elasticOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var _textStyle =
        GoogleFonts.montserrat(fontWeight: FontWeight.w900, fontSize: 33);

    return Container(
      child: Column(
        children: <Widget>[
/*          Container(
            width: 20,
            height: 20,
            child: RotationTransition(
              turns: _animationController,
              child: CustomPaint(
                painter: FlamePainter(flameColor
                    .evaluate(AlwaysStoppedAnimation(_colorController.value))),
              ),
            ),
          ),*/
          Image.asset(
            'assets/images/cake.png',
            height: 70,
            width: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                alignment: Alignment.center,
                width: 25,
                height: 35,
                child: SlideTransition(
                    position: _offsetAnimation1,
                    child: Text(
                      "B",
                      style: _textStyle,
                    )),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                alignment: Alignment.center,
                width: 25,
                height: 35,
                child: SlideTransition(
                    position: _offsetAnimation2,
                    child: Text(
                      "D",
                      style: _textStyle,
                    )),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                alignment: Alignment.center,
                width: 25,
                height: 35,
                child: SlideTransition(
                    position: _offsetAnimation3,
                    child: Text(
                      "A",
                      style: _textStyle,
                    )),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                alignment: Alignment.center,
                width: 25,
                height: 35,
                child: SlideTransition(
                    position: _offsetAnimation4,
                    child: Text(
                      "Y",
                      style: _textStyle,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _colorController.dispose();
    _positionController1.dispose();
    _positionController2.dispose();
    _positionController3.dispose();
    _positionController4.dispose();
    super.dispose();
  }
}

class FlamePainter extends CustomPainter {
  final Color color;

  FlamePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 4.0;
    var w = size.width / 6;
    var h = size.height / 6;

    var path = Path();

    path.moveTo(3 * w, 6 * h);
    path.quadraticBezierTo(4.8 * w, 5.3 * h, 5 * w, 4 * h);
    path.quadraticBezierTo(5 * w, 2 * h, 2 * w, 0 * h);
    path.quadraticBezierTo(2.5 * w, 1.4 * h, 1.7 * w, 2.8 * h);
    path.quadraticBezierTo(1.1 * w, 3.6 * h, 1 * w, 4 * h);
    path.quadraticBezierTo(1 * w, 5.5 * h, 3 * w, 6 * h);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
