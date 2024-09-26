import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_assets.dart';
import '../utils/dialog/circular_progress_dialog.dart';
import '../utils/dialog/ok_dialog.dart';
import '../utils/my_internet_connection.dart';

import 'package:http/http.dart' as http;

class ApiClient {
  CircularProgressDialog progressDialog = CircularProgressDialog();

  Future<Map<String, dynamic>?> requestPost({required String url, required String parameters, context}) async {
    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestData : ${parameters.toString()}");
    // log("accessToken : $accessToken");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try {
        Uri uri = Uri.parse(url);

        final results = await http.post(
          uri,
          body: parameters,
          headers: {"Content-Type": "application/json"},
        );
        //print(results);

        if (results.statusCode == 200 || results.statusCode == 401) {
          final jsonObject = json.decode(results.body);
          log("ResponseData : ${results.body.toString()}");

          progressDialog.close();
          return jsonObject;
        } else {
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "Failed",
              descriptions:"Something went wrong",
              img:errorIcon,
            ),
          );
          return null;
        }
      } catch (exception) {
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "Failed",
            descriptions:"Something went wrong",
            img:errorIcon,
          ),
        );
        return null;
      }
    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "No Internet",
          descriptions: "Please check Internet Connection",
          img:noInternetIcon,
        ),
      );
      return null;
    }
  }

}

