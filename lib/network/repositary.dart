import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/request/post_SignUp_request.dart';
import '../models/request/post_conformpassword_request.dart';
import '../models/request/post_signIn_request.dart';
import '../models/request/send_OTP_request.dart';
import '../models/responce/get_SignUp_responce.dart';
import '../models/responce/get_signIn_responce.dart';
import '../models/responce/post_conformpassword_responce.dart';
import '../models/responce/send_OTP_responce.dart';
import '../utils/dialog/ErrorDialog.dart';
import 'api_client.dart';
import 'api_constant.dart';

class Repository {

  static Future<SignInResponce?> hitSignInApi(SignInRequest request) async {
    SignInResponce? responseModel;
    final results = await ApiClient().requestPost(
      url: ApiConstant.postSignInApi,
      parameters: json.encode(request.toJson()),
    );
    if (results!['status'] == 200) {
      print("results results :--- ${results['status']}");

      responseModel = SignInResponce.fromJson(results);
    } else if (results['status'] == 403) {
      Get.dialog(ErrorDialog(msg: "${results['msg']}"));
    }
    return responseModel;
  }

  static Future<SignUpResponce?> hitSignUpApi(SignUpRequest request) async {
    SignUpResponce? responseModel;
    final results = await ApiClient().requestPost(
      url: ApiConstant.postSignUpApi,
      parameters: json.encode(request.toJson()),
    );
    if (results!['status'] == 200) {
      print("results results :--- ${results['status']}");
      responseModel = SignUpResponce.fromJson(results);
    } else if (results['status'] == 403) {
      Get.dialog(ErrorDialog(msg: "${results['msg']}"));
    }
    return responseModel;
  }

  static Future<SendOtpResponce?> hitSendOTPApi(SendOtpRequest request) async {
    SendOtpResponce? responseModel;
    final results = await ApiClient().requestPost(
      url: ApiConstant.postSendOTPApi,
      parameters: json.encode(request.toJson()),
    );
    if (results!['status'] == 200) {
      print("results results :--- ${results['status']}");
      responseModel = SendOtpResponce.fromJson(results);
    } else if (results['status'] == 403) {
      Get.dialog(ErrorDialog(msg: "${results['msg']}"));

    }
    return responseModel;
  }

  static Future<ConfromPassowrdResponce?> hitConformPasswordApi(ConfromPassowrdRequest request) async {
    ConfromPassowrdResponce? responseModel;
    final results = await ApiClient().requestPost(
      url: ApiConstant.postConformPasswordApi,
      parameters: json.encode(request.toJson()),
    );
    if (results!['status'] == 200) {
      print("results results :--- ${results['status']}");
      responseModel = ConfromPassowrdResponce.fromJson(results);
    } else if (results['status'] == 403) {
      Get.dialog(ErrorDialog(msg: "${results['msg']}"));

    }
    return responseModel;
  }

  // static Future<List<SessionModel>> hitSessionApi() async {
  //   print("hitSessionApi RUnning ...");
  //   final results = await ApiClient().requestGet(
  //     url: ApiConstants.getSessionId,
  //   );
  //   print("hitSessionApi API result: $results");
  //
  //   List<SessionModel> sessions = [];
  //   if (results != null &&
  //       results['status'] == 200 &&
  //       results['session'] != null) {
  //     sessions = List<SessionModel>.from(
  //         results['session'].map((session) => SessionModel.fromJson(session)));
  //   }
  //   return sessions;
  // }
  //
  // static Future<TeacherDataRespModel> hitGetTeacherDataApi(String tCode) async {
  //   late TeacherDataRespModel responseModel;
  //   print("hitGetTeacherDataApi RUnning ...");
  //   final results = await ApiClient().requestPost(
  //     url: ApiConstants.getTeacherDataApi,
  //     requestBody: json.encode({"t_code": tCode}),
  //   );
  //   print("hitSessionApi API result: $results");
  //   if (results != null) {
  //     responseModel = TeacherDataRespModel.fromJson(results);
  //     // responseModel = DashboardModel.fromJson(results);
  //   }
  //   return responseModel;
  // }

  // static Future<DashboardModel> hitDashBoardApi(
  //     DashBoardRequest request) async {
  //   late DashboardModel responseModel;
  //   final results = await ApiClient().requestPost(
  //     url: ApiConstants.getDashboardData,
  //     requestBody: json.encode(request),
  //   );
  //   print('printing in hitDashBoardApi${jsonEncode(results)}');
  //   if (results != null) {
  //     responseModel = DashboardModel.fromJson(results);
  //     // responseModel = DashboardModel.fromJson(results);
  //   }
  //   return responseModel;
  // }

  // static Future<DashboardModelHarshad> hitDashBoardApiHarshad(
  //     DashBoardRequest request) async {
  //   late DashboardModelHarshad responseModel;
  //   final results = await ApiClient().requestPost(
  //     url: ApiConstants.getDashboardData,
  //     requestBody: json.encode(request),
  //   );
  //
  //   if (results != null) {
  //     responseModel = DashboardModelHarshad.fromJson(results);
  //     // responseModel = DashboardModel.fromJson(results);
  //   }
  //   return responseModel;
  // }

  // static Future<Map<String, List<dynamic>>?> hitSubListApi() async {
  //   print("hitSubListApi Running ...");
  //   final response = await ApiClient().requestGet(
  //     url: ApiConstants.getClassSubjectList,
  //   );
  //
  //   if (response == null) {
  //     print("Failed to fetch data from API");
  //     return null;
  //   }
  //
  //   try {
  //     final results = response;
  //     print("hitSubListApi API result: $results");
  //
  //     if (results['class'] == null ||
  //         results['subject'] == null ||
  //         results['section_list'] == null) {
  //       print("One of the lists is null");
  //       return null;
  //     }
  //
  //     List<ClassModel> classList = List<ClassModel>.from(
  //         results['class'].map((data) => ClassModel.fromJson(data)));
  //     print("Class data store success");
  //
  //     List<SubjectModel> subjectList = List<SubjectModel>.from(
  //         results['subject'].map((data) => SubjectModel.fromJson(data)));
  //     print("Subject data store success");
  //
  //     List<SectionModel> sectionList = List<SectionModel>.from(
  //         results['section_list'].map((data) => SectionModel.fromJson(data)));
  //     print("Section data store success");
  //
  //     return {
  //       'classList': classList,
  //       'subjectList': subjectList,
  //       'sectionList': sectionList,
  //     };
  //   } catch (e) {
  //     print("Error parsing response: $e");
  //     return null;
  //   }
  // }

  // static Future<Map?> hitDeletePostApi(int id) async {
  //   try {
  //     final results = await ApiClient().requestPostNoLoader(
  //       // changed to NoLoader(Harshad >>> 22/7 >> 10:22)
  //       url: ApiConstants.deletePost,
  //       requestBody: jsonEncode({"post_id": id}),
  //     );
  //
  //     print('Post deleted successfully: $results');
  //     return results;
  //   } catch (e) {
  //     print('Failed to delete post: $e');
  //     throw Exception('Failed to delete post: $e');
  //   }
  // }
}