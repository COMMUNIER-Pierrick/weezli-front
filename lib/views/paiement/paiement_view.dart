import 'package:flutter/material.dart';
import '../../commons/weezly_icon_icons.dart';
import '../../commons/weezly_colors.dart';

class PaiementView extends StatefulWidget {
  @override
  PaiementViewState createState() => PaiementViewState();
}

class PaiementViewState extends State<PaiementView> {
  bool saveInfos = false;
  //late TextEditingController numCardController;
  //late TextEditingController dateCardController;
  //late TextEditingController cryptoCardController;
  int selectedWayPayment = 1;
  final _formKey = GlobalKey<FormState>();
/*
  @override
  void initState() {
    super.initState();
    numCardController = TextEditingController();
    dateCardController = TextEditingController();
    cryptoCardController = TextEditingController();
  }

  @override
  void dispose() {
    numCardController.dispose();
    dateCardController.dispose();
    cryptoCardController.dispose();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paiement"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Choisissez votre moyen de paiement: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 25
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (() => setState(() => selectedWayPayment = 1)),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 10,
                        foregroundImage: selectedWayPayment == 1
                            ? AssetImage("assets/images/paiement/visa_yes.png")
                            : AssetImage("assets/images/paiement/visa_no.png"),
                      ),
                    ),
                    InkWell(
                      onTap: (() => setState(() => selectedWayPayment = 2)),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 10,
                        foregroundImage: selectedWayPayment == 2
                            ? AssetImage(
                                "assets/images/paiement/mastercard_yes.png")
                            : AssetImage(
                                "assets/images/paiement/mastercard_no.png"),
                      ),
                    ),
                    InkWell(
                      onTap: (() => setState(() => selectedWayPayment = 3)),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 10,
                        foregroundImage: selectedWayPayment == 3
                            ? AssetImage(
                                "assets/images/paiement/paylib_yes.png")
                            : AssetImage(
                                "assets/images/paiement/paylib_no.png"),
                      ),
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                value: saveInfos, 
                onChanged: ((changCheckbox) => setState(() => saveInfos = changCheckbox ?? false)),
                title: Text(
                  "Enregistrer mes informations de paiement",
                  style: TextStyle(color: WeezlyColors.grey3,)
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              //--------------------------  Form  -----------------------------------------------------------
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    inputForm(
                      0.9,
                      "Numéro de carte",
                      Icons.payment,
                      "0123456789111315",
                      //numCardController,
                      TextInputType.number,
                      16
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        inputForm(
                          0.5,
                          "Date d'expiration",
                          WeezlyIcon.calendar2,
                          "00/00",
                          //dateCardController,
                          TextInputType.datetime,
                          5
                        ),
                        inputForm(
                          0.5, 
                          "Cryptogramme", 
                          Icons.shield, 
                          "123",
                          //cryptoCardController, 
                          TextInputType.number, 
                          3
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Formulaire Validé")));
                            }
                          },
                          child: Text('VALIDER'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            primary: Theme.of(context).buttonColor,
                            //onPrimary: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Consulter la ",
                ),
                TextSpan(
                  text: "Politique de Confidentialité",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      " sur l'utilisation de vos données personnelles et vos droits.",
                ),
              ])),
            ],
          ),
        ),
      ),
    ); //fin return
  }

  Widget inputForm(
    double ratioLargeur,
    String inputTitle,
    IconData icone,
    String placeHolder,
    //TextEditingController controleur,
    TextInputType clavier,
    int longueur,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * (ratioLargeur - 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(icone),
              hintText: placeHolder,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).buttonColor)),
            ),
            //controller: controleur,
           // onChanged: ((newValue) =>
             //   setState(() => controleur.text = newValue)),
            keyboardType: clavier,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ce champ ne doit pas être vide";
              }
              if (value.length < longueur) {
                return "Il manque des chiffres";
              }
              if (value.length > longueur) {
                return "Il y a trop de chiffres";
              }
              if (clavier == TextInputType.number &&
                  !value.contains(RegExp('[0-9]{$longueur}'))) {
                return "Valeur invalide";
              }
              if (clavier == TextInputType.datetime &&
                  !value.contains(RegExp('[0-9]{2}/[0-9]{2}'))) {
                return "Valeur invalide";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
