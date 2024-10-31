import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/screens/Home_Screens/Listing_page.dart';
import 'package:rate_my_portfolio/screens/StripeWebScreens/CustomWebView.dart';
import 'package:rate_my_portfolio/screens/starting_screens/SignIn_screen.dart';
import '../models/request/Aboutmyportfoliorequest.dart';
import '../models/request/LoginSignupGoogleFaceBook_Request.dart';
import '../models/request/deleteAccountRequest.dart';
import '../models/request/post_SignUp_request.dart';
import '../models/request/post_conformpassword_request.dart';
import '../models/request/post_getprofile_request.dart';
import '../models/request/post_getstartedBroker_request.dart';
import '../models/request/post_signIn_request.dart';
import '../models/responce/LoginSignupGoogleFaceBook_Responce.dart';
import '../models/responce/get_signIn_responce.dart';
import '../models/responce/send_OTP_responce.dart';
import '../models/request/send_OTP_request.dart';
import '../network/repositary.dart';
import '../resources/my_assets.dart';
import '../screens/starting_screens/GetStarted_Screen.dart';
import '../screens/starting_screens/LoginEnterOTP.dart';
import '../screens/starting_screens/ProfileScreen.dart';
import '../screens/starting_screens/SignUp_Screen.dart';
import '../utils/dialog/circular_progress_dialog.dart';
import '../utils/dialog/ok_dialog.dart';
import '../utils/local_database/key_constants.dart';
import '../utils/local_database/shdf.dart';
import '../utils/widgets/TextFeild.dart';
import '../utils/widgets/TextFormFeild.dart';
import '../utils/widgets/my_button.dart';
import '../utils/widgets/snackbar.dart';

class LoginController extends GetxController {
  TextEditingController CreateAccemailController = TextEditingController();
  TextEditingController CreateAccUserNameController = TextEditingController();
  TextEditingController CreateAccPhoneNoController = TextEditingController();
  TextEditingController CreateAccPasswordController = TextEditingController();

  TextEditingController forgotemailController = TextEditingController();
  TextEditingController NewpasswordController = TextEditingController();
  TextEditingController NewconfirmPasswordController = TextEditingController();
  TextEditingController GetStartedAngleTextController = TextEditingController();
  TextEditingController LoginWithGoogleFacebookController = TextEditingController();
  TextEditingController listinngDetailsAddReview = TextEditingController();

  TextEditingController aboutMyPortfolio = TextEditingController();
  TextEditingController MyprofileUserNameController = TextEditingController();
  TextEditingController MyprofileEmailController = TextEditingController();
  TextEditingController MyprofilePhoneNoController = TextEditingController();
  // Contact Us Page
  TextEditingController ContactUsNameController = TextEditingController();
  TextEditingController ContactUsEmailadressController = TextEditingController();
  TextEditingController ContactUsPhoneNoController = TextEditingController();
  TextEditingController ContactUsCommentController = TextEditingController();

  TextEditingController brokerNameCtr = TextEditingController();
  TextEditingController clientIdCtr = TextEditingController();
  TextEditingController pinCtr = TextEditingController();
  TextEditingController totpCtr = TextEditingController();

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
//   var lastSynced = '20th July, 2024'.obs;
//   void syncPortfolio() {
//     lastSynced.value = "20th September, 2024";
//   }

  //end
  @override
  void onInit() {
    super.onInit();
  }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  void DontAskAgainSkip() {}
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

