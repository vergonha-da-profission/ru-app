import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomCircularLoading extends StatelessWidget {
  const CustomCircularLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lotties/splashy-loader.json',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
