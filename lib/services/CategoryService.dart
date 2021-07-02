import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_and_earn/models/PopularService.dart';
import 'ApiManager.dart';
import '../models/post_a_job/Category.dart';

class CategoryService {
  Future<CategoryResponse> onGetCategories(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response =
        await http.get(Uri.parse(ApiManager.baseUrl + "category"), headers: headers);
      // print("cs onGetCategories ${response.body}");

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
}