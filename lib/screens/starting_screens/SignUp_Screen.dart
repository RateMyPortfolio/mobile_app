import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/controllers/login_controller.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import '../../resources/my_assets.dart';
import '../../utils/my_global.dart';
import '../../utils/widgets/CommonText.dart';
import '../../utils/widgets/CustomSeparator.dart';
import '../../utils/widgets/TextFeild.dart';
import '../../utils/widgets/TextFormFeild.dart';
import '../../utils/widgets/my_button.dart';
import '../../utils/widgets/snackbar.dart';
import 'SignIn_screen.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoginController getxcontroller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a New Account',
          style: TextStyle(
            // fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyColor.primaryDarkColor,
          ),
        ),
        centerTitle: true,
        leading: Back(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create an account to show to others that you are\nmanaged on (Test...)",
                style: TextStyle(
                  color:MyColor.darkGreyColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
              LabeledTextField(label:"Username"),
              TextFromField(
                controller:getxcontroller.CreateAccUserNameController,
                prefix: Icons.perm_identity,
                hintText: "Username",
                hintTextColor:MyColor.HintColor,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 14),
              LabeledTextField(label:"Email address"),
              TextFromField(
                controller: getxcontroller.CreateAccemailController,
                prefix: Icons.email_outlined,
                hintText: "info@example.com",
                hintTextColor:MyColor.HintColor,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 14),
              LabeledTextField(label:"Phone number"),
              TextFromField(
                controller: getxcontroller.CreateAccPhoneNoController,
                prefix: Icons.phone_in_talk_outlined,
                hintText: "+91-7348756812",
                hintTextColor:MyColor.HintColor,
                keyboardType: TextInputType.phone,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 14),
              LabeledTextField(label:"Password",),
              Obx(() => TextFromField(
                controller: getxcontroller.CreateAccPasswordController,
                prefix: Icons.lock_outline,
                hintText: "**********",
                hintTextColor:MyColor.HintColor,
                obscureText: !getxcontroller.isPasswordVisible.value,
                suffixIcon:Icon(
                  getxcontroller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: getxcontroller.togglePasswordVisibility,
                // prefix: appEmailLogo,
                borderColor: MyColor.TextFormBorderGreyColor,
              )),
              SizedBox(height: 24),
              myButton(
                context: context,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if(getxcontroller.CreateAccUserNameController.text.isEmpty) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter UserName");
                  } else if (!isEmail(getxcontroller.CreateAccemailController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter a valid email");
                  } else if (!isMobileNumber(getxcontroller.CreateAccPhoneNoController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please Enter Valid Phone Number");
                  } else if (!isPassword(getxcontroller.CreateAccPasswordController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Password must be at least 6 characters long");
                  } else {
                    getxcontroller.loginOtpApi("signup",true);
                    // getxcontroller.clearSignUpFeilds();
                  }
                },
                btnName: 'Next',
              ),
              const SizedBox(height: 35),
              CustomSeparator(),
              const SizedBox(height: 18),
              Center(
                child: CommonText(
                  text: "Already have Account? ",
                  clickableText: "Sign In here",
                  onTap: (){
                    // Get.back();
                    Get.to(()=>SignInScreen());
                  },
                ),
              ),
              const SizedBox(height: 20),
              myButton(
                context: context,
                onTap: (){},
                btnName: 'Login with Google',
                prefix:Image(image: appGoogleLogo ),
                colorType: 2,
              ),
              const SizedBox(height: 16),
              myButton(
                context: context,
                onTap:(){},
                btnName: 'Login with Facebook',
                prefix:Image(image: appFacebookLogo ),
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

  bool isMobileNumber(String text) {
    String mobileRegex = r'^\d{10}$';
    RegExp regExp = RegExp(mobileRegex);
    return regExp.hasMatch(text);
  }

}