import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo2.png',
              height: 200,
              width: 200,
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              animation: true,
              lineHeight: 10.0,
              animationDuration: 2900,
              percent: 1,
              barRadius: const Radius.circular(16),
              progressColor: Colors.black,
              backgroundColor: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
