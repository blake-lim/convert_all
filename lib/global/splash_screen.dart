import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'orientation_locker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../feature/convert/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/SplashScreen';
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  AnimationController? _textAnimationController;
  Animation<double>? _textSizeAnimation;

  @override
  void initState() {
    super.initState();

    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _textSizeAnimation = Tween<double>(begin: 16.0, end: 24.0)
        .animate(_textAnimationController!);
    _textSizeAnimation!.addListener(() {
      setState(() {});
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller!);

    _controller!.forward();
    _textAnimationController!.forward();
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    _textSizeAnimation!.addListener(() {
      setState(() {});
    });
    OrientationLocker.lockPortrait();
    return Scaffold(
      backgroundColor: const Color(0xFF3D3D3B),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: (screenHeight / 2) - 250,
            left: 0,
            right: 0,
            height: 400,
            child: Lottie.asset(
              'assets/lotties/splash2.json',
              fit: BoxFit.contain,
              controller: _controller,
              onLoaded: (composition) {
                _controller!.duration = composition.duration;
              },
            ),
          ),
          Positioned(
            bottom: (screenHeight / 2) - 180,
            left: 0,
            right: 0,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: _textSizeAnimation?.value ?? 24.0,
                      fontFamily: 'Yeongdeok Snow Crab',
                      height: 1.20,
                      color: Colors.white),
                  children: const <TextSpan>[
                    TextSpan(text: '다양한 '),
                    TextSpan(
                        text: '포맷을 한 곳',
                        style: TextStyle(color: Color(0xFF7347DF))),
                    TextSpan(text: '에서\n문서 '),
                    TextSpan(
                        text: '변환', style: TextStyle(color: Color(0xFF6EF685))),
                    TextSpan(
                        text: '', style: TextStyle(color: Color(0xFF6EF685))),
                    TextSpan(text: '은 한 곳에서 하세요!'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textAnimationController?.dispose();
    super.dispose();
  }
}
