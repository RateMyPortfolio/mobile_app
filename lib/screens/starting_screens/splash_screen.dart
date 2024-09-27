import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/screens/starting_screens/ProfileScreen.dart';
import 'package:rate_my_portfolio/utils/local_database/shdf.dart';

import '../../resources/my_assets.dart';
import '../../utils/local_database/key_constants.dart';
import 'GetStarted_Screen.dart';
import 'SignIn_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));
    Future.delayed(Duration(seconds: 4), () => handleSession(context));
    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => SignInScreen()),
    //   );
    // });
  }


  handleSession(BuildContext context) async {
    int? userId = await SHDFClass.readIntValue(KeyConstants.userId,0);
    if(userId != null) {
        // Get.offAll(()=> ProfilePage());
        Get.offAll(()=> GetStartedScreen());
    } else {
      Get.offAll(()=> SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: FadeInUp(
        duration: Duration(seconds: 3),
        from: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width,
                child: Center(
                  child: Image(image: appSplashLogo),
                ),
              ),
              Text(
                'Rate My Portfolio',
                style: GoogleFonts.satisfy(
                  fontSize: 32,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  color: MyColor.FaceBookDarkColor,
                ),
              ),
              SizedBox(height: Get.height * 0.05,)
            ],
          ),
        ),
      ),
    );
  }
}