import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/authentication/logout.dart';
import 'package:weezli/views/account/email_verification.dart';
import 'package:weezli/views/account/phone_verification.dart';
import 'package:weezli/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final _formPersonalKey = GlobalKey<FormState>();
  final List<bool> stateForm = [
    false,
    false,
    false,
    false,
    false,
  ];
  final double _separator = 20;
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    final Row _avatarField = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/200'),
          radius: _mediaQuery.width / 7,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.firstname! + " " + user.lastname!,
              style: TextStyle(
                color: WeezlyColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.5),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_camera,
                    color: WeezlyColors.black,
                  ),
                  const Text(
                    "Modifier photo",
                    style: TextStyle(
                      color: WeezlyColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );

    TextInputType _textInputType(String type) {
      if (type == "email")
        return TextInputType.emailAddress;
      else if (type == "phone")
        return TextInputType.phone;
      else if (type == "number") return TextInputType.number;
      return TextInputType.text;
    }

    TextFormField _field(String label, String errorText, String type, int id) {
      return TextFormField(
        keyboardType: _textInputType(type),
        decoration: InputDecoration(
          suffixIcon: stateForm[id] == true
              ? Icon(
                  Icons.check_circle_rounded,
                  color: WeezlyColors.green,
                )
              : Icon(
                  WeezlyIcon.attention,
                  color: WeezlyColors.yellow,
                ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: WeezlyColors.blue3,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            setState(() {
              stateForm[id] = false;
            });
          } else {
            setState(() {
              stateForm[id] = true;
            });
          }
          if (type == "email" &&
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?"
                      r"^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            setState(() {
              stateForm[id] = false;
            });
          } else if (type == "number" &&
              !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
            setState(() {
              stateForm[id] = false;
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
      );
    }

    Future<void> _saveForm() async {
      final isValid = _formPersonalKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        _formPersonalKey.currentState!.save();
      }
    }

    final List<TextFormField> _fieldList = [
      _field(
        "Nom",
        "Veuillez renseigner votre nom",
        "text",
        0,
      ),
      _field(
        "Prénom",
        "Veuillez renseigner votre prénom",
        "text",
        1,
      ),
      _field(
        "Date de naissance",
        "Veuillez renseigner votre date de naissance",
        "text",
        2,
      ),
      _field(
        "Email",
        "Veuillez renseigner votre email",
        "email",
        3,
      ),
      _field(
        "Numéro de téléphone",
        "Veuillez renseigner votre numéro de téléphone",
        "phone",
        4,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          Padding(
              padding: EdgeInsets.all(20),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Déconnexion",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          logout();
                          Navigator.pushNamed(context, '/');
                        })))
        ]),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _avatarField,
                SizedBox(
                  height: _separator,
                ),
                const Text(
                  "Informations personnelles",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: WeezlyColors.black,
                  ),
                ),
                SizedBox(
                  height: _separator,
                ),
                Form(
                  key: _formPersonalKey,
                  child: Column(
                    children: <Widget>[
                      for (TextFormField item in _fieldList) item,
                      ElevatedButton(
                        onPressed: _saveForm,
                        child: const Text('Enregistrer'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, EmailVerification.routeName);
                        },
                        child: const Text("Vérification de l'email"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, PhoneVerification.routeName);
                        },
                        child: const Text("Vérification du téléphone"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _separator,
                ),
                const Text(
                  "Seuls les utilisateurs avec qui vous avez validé "
                  "une transaction verront votre numéro",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: _separator + 10,
                ),
                const Text(
                  "Télécharger votre carte d'identité",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ImageInput(_selectImage),
                SizedBox(
                  height: _separator,
                ),
                const Text(
                  "Votre carte d’identité est confidentielle "
                  "et n’apparaitra jamais publiquement",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
