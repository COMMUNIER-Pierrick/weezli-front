import 'dart:convert';

Choice choiceFromJSon(String str) => Choice.fromJson(json.decode(str));

String choiceToJson(Choice data) => json.encode(data.toJson());

class Choice{

   int id;
   String name;
   String description;
   num price;
   String id_payment;

  Choice({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.id_payment
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
        id: json['id'],
        name: json['name'],
        description: (json["description"] != null) ? json["description"] : null,
        price: (json['price'] != null) ? json['price'] : null,
        id_payment: (json['id_payment'] != null) ? json['id_payment'] : "",
    );
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "id_payment": id_payment
  };

}

class ChoiceListMap{
  ChoiceListMap({
    required this.list,
  });

  List <dynamic> list;

  factory ChoiceListMap.fromJson(Map<String, dynamic> json){
    return ChoiceListMap(
        list: json["Choices"]
    );
  }
}

class ChoiceList{
  ChoiceList({
    required this.choiceList,
  });

  List<Choice> choiceList;

  factory ChoiceList.fromJson(List<dynamic> parsedJson){
    List<Choice> choices = [];
    parsedJson.forEach((element) {
      var mapChoice = ChoiceListDynamic.fromJson(element).choiceListDynamic;
      Choice choice = Choice.fromJson(mapChoice);
      choices.add(choice);
    });

    return new ChoiceList(
        choiceList: choices
    );
  }
}

class ChoiceListDynamic{
  ChoiceListDynamic({
    required this.choiceListDynamic
  });

  Map <String, dynamic> choiceListDynamic;

  factory ChoiceListDynamic.fromJson(Map<String, dynamic> json){
    return ChoiceListDynamic(
        choiceListDynamic: json ["Choice"]
    );
  }
}