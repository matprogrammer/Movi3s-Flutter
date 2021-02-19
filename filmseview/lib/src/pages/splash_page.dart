import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'home_page.dart';


class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    setTimer();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  void setTimer() {
    const int time = 3;
    Timer(Duration(seconds: time), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: ([Colors.blueGrey[900], Colors.blueGrey[700]]),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [buildLogo(), buildLoadingAnimation()],
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Text(
        'MOVI3S',
        style: GoogleFonts.lato(
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 60.0),
        ),
      ),
    );
  }

  Widget buildLoadingAnimation() {
    return Container(
      height: 100,
      child: Lottie.asset(
        'lottie/circular-loading.json',
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..reset()
            ..repeat(period: Duration(seconds: 3));
        },
      ),
    );
  }
}
