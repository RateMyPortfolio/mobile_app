import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../resources/my_assets.dart';
import '../../resources/my_colors.dart';
import '../../utils/my_global.dart';
import '../../utils/widgets/TextFeild.dart';
import '../../utils/widgets/TextFormFeild.dart';
import '../../utils/widgets/my_button.dart';
import '../../utils/widgets/snackbar.dart';

class ConformPassword extends StatefulWidget {
  String email;
  ConformPassword(this.email, {Key? key}) : super(key: key);

  @override
  State<ConformPassword> createState() => _ConformPasswordState();
}

class _ConformPasswordState extends State<ConformPassword> {
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
          'Reset Password',
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
            SizedBox(height: 5),
            Text(
              "Enter your new password and confirm it below.",
              style: TextStyle(
                color: MyColor.darkGreyColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 24),
            LabeledTextField(
              label: "New Password",
            ),
            SizedBox(height: 5),
            Obx(() => TextFromField(
                  controller: getXController.NewpasswordController,
                  prefix: Icons.lock_outline,
                  hintText: "**********",
                  hintTextColor: MyColor.HintColor,
                  obscureText: !getXController.isNewPasswordVisible.value, // Use the observable here
                  suffixIcon: IconButton(
                    icon: Icon(
                      getXController.isNewPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: getXController.togglePasswordVisibilityReset,
                  ),
                  borderColor: MyColor.TextFormBorderGreyColor,
                )),
            SizedBox(height: 12),
            LabeledTextField(
              label: "Conform Password",
            ),
            SizedBox(height: 6),
            Obx(() => TextFromField(
                  controller: getXController.NewconfirmPasswordController,
                  prefix: Icons.lock_outline,
                  hintText: "**********",
                  hintTextColor: MyColor.HintColor,
                  obscureText: !getXController.isNewConfirmPasswordVisible.value, // Use the observable here
                  suffixIcon: IconButton(
                    icon: Icon(
                      getXController.isNewConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: getXController.toggleConfirmPasswordVisibilityReset,
                  ),
                  borderColor: MyColor.TextFormBorderGreyColor,
                )),
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: myButton(
                  context: context,
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    if (getXController.NewpasswordController.text.isEmpty || getXController.NewconfirmPasswordController.text.isEmpty) {
                      DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter both New Password & Confirm Password");
                    } else if (!isPassword(getXController.NewpasswordController.text)) {
                      DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Password must be at least 6 characters long");
                    } else if (getXController.NewpasswordController.text != getXController.NewconfirmPasswordController.text) {
                      DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Both passwords must match");
                    } else {
                      String email = widget.email;
                      print("email confrom password  :${email.toString()}");
                      getXController.confirmPassword(email);
                      // getXController.ResetpasswordclearFields;
                    }
                  },
                  btnName: 'Save',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isPassword(String text) {
    if (text.length < 6) {
      return false;
    }
    return true;
  }
}
