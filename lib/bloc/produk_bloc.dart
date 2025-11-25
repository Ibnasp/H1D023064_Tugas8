import 'dart:convert';
import 'package:tokokita/model/produk.dart';
import 'package:http/http.dart' as http;

class ProdukBloc {
  static const String baseUrl = 'http://localhost/toko_api/public';

  static Future<bool> deleteProduk({required int id}) async {
    final url = Uri.parse('$baseUrl/produk/$id');
    final response = await http.delete(url);

    return response.statusCode == 200;
  }
}
