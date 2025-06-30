import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seatbuddy/api/endpoint.dart';
import 'package:seatbuddy/model/menu/menu_model.dart';
import 'package:seatbuddy/services/preference.dart';

class MenuApi {
  static Future<List<MenuModel>> fetchMenus() async {
    final token = await SharedPreference.getAuthToken();
    final response = await http.get(
      Uri.parse('${Endpoint.menus}'),
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
}
