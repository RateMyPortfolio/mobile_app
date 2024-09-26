import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';

import '../../controllers/login_controller.dart';
import '../../utils/my_global.dart';
import '../../utils/widgets/my_button.dart';
import '../../utils/widgets/snackbar.dart';
import 'Conform_Password_screen.dart';

class LoginEnterOTP extends StatefulWidget {
  String from;
  LoginEnterOTP(this.from, {super.key});
  @override
  State<LoginEnterOTP> createState() => _LoginEnterOTPState();
}
class _LoginEnterOTPState extends State<LoginEnterOTP> {
  final LoginController getXController = Get.put(LoginController());
  TextEditingController txtpin = TextEditingController();
  String enterOTP = "";
  bool isOtpResent = false;
  late Timer timer;
  int secondsRemaining = 120;
  bool enableResend = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          getXController.textGetOtp = "";
          enableResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "OTP verification",
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.055,
            color: MyColor.primaryDarkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Back(),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoText(size),
            buildPinCodeField(size),
            buildSubmitButton(size),
            SizedBox(height: size.height * 0.020),
            buildResendSection(size),
          ],
        ),
      ),
    );
  }

  Widget buildInfoText(Size size) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "We have sent you a verification code on your email address.",
            style: GoogleFonts.getFont(
              'Poppins',
              color: MyColor.darkGreyColor,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPinCodeField(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: PinCodeTextField(
            controller: txtpin,
            appContext: context,
            length: 4,
            enableActiveFill: false,
            textStyle: TextStyle(fontSize: 15 ,color:MyColor.black),
            keyboardType: TextInputType.number,
            cursorColor: MyColor.primaryColor,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderWidth: 0.8,
              borderRadius: BorderRadius.circular(7),
              fieldHeight: 50,
              fieldWidth: 43,
              fieldOuterPadding: EdgeInsets.symmetric(horizontal: 15),
              activeColor: MyColor.darkGreyColor,
              inactiveColor: MyColor.primaryDarkColor,
              selectedColor: MyColor.primaryDarkColor,
            ),
            onChanged: (String value) {
              enterOTP = value;
            },
          ),
        ),
      ),
    );
  }

  Widget buildSubmitButton(Size size) {
    return myButton(
      context: context,
      onTap: () {
        if (enterOTP.length == 4) {
          if (enterOTP != getXController.textGetOtp) {
            DisplaySnackbar().errorSnackBar(
                title: "Failed", msg: "OTP is incorrect, Please try again");
          } else {
            if (widget.from != "forgot") {
              getXController.signup(
                username: getXController.CreateAccUserNameController.text,
                email: getXController.CreateAccemailController.text,
                mobile: getXController.CreateAccPhoneNoController.text,
                password: getXController.CreateAccPasswordController.text,
              );
            } else {
              Get.to(() => ConformPassword(getXController.forgotemailController.text));
            }
          }
        } else {
          DisplaySnackbar().errorSnackBar(
              title: "Failed", msg: "OTP must be 4 digits");
        }
      },
      btnName: widget.from != "forgot" ? 'Sign Up' : 'Verify OTP',
    );
  }



  Widget buildResendSection(Size size) {
    return enableResend
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  '(OTP is Expired)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              InkWell(
                onTap: _resendCode,
                child: Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: MyColor.primaryColor))),
                  child: Text(
                    'Resend Code',
                    style: TextStyle(color: MyColor.primaryDarkColor, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          )
        : Text(
            "Didn't receive it? Retry in ${formatTime(secondsRemaining)}",
            style: GoogleFonts.getFont('Poppins', fontSize: size.width * 0.035, color: Colors.grey, fontWeight: FontWeight.w500),
          );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // void _resendCode() {
  //   setState(() {
  //     secondsRemaining = 120;
  //     enableResend = false;
  //     enterOTP = "";
  //   });
  //   getXController.getOtp();
  // }
  void _resendCode() {
    isOtpResent = true;
    if (enableResend) {
      txtpin.clear();
      // getXController.loginOtpApi("signup",false);
      getXController.loginOtpApi( widget.from == "forgot" ?"forget_pwd" : "signup",false);
      enableResend = false;
      enterOTP ="";
      secondsRemaining = 120;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          enableResend = true;
          timer.cancel();
        }
      });
    }
  }
}
