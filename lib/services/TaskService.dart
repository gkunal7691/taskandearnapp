import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/models/post_a_job/PostAJob.dart';
import 'package:task_and_earn/models/post_a_job/Task.dart';
import 'ApiManager.dart';

class TaskService {
  Future<TaskResponse> getAllTasks(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(Uri.parse(ApiManager.baseUrl + "task"), headers: headers);
      // print("ts response ${response.body}");

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

  Future<TaskResponse> getUserPostedTasks(String token) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(Uri.parse(ApiManager.baseUrl + "task/mytasks/posted"), headers: headers);
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

  Future<PostAJobResponse> onPostAJob(TaskRequest taskRequest) async {
    try {
      var headers = {'Content-type': 'application/json'};
      var bodyData = json.encode(taskRequest.toJson());
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
}