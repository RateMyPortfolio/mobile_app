import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';
import '../../resources/my_colors.dart';
import '../../utils/my_global.dart';
import '../../utils/widgets/TextFeild.dart';

import '../../utils/widgets/TextFormFeild.dart';
import '../../utils/widgets/my_button.dart';
import '../../utils/widgets/snackbar.dart';
class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final LoginController getXController = Get.put(LoginController());

  Widget build(BuildContext context) {
    final LoginController getxcontroller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        leading: Back(),
        title: Text(
          'Contact Us',
          style: TextStyle(
            // fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyColor.primaryDarkColor,
          ),
        ),
        centerTitle: true,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              LabeledTextField(label:"Name"),
              TextFromField(
                controller:getxcontroller.ContactUsNameController,
                hintText: "Name",
                hintTextColor:MyColor.HintColor,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 14),
              LabeledTextField(label:"Email address"),
              TextFromField(
                controller: getxcontroller.ContactUsEmailadressController,
                hintText: "info@example.com",
                hintTextColor:MyColor.HintColor,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 14),
              LabeledTextField(label:"Phone number"),
              TextFromField(
                controller: getxcontroller.ContactUsPhoneNoController,
                hintText: "+91-7348756812",
                hintTextColor:MyColor.HintColor,
                keyboardType: TextInputType.phone,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 14),
              LabeledTextField(label:"Comment",),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: getxcontroller.ContactUsCommentController,
                  style: TextStyle(color: MyColor.darkGreyColor,),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(color: MyColor.HintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: MyColor.textGreyColor),
                    ),
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),

              SizedBox(height: 24),
              myButton(
                context: context,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if(getxcontroller.ContactUsNameController.text.isEmpty) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter Name");
                  } else if (!isEmail(getxcontroller.ContactUsEmailadressController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please enter a valid email");
                  } else if (!isMobileNumber(getxcontroller.ContactUsPhoneNoController.text)) {
                    DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Please Enter Valid Phone Number");
                  } else {
                 // write here Subbmit event
                  }
                },
                btnName: 'Submit',
              ),
              const SizedBox(height: 35),
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


  bool isMobileNumber(String text) {
    String mobileRegex = r'^\d{10}$';
    RegExp regExp = RegExp(mobileRegex);
    return regExp.hasMatch(text);
  }
}
