import 'package:flutter/material.dart';
import 'package:convert_project/global/splash_screen.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Pretendard'),
          bodyMedium: TextStyle(fontFamily: 'Pretendard'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTextStyle(
        style: const TextStyle(color: Colors.black, fontSize: 16.0),
        child: FutureBuilder(
          future: Future.value(),
          builder: (context, snapshot) {
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
