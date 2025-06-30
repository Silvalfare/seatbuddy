// To parse this JSON data, do
//
//     final noTokenProfileResponse = noTokenProfileResponseFromJson(jsonString);

import 'dart:convert';

NoTokenProfileResponse noTokenProfileResponseFromJson(String str) =>
    NoTokenProfileResponse.fromJson(json.decode(str));

String noTokenProfileResponseToJson(NoTokenProfileResponse data) =>
    json.encode(data.toJson());

class NoTokenProfileResponse {
  String? message;

  NoTokenProfileResponse({this.message});

  factory NoTokenProfileResponse.fromJson(Map<String, dynamic> json) =>
      NoTokenProfileResponse(message: json["message"]);

  Map<String, dynamic> toJson() => {"message": message};
}
