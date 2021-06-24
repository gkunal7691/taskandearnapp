import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_and_earn/models/become_a_earner/Professional.dart';
import 'ApiManager.dart';

class ProfessionalService {
  Future<ProfessionalResponse> onCreateProfessional(ProfessionalRequest professionalRequest) async {
    // print("ps professionalRequest ${professionalRequest.toJson()}");
    try {
      var headers = {'Content-type': 'application/json'};
      var bodyData = json.encode(professionalRequest.toJson());
      // print("ps onCreateProfessional bodyData $bodyData");
      final response = await http.post(Uri.parse(ApiManager.baseUrl + "professionals"), headers: headers, body: bodyData);
      // print("cs response ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 400) {
        return ProfessionalResponse.fromJson(json.decode(response.body));
      } else {
        throw new Exception("Failed to load data");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException {
      throw Exception("Timeout");
    } catch(e) {
      throw Exception("cs Exception $e");
    }
  }
}