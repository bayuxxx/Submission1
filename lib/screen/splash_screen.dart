import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ubay_restaurant/models/theme.dart';
import 'package:ubay_restaurant/screen/home_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/logo.png"),
      loaderColor: Colors.white,
      title: Text(
        "UBAY RESTAURANT",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      backgroundColor: MyColor.c,
      showLoader: true,
      loadingText: Text(
        "Loading...",
        style: GoogleFonts.poppins(color: Colors.white),
      ),
      navigator: const HomeScreen(),
      durationInSeconds: 5,
    );
  }
}
