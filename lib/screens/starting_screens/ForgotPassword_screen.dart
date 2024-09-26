import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/utils/my_global.dart';
import '../../controllers/login_controller.dart';
import '../../resources/my_assets.dart';
import '../../utils/widgets/TextFeild.dart';
import '../../utils/widgets/TextFormFeild.dart';
import '../../utils/widgets/my_button.dart';
import '../../utils/widgets/snackbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final LoginController getXController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Back(),
        backgroundColor: MyColor.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColor.primaryDarkColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your registered email and we'll send you \nverification code on your email.",
              style: TextStyle(
                color:MyColor.darkGreyColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 24),
            LabeledTextField(label:"Email address",),
            SizedBox(height: 8),
            TextFromField(
              controller: getXController.forgotemailController,
              prefix: Icons.email_outlined,
              hintText: "info@mail.com",
              hintTextColor:MyColor.HintColor,
              suffixIcon:Image(image:appRightMarkArrow ,width: 13.0,
                height: 13.0,),
              // prefix: appEmailLogo,
              obscureText: false,
              borderColor: MyColor.TextFormBorderGreyColor,
            ),
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child:  myButton(
                  context: context,
                  onTap:(){
                       if (!isEmail(getXController.forgotemailController.text)) {
                        DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter a valid email");
                      }  else {
                         getXController.loginOtpApi("forget_pwd", true);
                         // getXController.forgotemailController.clear();
                      }
                  },
                  btnName: 'Send OTP',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool isEmail(String text) {
    String emailRegex = r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(text);
  }
}

