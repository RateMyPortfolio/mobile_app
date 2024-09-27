
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_portfolio/resources/my_assets.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/screens/starting_screens/splash_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(options: DefaultFirebaseOptions.)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(appSplashLogo, context);
    return GetMaterialApp(
      title: 'Rate My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardTheme: CardTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white
        ),
        primaryColor: MyColor.primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, brightness: Brightness.dark),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent
          )
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.roboto(),
          bodyMedium:GoogleFonts.roboto(),
          bodySmall: GoogleFonts.roboto(),
          displayLarge: GoogleFonts.roboto(),
          displayMedium:GoogleFonts.roboto() ,
          displaySmall:GoogleFonts.roboto() ,
          headlineLarge: GoogleFonts.roboto(),
          headlineMedium: GoogleFonts.roboto(),
          headlineSmall: GoogleFonts.roboto(),
          labelLarge:GoogleFonts.roboto() ,
          labelMedium: GoogleFonts.roboto(),
          labelSmall: GoogleFonts.roboto(),
          titleLarge: GoogleFonts.roboto(),
          titleMedium: GoogleFonts.roboto(),
          titleSmall: GoogleFonts.roboto(),
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
