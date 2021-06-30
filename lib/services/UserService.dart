import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:task_and_earn/models/CheckToken.dart';
import 'package:task_and_earn/models/Login_Model.dart';
import 'package:task_and_earn/models/SignUp_Model.dart';
import 'package:task_and_earn/models/User.dart';
import 'ApiManager.dart';

class UserService {
  Future<String> onGetAppVersion () async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<LoginResponseModel> onLogin(
      LoginRequestModel loginRequestModel) async {
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
    } catch(e) {
      throw Exception("Exception $e");
    }
  }

  Future<UserResponse> getUserDetails(String token, dynamic id) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response =
        await http.get(Uri.parse(ApiManager.baseUrl + "professionals/user-details/$id"), headers: headers);
      // print("response.body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 400) {
        return UserResponse.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException {
      throw Exception("Timeout");
    } catch(e) {
      throw Exception("Exception $e");
    }
  }

  Future<ForgotPasswordResponse> sendMail(ForgotPasswordRequest forgotPasswordRequest) async {
    try {
      final response =
        await http.post(Uri.parse(ApiManager.baseUrl + "auth/forgotpassword/"), body: forgotPasswordRequest.toJson());
      // print("response.body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 400) {
        return ForgotPasswordResponse.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException {
      throw Exception("Timeout");
    } catch(e) {
      throw Exception("Exception $e");
    }
  }
}
