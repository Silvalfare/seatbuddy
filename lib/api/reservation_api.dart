import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seatbuddy/api/endpoint.dart';
import 'package:seatbuddy/model/reservation/reservation_list.dart';
import 'package:seatbuddy/services/preference.dart';

class ReservationApi {
  Future<bool> createReservation({
    required DateTime reservedAt,
    required int guestCount,
    String? notes,
  }) async {
    final String? token = await SharedPreference.getAuthToken();

    if (token == null) {
      print('Token is null');
      return false;
    }

    final response = await http.post(
      Uri.parse(Endpoint.reservations),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: {
        "reserved_at": reservedAt.toString(),
        "guest_count": guestCount.toString(),
        "notes": notes ?? "",
      },
    );

    print(
      "CREATE RESERVATION RESPONSE: ${response.statusCode} => ${response.body}",
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getReservations() async {
    final String? token = await SharedPreference.getAuthToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse(Endpoint.reservations),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    print(
      "GET RESERVATIONS RESPONSE: ${response.statusCode} => ${response.body}",
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil daftar reservasi');
    }
  }

  Future<bool> cancelReservation(int id) async {
    final String? token = await SharedPreference.getAuthToken();

    if (token == null) {
      print("Token not found");
      return false;
    }

    final response = await http.delete(
      Uri.parse("${Endpoint.reservations}/$id"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    print(
      "CANCEL RESERVATION RESPONSE: ${response.statusCode} => ${response.body}",
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
