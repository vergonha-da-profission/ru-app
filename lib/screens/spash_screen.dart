import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Vdp',
                style: GoogleFonts.roboto(
                  fontSize: 80,
                  color: Colors.black12,
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 250,
              width: 250,
              child: Image.asset(
                'assets/img/logo.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
