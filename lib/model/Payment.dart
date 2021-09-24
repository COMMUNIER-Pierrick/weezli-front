
import 'dart:convert';
import 'dart:ffi';

Payment PaymentFromJson(String str) => Payment.fromJson(json.decode(str));

String PaymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment ({
    this.id,
    this.name,
    this.IBAN,
    this.numberCard,
    this.expiredDateCard,
  });

  int? id;
  String? name;
  String? IBAN;
  String? numberCard;
  DateTime? expiredDateCard;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    name: json["name"],
    IBAN: json["IBAN"],
    numberCard : json ["numberCard"],
    expiredDateCard : (json['expired_date_card'] != null) ? DateTime.parse(json['expired_date_card']): null,

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "IBAN": IBAN,
    "numberCard" : numberCard,
    "expired_date_card" : expiredDateCard,
  };
}
