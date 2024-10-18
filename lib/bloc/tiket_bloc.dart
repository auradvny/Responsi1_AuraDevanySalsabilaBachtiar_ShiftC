import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pariwisata/helpers/api.dart';
import 'package:pariwisata/helpers/api_url.dart';
import 'package:pariwisata/model/hargatiket.dart'; // Ganti model produk dengan harga tiket

class HargaTiketBloc {
  static Future<List<HargaTiket>> getHargaTiket() async {
    String apiUrl =
        ApiUrl.listHargaTiket; // Sesuaikan dengan endpoint harga tiket
    var response = await Api().get(apiUrl);

    if (response.statusCode != 200) {
      throw Exception("Failed to load harga tiket");
    }

    var jsonObj = json.decode(response.body);
    List<dynamic> listHargaTiket = (jsonObj as Map<String, dynamic>)['data'];
    List<HargaTiket> hargaTikets = [];

    for (var item in listHargaTiket) {
      hargaTikets
          .add(HargaTiket.fromJson(item)); // Ganti Produk dengan HargaTiket
    }
    return hargaTikets;
  }

  static Future<bool> addHargaTiket({required HargaTiket hargaTiket}) async {
    String apiUrl = ApiUrl
        .createHargaTiket; // Sesuaikan dengan endpoint untuk menambahkan harga tiket
    var body = {
      "event": hargaTiket.event, // Ganti nama atribut sesuai model HargaTiket
      "price":
          hargaTiket.price, // Pastikan ini sesuai dengan tipe data di server
      "seat": hargaTiket.seat // Ganti nama atribut sesuai model HargaTiket
    };

    var response = await Api().post(apiUrl, body);

    if (response.statusCode != 200) {
      throw Exception("Failed to add harga tiket");
    }

    var jsonObj = json.decode(response.body);
    return jsonObj['status'] ?? false; // Pastikan mengembalikan boolean
  }

  static Future<bool> updateHargaTiket({required HargaTiket hargaTiket}) async {
    String apiUrl =
        ApiUrl.updateHargaTiket(hargaTiket.id!); // Ganti dengan ID yang sesuai
    print(apiUrl);

    var body = {
      "event": hargaTiket.event, // Ganti nama atribut sesuai model HargaTiket
      "price":
          hargaTiket.price, // Pastikan ini sesuai dengan tipe data di server
      "seat": hargaTiket.seat // Ganti nama atribut sesuai model HargaTiket
    };

    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));

    if (response.statusCode != 200) {
      throw Exception("Failed to update harga tiket");
    }

    var jsonObj = json.decode(response.body);
    return jsonObj['status'] ?? false; // Pastikan mengembalikan boolean
  }

  static Future<bool> deleteHargaTiket({required int id}) async {
    String apiUrl =
        ApiUrl.deleteHargaTiket(id); // Ganti dengan endpoint hapus harga tiket
    var response = await Api().delete(apiUrl);

    if (response.statusCode != 200) {
      throw Exception("Failed to delete harga tiket");
    }

    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'] ??
        false; // Pastikan mengembalikan boolean
  }
}
