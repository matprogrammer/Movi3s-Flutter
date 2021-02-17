import 'package:filmseview/src/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => SplashPage(),
      },
    );
  }
}
