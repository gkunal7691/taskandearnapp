import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_and_earn/models/Category.dart';
import 'package:task_and_earn/models/PostAJob.dart';
import 'package:task_and_earn/models/SubCategory.dart';
import 'package:task_and_earn/models/Task.dart';
import 'ApiManager.dart';

class CategoryService {
  Future<CategoryResponse> onGetCategories(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print("ApiManager.baseUrl ${ApiManager.baseUrl}");
      final response =
      await http.get(Uri.parse(ApiManager.baseUrl + "category"), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 400) {
        return CategoryResponse.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException catch (e) {
      throw Exception("Timeout");
    }
  }

  Future<SubCategoryResponse> onGetSubCategories(String token, int categoryId) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(Uri.parse(ApiManager.baseUrl + "subcategory/" + categoryId.toString()), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 400) {
        return SubCategoryResponse.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException catch (e) {
      throw Exception("Timeout");
    }
  }

  Future<PostAJobResponse> onPostAJob(TaskRequest taskRequest) async {
    // print("cs taskRequest ${taskRequest.toJson()}");
    try {
      var headers = {'Content-type': 'application/json'};
      var bodyData = json.encode(taskRequest.toJson());
      // print("cs onPostAJob bodyData $bodyData");
      final response = await http.post(Uri.parse(ApiManager.baseUrl + "task"), headers: headers, body: bodyData);
      // print("cs response ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 400) {
        return PostAJobResponse.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException catch (e) {
      throw Exception("Timeout");
    } catch(e) {
      throw Exception("cs Exception $e");
    }
  }
}