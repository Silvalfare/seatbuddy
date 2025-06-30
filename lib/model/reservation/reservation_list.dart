// To parse this JSON data, do
//
//     final reservationListModel = reservationListModelFromJson(jsonString);

import 'dart:convert';

ReservationListModel reservationListModelFromJson(String str) =>
    ReservationListModel.fromJson(json.decode(str));

String reservationListModelToJson(ReservationListModel data) =>
    json.encode(data.toJson());

class ReservationListModel {
  String? message;
  List<Datum>? data;

  ReservationListModel({this.message, this.data});

  factory ReservationListModel.fromJson(Map<String, dynamic> json) =>
      ReservationListModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? userId;
  DateTime? reservedAt;
  String? guestCount;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.reservedAt,
    this.guestCount,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    reservedAt: json["reserved_at"] == null
        ? null
        : DateTime.parse(json["reserved_at"]),
    guestCount: json["guest_count"],
    notes: json["notes"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "reserved_at": reservedAt?.toIso8601String(),
    "guest_count": guestCount,
    "notes": notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
