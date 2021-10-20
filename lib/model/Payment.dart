
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

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json["id"],
      name: (json ["name"] != null) ? json ["name"] : null,
      IBAN: (json ["IBAN"] != null) ? json ["IBAN"] : null,
      numberCard: (json ["numberCard"] != null) ? json ["numberCard"] : null,
      expiredDateCard: (json['expired_date_card'] != null) ? DateTime.parse(
          json['expired_date_card']) : null,
    );
  }

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "IBAN": IBAN,
      "numberCard" : numberCard,
      "expired_date_card" : expiredDateCard,
    };
  }
