import 'package:baloogo/service/announce/create.dart';
import 'package:flutter/material.dart';

class CreateAnnounce extends StatefulWidget {
  const CreateAnnounce({Key? key}) : super(key: key);

  @override
  _CreateAnnounceState createState() => _CreateAnnounceState();
}

class _CreateAnnounceState extends State<CreateAnnounce> {
  final TextEditingController adressDeparture = TextEditingController();
  final TextEditingController adressArrival = TextEditingController();
  final TextEditingController datetimeDeparture = TextEditingController();
  final TextEditingController datetimeArrival = TextEditingController();
  final TextEditingController kgAvailable = TextEditingController();
  final TextEditingController kgPrice = TextEditingController();
  final TextEditingController kgWanted = TextEditingController();
  final TextEditingController listObjects = TextEditingController();
  final TextEditingController descriptionConditions = TextEditingController();
  final TextEditingController type = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextFormField _field(
      String type,
      bool obscureText,
      String label,
      TextEditingController controller,
    ) {
      TextInputType textInputType = TextInputType.name;
      switch (type) {
        case "number":
          {
            textInputType = TextInputType.number;
          }
          break;
        default:
          {
            textInputType = TextInputType.name;
          }
          break;
      }
      return TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Veuillez renseigner votre mot de passe";
          }
          return null;
        },
      );
    }

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final Form createAnnounceForm = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _field("", false, "Adresse de départ", adressDeparture),
          SizedBox(
            height: 10,
          ),
          _field("", false, "Adresse d'arrivée", adressArrival),
          SizedBox(
            height: 10,
          ),
          _field("", false, "Date de départ", datetimeDeparture),
          SizedBox(
            height: 10,
          ),
          _field("", false, "Date d'arrivée", datetimeArrival),
          SizedBox(
            height: 10,
          ),
          _field("number", false, "Kg disponible", kgAvailable),
          SizedBox(
            height: 10,
          ),
          _field("number", false, "Prix du kg (en €)", kgPrice),
          SizedBox(
            height: 10,
          ),
          _field("number", false, "Kg voulu", kgWanted),
          SizedBox(
            height: 10,
          ),
          _field("", false, "Listes des objets", listObjects),
          SizedBox(
            height: 10,
          ),
          _field(
              "", false, "Descriptions des conditions", descriptionConditions),
          SizedBox(
            height: 10,
          ),
          _field("", false, "Type d'annonce", type),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final response = await createAnnounce(
                  adressDeparture.text,
                  adressArrival.text,
                  datetimeDeparture.text,
                  datetimeArrival.text,
                  double.parse(kgAvailable.text),
                  double.parse(kgPrice.text),
                  double.parse(kgWanted.text),
                  listObjects.text,
                  descriptionConditions.text,
                  type.text,
                );
                print(response);
                if (response == 200) {
                  final SnackBar snackBar = SnackBar(
                    content: Text("Votre annonce est crée !"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final SnackBar snackBar = SnackBar(
                    content: Text(
                      "Une erreur est survenu",
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            child: Text("Créer l'annonce"),
          ),
        ],
      ),
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: createAnnounceForm,
        ),
      ),
    );
  }
}
