import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seatbuddy/api/endpoint.dart';
import 'package:seatbuddy/model/menu/menu_model.dart';
import 'package:seatbuddy/services/preference.dart';

class MenuApi {
  static Future<bool> createMenu({
    required String name,
    required String description,
    required int price,
    required String imageUrl,
  }) async {
    final token = await SharedPreference.getAuthToken();

    final response = await http.post(
      Uri.parse(Endpoint.menus),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'name': name,
        'description': description,
        'price': price.toString(),
        'image_url': imageUrl,
      },
    );

    return response.statusCode == 200;
  }

  static Future<List<MenuModel>> fetchMenus() async {
    final token = await SharedPreference.getAuthToken();
    final response = await http.get(
      Uri.parse(Endpoint.menus),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      if (decoded['data'] is! List) throw Exception('Format JSON tidak sesuai');
      final List jsonList = decoded['data'];
      return jsonList.map((e) => MenuModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data menu');
    }
  }

  static Future<MenuModel> fetchMenuById(int id) async {
    final token = await SharedPreference.getAuthToken();
    final response = await http.get(
      Uri.parse('${Endpoint.menus}/$id'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return MenuModel.fromJson(data);
    } else {
      throw Exception('Failed to load menu');
    }
  }

  static Future<bool> deleteMenu(int id) async {
    final token = await SharedPreference.getAuthToken();
    final response = await http.delete(
      Uri.parse('${Endpoint.menus}/$id'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
