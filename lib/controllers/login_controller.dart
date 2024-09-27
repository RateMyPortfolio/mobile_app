import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/screens/Home_Screens/portfolio_Listing.dart';
import 'package:rate_my_portfolio/screens/starting_screens/SignIn_screen.dart';
import '../models/request/post_SignUp_request.dart';
import '../models/request/post_conformpassword_request.dart';
import '../models/request/post_getprofile_request.dart';
import '../models/request/post_getstartedBroker_request.dart';
import '../models/request/post_signIn_request.dart';
import '../models/responce/get_signIn_responce.dart';
import '../models/responce/send_OTP_responce.dart';
import '../models/request/send_OTP_request.dart';
import '../network/repositary.dart';
import '../resources/my_assets.dart';
import '../screens/starting_screens/GetStarted_Screen.dart';
import '../screens/starting_screens/LoginEnterOTP.dart';
import '../screens/starting_screens/ProfileScreen.dart';
import '../screens/starting_screens/SignUp_Screen.dart';
import '../utils/dialog/ok_dialog.dart';
import '../utils/local_database/key_constants.dart';
import '../utils/local_database/shdf.dart';
import '../utils/widgets/snackbar.dart';

class LoginController extends GetxController {
  final CreateAccemailController = TextEditingController();
  final CreateAccUserNameController = TextEditingController();
  final CreateAccPhoneNoController = TextEditingController();
  final CreateAccPasswordController = TextEditingController();
  final forgotemailController = TextEditingController();
  final  NewpasswordController = TextEditingController();
  final  NewconfirmPasswordController = TextEditingController();
  final  GetStartedAngleTextController = TextEditingController();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isNewConfirmPasswordVisible = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final agreedToTerms = false.obs;
  String textGetOtp = "";
  var isChecked = false.obs;


