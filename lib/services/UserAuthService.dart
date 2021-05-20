import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:task_and_earn/models/CheckToken.dart';
import 'package:task_and_earn/models/Login_Model.dart';
import 'package:task_and_earn/models/SignUp_Model.dart';
import 'ApiManager.dart';

class UserAuthService {
  Future<String> onGetAppVersion () async {
    String version = "";
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
      return version;
    });
    return version;
  }

  Future<LoginResponseModel> onLogin(
      LoginRequestModel loginRequestModel) async {
    // print("uas loginRequestModel ${loginRequestModel.toJson()}");
    final response = await http.post(Uri.parse(ApiManager.baseUrl + "users/login"),
        body: loginRequestModel.toJson());
    // print("response.body: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<SignUpResponseModel> onSignUp(
      SignUpRequestModel signUpRequestModel) async {
    // print("uas signUpRequestModel ${signUpRequestModel.toJson()}");
    final response = await http.post(Uri.parse(ApiManager.baseUrl + "user/registration"),
        body: signUpRequestModel.toJson());
    // print("response.body: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return SignUpResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<CheckTokenResponse> onCheckToken(String token) async {
    try {
      print("ApiManager.baseUrl ${ApiManager.baseUrl}");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response =
          await http.get(Uri.parse(ApiManager.baseUrl + "auth/check-token"), headers: headers);
      print("as onCheckToken response: ${response.statusCode} ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 400) {
        return CheckTokenResponse.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException {
      throw Exception("Timeout");
    }
  }
}
