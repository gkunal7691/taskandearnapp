import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_and_earn/models/PopularService.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'ApiManager.dart';
import '../models/post_a_job/Category.dart';
import '../models/post_a_job/PostAJob.dart';
import '../models/post_a_job/SubCategory.dart';
import '../models/post_a_job/Task.dart';

class CategoryService {
  Future<CategoryResponse> onGetCategories(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      // print("ApiManager.baseUrl ${ApiManager.baseUrl}");
      final response =
      await http.get(Uri.parse(ApiManager.baseUrl + "category"), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 400) {
        return CategoryResponse.fromJson(json.decode(response.body));
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
    } on TimeoutException {
      throw Exception("Timeout");
    } catch(e) {
      throw Exception("Exception $e");
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
    } on TimeoutException {
      throw Exception("Timeout");
    } catch(e) {
      throw Exception("Exception $e");
    }
  }

  Future<PopularServiceResponse> getPopularServices(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(Uri.parse(ApiManager.baseUrl + "category/popular-service"), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 400) {
        return PopularServiceResponse.fromJson(json.decode(response.body));
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

  Future<TaskResponse> getTasks(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(Uri.parse(ApiManager.baseUrl + "task"), headers: headers);
      // print("cs response ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 400) {
        return TaskResponse.fromJson(json.decode(response.body));
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