  void showToast({required BuildContext context, required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 13,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: MyColor.white,
      textColor: MyColor.black,
    );
  }
//profile page scrren data
  var lastSynced = '20th July, 2024'.obs;
  void syncPortfolio() {
    lastSynced.value = "20th September, 2024";
  }
  //end
  @override
  void onInit() {
    super.onInit();
  }
  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  void DontAskAgainSkip() {
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void togglePasswordVisibilityReset() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibilityReset() {
    isNewConfirmPasswordVisible.value = !isNewConfirmPasswordVisible.value;
  }

  void rememberMe() {
    agreedToTerms.value = !agreedToTerms.value;
  }
  void goToSignUpscreen(){
    Get.to(() => SignUpPage());
  }
  void loginWithFaceBook(){
    // Get.to(SignUpPage());
  }void loginWithGoogle(){
    // Get.to(SignUpPage());
  }

  Future<void> signInUser() async {
    try {
      // String? token = await FirebaseMessaging.instance.getToken();
      String token = "";

      SignInRequest signInRequest = SignInRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firebaseToken: token,
      );

      log("RequestData: ${json.encode(signInRequest.toJson())}");

      final results = await Repository.hitSignInApi(signInRequest);

      if (results != null) {
        SignInResponce responseModel = results;

        if (responseModel.status == 200) {
          log("Sign-In Successful: ${responseModel.payload}");

          if (responseModel.payload.userId != 0) {
            await SHDFClass.saveIntValue(KeyConstants.userId, responseModel.payload.userId);
            await SHDFClass.saveStringValue(KeyConstants.accesToken, responseModel.payload.apiToken.access);
            await SHDFClass.saveStringValue(KeyConstants.email, responseModel.payload.email);
            await SHDFClass.saveStringValue(KeyConstants.phone, responseModel.payload.mobile);
          }
          // Get.offAll(() => ProfilePage());
          Get.offAll(() => GetStartedScreen());
        } else {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                OKDialog(
                  title: "",
                  descriptions: responseModel.msg,
                  img: errorIcon,
                ),
          );
        }
      }
    } catch (e) {
      log("SignInError: $e");
      showToast(context: Get.context!, msg: "Error occurred during sign-in.");
    }
  }
  void clearFields(){
    emailController.clear();
    passwordController.clear();
  }
  void ResetpasswordclearFields(){
    NewpasswordController.clear();
    NewconfirmPasswordController.clear();
  }
  void clearSignUpFeilds(){
    CreateAccemailController.clear();
    CreateAccPasswordController.clear();
    CreateAccUserNameController.clear() ;
    CreateAccPhoneNoController.clear();
  }

  // Future<void> LoginOtpApi(String type, bool isNormalFlow,) async {
  //   try {
  //     String email = forgotemailController.text.trim();
  //     SendOtpRequest sendOtpRequest = SendOtpRequest(
  //       email: CreateAccemailController.text.trim(),
  //       typeFor: type,
  //     );
  //     log("RequestData: ${json.encode(sendOtpRequest.toJson())}");
  //
  //     final results = await Repository.hitSendOTPApi(sendOtpRequest);
  //
  //     if (results != null) {
  //       SendOtpResponce responseModel = results;
  //
  //       print("print result ${responseModel.toJson()}");
  //
  //       if (responseModel.status == 200) {
  //         textGetOtp = responseModel.otp;
  //         print("OTP Request Successful: ${textGetOtp}");
  //         if(isNormalFlow) {
  //           if(type == 'signup') {
  //             Get.to(() => LoginEnterOTP(), arguments: {
  //               'email': CreateAccemailController.text.trim(),
  //               'username': CreateAccUserNameController.text.trim(),
  //               'phone': CreateAccPhoneNoController.text.trim(),
  //               'password': CreateAccPasswordController.text.trim(),
  //               'otp': textGetOtp,
  //             });
  //           }else if (type == 'forget_pwd'){
  //             print("forget_pwd click") ;
  //             Get.to(() => LoginEnterOTP(), arguments: {
  //               'email': forgotemailController.text.trim(),
  //               'otp': textGetOtp,
  //             });
  //           }
  //         }
  //       } else {
  //         showDialog(
  //           context: Get.context!,
  //           builder: (BuildContext context1) => OKDialog(
  //             title: "Error",
  //             descriptions: responseModel.msg,
  //             img: errorIcon,
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     log("LoginApiError: $e");
  //     showToast(context: Get.context!, msg: "Error occurred during sign-up.");
  //   }
  // }

  Future<void> loginOtpApi(String type, bool isNormalFlow) async {
    try {
      String email;
      if (type == 'signup') {
        email = CreateAccemailController.text.trim();
      } else if (type == 'forget_pwd') {
        email = forgotemailController.text.trim();
      } else {
        throw Exception("Invalid type provided");
      }

      SendOtpRequest sendOtpRequest = SendOtpRequest(
        email: email,
        typeFor: type,
      );
      log("RequestData: ${json.encode(sendOtpRequest.toJson())}");

      final results = await Repository.hitSendOTPApi(sendOtpRequest);

      if (results != null) {
        SendOtpResponce responseModel = results;

        print("print result ${responseModel.toJson()}");

        if (responseModel.status == 200) {
          textGetOtp = responseModel.otp;
          print("OTP Request Successful: ${textGetOtp}");
          if(isNormalFlow) {
            if(type == 'signup') {
              Get.to(() => LoginEnterOTP(""));
            }else if (type == 'forget_pwd'){
              print("forget_pwd click") ;
              Get.to(() => LoginEnterOTP("forgot"));
            }
          }
        } else {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "Error",
              descriptions: responseModel.msg,
              img: errorIcon,
            ),
          );
        }
      }
    } catch (e) {
      log("LoginApiError: $e");
      showToast(context: Get.context!, msg: "Error occurred during sign-up.");
    }
  }

  Future<void> signup({
    required String username,
    required String email,
    required String mobile,
    required String password,
  }) async {

    SignUpRequest signUpRequest = SignUpRequest(
      username: username,
      password: password,
      email: email,
      mobile: mobile,
    );
    log("SignUp Request Data: ${json.encode(signUpRequest.toJson())}");

    final response = await Repository.hitSignUpApi(signUpRequest);

    if (response != null && response.status == 200) {
      await SHDFClass.saveIntValue(KeyConstants.userId, response.payload.userId);
      await SHDFClass.saveStringValue(KeyConstants.email, response.payload.email);
      await SHDFClass.saveStringValue(KeyConstants.phone, response.payload.mobile);
      await SHDFClass.saveStringValue(KeyConstants.accesToken, response.payload.apiToken.access);
       Get.offAll(() => GetStartedScreen());
      Fluttertoast.showToast(msg: response.msg);
    } else {
      DisplaySnackbar().errorSnackBar(title: "Failed", msg: response?.msg ?? "Signup failed. Please try again.");
    }
  }

  Future<void> confirmPassword(String email) async {
    ConfromPassowrdRequest ConfromPassowrdRequests = ConfromPassowrdRequest(
      email: email,
      password: NewpasswordController.text.trim(),
    );

    final response = await Repository.hitConformPasswordApi(ConfromPassowrdRequests);

      if (response != null && response.status == 200) {
        DisplaySnackbar().successSnackBar(
          title: "Success",
          msg: response.msg,
        );
        Get.offAll(() => SignInScreen());
      } else {
        DisplaySnackbar().errorSnackBar(
          title: "Failed",
          msg: response?.msg ?? "An error occurred",
        );
      }
    }


  Future<void> getStartedBrokerConnectNow() async {

    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);
    String? accessToken =
    await SHDFClass.readStringValue(KeyConstants.accesToken,"");

    if (userId == null || userId == 0) {
      DisplaySnackbar().errorSnackBar(
        title: "Error",
        msg: "User ID not found.",
      );
      return;
    }

    GetStartedBrokerRequest getStartedBrokerRequest = GetStartedBrokerRequest(
      userId: userId.toString(),
      brokerName: "ANGLEONE",
      clientId: "A53471568",
      pin: "4747",
      totp: "X3GQVYF2SO7LQY5ESGD5XYEWZQ",
    );

    final response = await Repository.hitPostSaveBrokerApi(getStartedBrokerRequest);

    if (response != null && response.status == 200) {
      DisplaySnackbar().successSnackBar(
        title: "Success",
        msg: response.msg,
      );
      Get.offAll(() => PortfolioListingPage());
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

 Future<void> getPortfolioProfileViewData() async {

    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

    GetProfileRequest getProfileRequest = GetProfileRequest(
      userId: userId.toString(),
    );

    final response = await Repository.hitPostGetProfileApi(getProfileRequest);

    // if (response != null && response.status == 200) {
    //
    // } else {
    //   DisplaySnackbar().errorSnackBar(
    //     title: "Failed",
    //     msg: response?.msg ?? "An error occurred",
    //   );
    // }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}