  void goToSignUpscreen() {
    Get.to(() => SignUpPage());
  }

// Login with Google
  Future<UserCredential?> signInWithGoogle() async {
    // log(" google signin");
    CircularProgressDialog progressDialog = CircularProgressDialog();
    try {
      progressDialog.showProgressDialog(context: Get.context!);
      GoogleSignIn _googleSignIn = GoogleSignIn();
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      progressDialog.close(Get.context!);
      if(user != null){
        showCustomDialog(user);
      }
      debugPrint(
          "print the users email, phoneNumber and Nam :: ${user!.email}, ${user.phoneNumber ?? ""}, ${user.displayName} ");
      // getVerif();
      return userCredential;
    } catch (error) {
      progressDialog.close(Get.context!);
      debugPrint('Error signing in with Google: $error');
      return null;
    }
  }
  void showCustomDialog(User user) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            title:Center(child: Text("Login with Google",style: TextStyle(color:MyColor.matricsgreyColor,fontSize: 14))),
            backgroundColor:MyColor.white,
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LabeledTextField(label:"Username",labelColor: MyColor.matricsgreyColor),
                  TextFromField(
                    controller:LoginWithGoogleFacebookController,
                    prefix: Icons.perm_identity,
                    hintText: "Username",
                    hintTextColor:MyColor.HintColor,
                    obscureText: false,
                    borderColor: MyColor.TextFormBorderGreyColor,
                  ),
                  SizedBox(height: 16),
                  myButton(
                    context: context,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if(LoginWithGoogleFacebookController.text.trim().isEmpty){
                        DisplaySnackbar().errorSnackBar(title: "Failed", msg:"Please enter username");
                      }else {
                        LoginSignupWithGoogleFaceBook("google", user!.email!, user!.phoneNumber ?? "", LoginWithGoogleFacebookController.text.trim());
                      }
                    },
                    btnName: 'Continue',
                  ),
                ]));
      },
    );
  }

  Future<void> signInUser() async {
    try {
      String token = "";

      SignInRequest signInRequest = SignInRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firebaseToken: token,
      );

      log("RequestData: ${json.encode(signInRequest.toJson())}");

      final results = await Repository.hitSignInApi(signInRequest,Get.context!);

      if (results != null) {
        SignInResponce responseModel = results;

        if (responseModel.status == 200) {
          log("Sign-In Successful: ${responseModel.payload}");

          await SHDFClass.saveIntValue(KeyConstants.userId, responseModel.payload.userId!);
          await SHDFClass.saveStringValue(KeyConstants.accesToken, responseModel.payload.apiToken!.access);
          print("acces token print${responseModel.payload.apiToken!.access}");
          await SHDFClass.saveStringValue(KeyConstants.email, responseModel.payload.email!);
          await SHDFClass.saveStringValue(KeyConstants.phone, responseModel.payload.mobile!);
          await SHDFClass.saveStringValue(KeyConstants.userName, responseModel.payload.name!);
          await SHDFClass.saveStringValue(KeyConstants.profileImg, responseModel.payload.profileImage!);
          await SHDFClass.saveStringValue(KeyConstants.clientId, responseModel.payload.clientId!);
          await SHDFClass.saveStringValue(KeyConstants.pin, responseModel.payload.pin!);
          await SHDFClass.saveStringValue(KeyConstants.totp, responseModel.payload.totp!);

          Get.offAll(() => GetStartedScreen(""));
        } else {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
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

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  void ResetpasswordclearFields() {
    NewpasswordController.clear();
    NewconfirmPasswordController.clear();
  }

  void clearSignUpFeilds() {
    CreateAccemailController.clear();
    CreateAccPasswordController.clear();
    CreateAccUserNameController.clear();
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

      final results = await Repository.hitSendOTPApi(sendOtpRequest,Get.context!);

      if (results != null) {
        SendOtpResponce responseModel = results;

        print("print result ${responseModel.toJson()}");

        if (responseModel.status == 200) {
          textGetOtp = responseModel.otp;
          print("OTP Request Successful: ${textGetOtp}");
          if (isNormalFlow) {
            if (type == 'signup') {
              Get.to(() => LoginEnterOTP(""));
            } else if (type == 'forget_pwd') {
              print("forget_pwd click");
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
      await SHDFClass.saveStringValue(KeyConstants.userName, response.payload.name);
      await SHDFClass.saveStringValue(KeyConstants.profileImg, response.payload.profileImage);
      await SHDFClass.saveStringValue(KeyConstants.email, response.payload.email);
      await SHDFClass.saveStringValue(KeyConstants.phone, response.payload.mobile);
      await SHDFClass.saveStringValue(KeyConstants.accesToken, response.payload.apiToken.access);
      Get.offAll(() => GetStartedScreen(""));
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

    final response = await Repository.hitConformPasswordApi(ConfromPassowrdRequests,Get.context!);

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

  Future<void> getStartedBrokerConnectNow(String from) async {
    if (clientIdCtr.text.isEmpty) {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: "Please enter client ID",
      );
      return;
    }
    // else if (pinCtr.text.isEmpty) {
    //   DisplaySnackbar().errorSnackBar(
    //     title: "Failed",
    //     msg: "Please enter PIN",
    //   );
    //   return;
    // }
    // else if (totpCtr.text.isEmpty) {
    //   DisplaySnackbar().errorSnackBar(
    //     title: "Failed",
    //     msg: "Please enter TOTP",
    //   );
    //   return;
    // }
    else {
      int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

      // GetStartedBrokerRequest getStartedBrokerRequest = GetStartedBrokerRequest(
      //   userId: userId.toString(),
      //   brokerName: "ANGLEONE",
      //   clientId: clientIdCtr.text,
      //   pin: pinCtr.text,
      //   totp: totpCtr.text,
      // );

      var param ={
        "user_id": userId,
        "client_id":clientIdCtr.text,
      };
      isLoading.value = true;
      final response = await Repository.connectNow(param,Get.context!);

      if (response != null && response.status == 200) {
        // DisplaySnackbar().successSnackBar(
        //   title: "Success",
        //   msg: response.msg!,
        // );
        await SHDFClass.saveStringValue(KeyConstants.clientId, clientIdCtr.text);
        // await SHDFClass.saveStringValue(KeyConstants.pin, pinCtr.text);
        // await SHDFClass.saveStringValue(KeyConstants.totp, totpCtr.text);
        // launchUrl(Uri.parse(response.url!));
        Get.to(()=> CustomWebView(response.url.toString()))!.then((value) {
          if (from == "profile") {
            Get.back();
          } else {
            Get.offAll(() => PortfolioListingPage());
          }
        });
      } else {
        DisplaySnackbar().errorSnackBar(
          title: "Failed",
          msg: response?.msg ?? "An error occurred",
        );
      }
    }
  }

  Future<void> LoginSignupWithGoogleFaceBook(String type, String email,String mobile, String username,) async {
    String login_type;
    if (type == 'nrml') {
       login_type = "nrml";
    } else if (type == 'google') {
       login_type = "google";
    }else if (type == 'facebook') {
       login_type = "facebook" ;
    } else {
      throw Exception("Invalid type provided");
    }

    LoginSignupGoogleFaceBook_Request loginSignupGoogleFaceBook_Request = LoginSignupGoogleFaceBook_Request(
      username: username,
      loginType: login_type,
      email: email,
      firebaseToken: "",
      mobile:mobile ,
      password:"",
    );

    log("RequestData: ${json.encode(loginSignupGoogleFaceBook_Request.toJson())}");

    final results = await Repository.HitLoginSignupGoogleFaceBookApi(loginSignupGoogleFaceBook_Request,Get.context!);

    if (results != null) {
      LoginSignupGoogleFaceBook_Responce responseModel = results;

      print("print result ${responseModel.toJson()}");

      if (responseModel.status == 200) {
        print("print result ${responseModel.msg.toString()}");

        await SHDFClass.saveIntValue(KeyConstants.userId, responseModel.payload!.userId!);
        await SHDFClass.saveStringValue(KeyConstants.userName, responseModel.payload!.name!);
        await SHDFClass.saveStringValue(KeyConstants.email, responseModel.payload!.email!);
        await SHDFClass.saveStringValue(KeyConstants.phone, responseModel.payload!.mobile!);
        await SHDFClass.saveStringValue(KeyConstants.firebaseToken, responseModel.payload!.firebaseToken!);
        await SHDFClass.saveStringValue(KeyConstants.profileImg, responseModel.payload!.profileImage!);
        await SHDFClass.saveStringValue(KeyConstants.clientId, responseModel.payload!.clientId!);
        await SHDFClass.saveStringValue(KeyConstants.createdDate, responseModel.payload!.createdDate!);
        await SHDFClass.saveStringValue(KeyConstants.pin, responseModel.payload!.pin!);
        await SHDFClass.saveStringValue(KeyConstants.totp, responseModel.payload!.totp!);
        await SHDFClass.saveStringValue(KeyConstants.selectedBroker, responseModel.payload!.selectedBroker!);
        await SHDFClass.saveStringValue(KeyConstants.accesToken, responseModel.payload!.apiToken!.access!);
        Get.offAll(() => GetStartedScreen(""));
        LoginWithGoogleFacebookController.clear();
      } else {
        LoginWithGoogleFacebookController.clear();
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
  }

   loadProfileData() async {
    MyprofileUserNameController.text = await SHDFClass.readStringValue(KeyConstants.userName, "") ?? "";
    MyprofileEmailController.text = await SHDFClass.readStringValue(KeyConstants.email, "") ?? "";
    MyprofilePhoneNoController.text = await SHDFClass.readStringValue(KeyConstants.phone, "") ?? "";
  }

  Future<void> UpdateprofileAboutMyPortfolio()  async {
   int UserId = await SHDFClass.readIntValue(KeyConstants.userId, 0) ?? 0;

  Aboutmyportfoliorequest aboutmyportfoliorequest = Aboutmyportfoliorequest(
     userId: UserId ,
    aboutPortfolio: aboutMyPortfolio.text.trim()
    );
    final response = await Repository.updateAboutMyPortfolio(aboutmyportfoliorequest,Get.context!);
    if (response != null && response.status == 200) {
      print("data:-"+ aboutMyPortfolio.text.toString());
      DisplaySnackbar().successSnackBar(
        title: "Success",
        msg: "Your portfolio info added successfully",
      );
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

  Future<void> deleteUserAccount() async {
   int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0) ?? 0;

   deleteAccountRequest deleteuserAccountRequest = deleteAccountRequest(
     userId: userId
    );
    final response = await Repository.deleteAccount(deleteuserAccountRequest,Get.context!);
    if (response != null && response.status == 200) {
      Get.offAll(() => SignInScreen());
      DisplaySnackbar().successSnackBar(
        title: "Success",
        msg: "Account deleted successfully!",
      );
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
