import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pariwisata/helpers/api.dart';
import 'package:pariwisata/helpers/api_url.dart';
import 'package:pariwisata/model/login.dart';

class LoginBloc {
  static Future<Login> login(
      {required String email, required String password}) async {
    String apiUrl = ApiUrl.login;
    var body =
        json.encode({"email": email, "password": password}); // Encode to JSON

    try {
      // Make the API request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'
        }, // Set header content type
        body: body, // Pass the encoded JSON string here
      );

      // Check if the response was successful
      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        return Login.fromJson(jsonObj);
      } else {
        // Handle errors based on status code
        var errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      // Handle network errors or parsing errors
      throw Exception('Failed to login: $e');
    }
  }
}
