import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/screens/starting_screens/ForgotPassword_screen.dart';
import '../../controllers/login_controller.dart';
import '../../resources/my_assets.dart';
import '../../utils/widgets/CommonText.dart';
import '../../utils/widgets/CustomSeparator.dart';
import '../../utils/widgets/TextFeild.dart';
import '../../utils/widgets/TextFormFeild.dart';
import '../../utils/widgets/my_button.dart';
import '../../utils/widgets/snackbar.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController getXController = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            top: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Sign In to your account.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MyColor.primaryDarkColor,
                  ),
                ),
              ),
              Center(child: const SizedBox(height: 8)),
              Center(
                child: Text(
                  "Let's sign in to your account & get started.",
                  style: TextStyle(
                    color: MyColor.darkGreyColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              LabeledTextField(label: "Email address"),
              TextFromField(
                controller: getXController.emailController,
                prefix: Icons.email_outlined,
                hintText: "info@example.com",
                hintTextColor: MyColor.HintColor,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                label: "Password",
              ),
              Obx(() => TextFromField(
                    controller: getXController.passwordController,
                    prefix: Icons.lock_outline,
                    hintText: "**********",
                    hintTextColor: MyColor.HintColor,
                    obscureText: !getXController.isPasswordVisible.value,
                    suffixIcon: Icon(
                      getXController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: getXController.togglePasswordVisibility,
                    // prefix: appEmailLogo,
                    borderColor: MyColor.TextFormBorderGreyColor,
                  )),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                        children: [
                          Container(
                            width: Get.width * 0.1,
                            child: Checkbox(
                              activeColor: MyColor.primaryDarkColor,
                              checkColor: MyColor.white,
                              value: getXController.agreedToTerms.value,
                              onChanged: (_) => getXController.rememberMe(),
                            ),
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(color: MyColor.darkGreyColor, fontSize: 10),
                          ),
                        ],
                      )),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: MyColor.blackGreyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              myButton(
                context: context,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (getXController.emailController.text.isEmpty && getXController.passwordController.text.isEmpty) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter Email & password ");
                  } else if (!isEmail(getXController.emailController.text) && !isPassword(getXController.passwordController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter valid email & Password");
                  } else if (!isEmail(getXController.emailController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter a valid email");
                  } else if (!isPassword(getXController.passwordController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Password must be at least 6 characters long");
                  } else {
                    getXController.signInUser();
                    getXController.clearFields();
                  }
                },
                btnName: 'Sign In',
              ),
              const SizedBox(height: 20),
              CustomSeparator(),
              const SizedBox(height: 18),
              Center(
                child: CommonText(
                  text: "Don't have account? ",
                  clickableText: "Sign up here",
                  onTap: getXController.goToSignUpscreen,
                ),
              ),
              const SizedBox(height: 20),
              myButton(
                context: context,
                onTap: getXController.loginWithGoogle,
                btnName: '  Login with Google',
                prefix: Image(image: appGoogleLogo),
                colorType: 2,
              ),
              const SizedBox(height: 16),
              myButton(
                context: context,
                onTap: getXController.loginWithFaceBook,
                btnName: 'Login with Facebook',
                prefix: Image(image: appFacebookLogo),
                colorType: 3,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmail(String text) {
    String emailRegex = r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(text);
  }

  bool isPassword(String text) {
    if (text.length < 6) {
      return false;
    }
    return true;
  }

  // bool isMobileNumber(String text) {
  //   String mobileRegex = r'^\d{10}$';
  //   RegExp regExp = RegExp(mobileRegex);
  //   return regExp.hasMatch(text);
  // }
}
