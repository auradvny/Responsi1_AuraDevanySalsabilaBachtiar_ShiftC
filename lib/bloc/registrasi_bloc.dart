import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pariwisata/helpers/api_url.dart';
import 'package:pariwisata/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;

    // Create the request body
    var body = json.encode({
      "nama": nama,
      "email": email,
      "password": password,
    });

    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: body,
    );

    // Check for successful response
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return Registrasi.fromJson(jsonObj); // Parse the response
    } else {
      // Handle error
      throw Exception("Gagal melakukan registrasi");
    }
  }
}
