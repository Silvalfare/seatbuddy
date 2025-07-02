
import 'package:http/http.dart' as http;
import 'package:seatbuddy/api/endpoint.dart';
import 'package:seatbuddy/model/auth/login/login_error_params.dart';
import 'package:seatbuddy/model/auth/login/login_response.dart';
import 'package:seatbuddy/model/auth/register/register_error_params.dart';
import 'package:seatbuddy/model/auth/register/register_response.dart';
import 'package:seatbuddy/model/profile/no_token_response.dart';
import 'package:seatbuddy/model/profile/profile_response.dart';
import 'package:seatbuddy/services/preference.dart';

class UserService {
  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Endpoint.register),
      headers: {"Accept": "application/json"},
      body: {"name": name, "email": email, "password": password},
    );
    if (response.statusCode == 200) {
      return registerResponseFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registerErrorParamsResponseFromJson(response.body).toJson();
    } else {
      throw Exception("Gagal mendaftarkan pengguna: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Endpoint.login),
      headers: {"Accept": "application/json"},
      body: {"email": email, "password": password},
    );
    if (response.statusCode == 200) {
      final data = loginResponseFromJson(response.body);
      if (data.data?.token != null) {
        await SharedPreference.saveAuthToken(data.data!.token!);
      }
      return data.toJson();
    } else if (response.statusCode == 422) {
      return loginErrorParamsResponseFromJson(response.body).toJson();
    } else {
      return {'errors': true, 'message': "Login gagal: ${response.statusCode}"};
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    String? token = await SharedPreference.getAuthToken();
    final response = await http.get(
      Uri.parse(Endpoint.profile),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      print(profileResponseFromJson(response.body).toJson());
      return profileResponseFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return noTokenProfileResponseFromJson(response.body).toJson();
    } else {
      throw Exception("Gagal mengambil data pengguna: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> updateUser({
    required String name,
    // required String email,
  }) async {
    String? token = await SharedPreference.getAuthToken();
    final response = await http.put(
      Uri.parse(Endpoint.profile),
      headers: {"Accept": "application.json", "Authorization": "Bearer $token"},
      body: {
        "name": name,
        //  "email": email
      },
    );

    if (response.statusCode == 200) {
      return profileResponseFromJson(response.body).toJson();
    } else {
      throw Exception("Gagal update profile: ${response.statusCode}");
    }
  }
}
