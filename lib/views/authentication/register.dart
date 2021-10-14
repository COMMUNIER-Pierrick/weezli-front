import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weezli/commons/saveData.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weezli/model/Address.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/user/createAccount.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _condition = false;
  final double _separator = 20;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  DateTime dateOfBirthday = DateTime.now();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  // Fonction qui teste le mdp selon une regex (minimum 8 lettres avec au moins une majuscule et un chiffre)
  bool validateStructurePassWord(String value) {
    RegExp regExp = new RegExp(
        r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[-!#$@%^&*()_+|~=`{}:;'<>?,.\\\[\]\/])(?=\S+$).{6,}$");
    return regExp.hasMatch(value);
  }

  // Fonction qui teste l'email selon une regex
  bool validateStructureEmail(String value) {
    RegExp regExp = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(value);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: Locale('fr'),
      context: context,
      initialDate: dateOfBirthday,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != dateOfBirthday)
      setState(() {
        dateOfBirthday = picked;
        _birthdayController.text = DateFormat.yMd('fr_FR').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {

    TextFormField _field(TextEditingController controller, String label,
        String errorText, int mode) {
      return TextFormField(
        controller: controller,
        decoration: InputDecoration(
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
        validator: (value) {
          switch (mode) {
            case 0:
              if (value == null || value.isEmpty) {
                return errorText;
              }
              break;
            case 1:
              if (value!.trim().isEmpty || !validateStructureEmail(value)) {
                return errorText;
              }
          }
        },
      );
    }

    TextFormField _hiddenfield(TextEditingController controller, String label,
        String errorText, int mode) {
      return TextFormField(
          obscureText: true,
          controller: controller,
          decoration: InputDecoration(
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
              errorMaxLines: 2),
          validator: (value) {
            if (mode == 0) {
              if (value!.trim().isEmpty || !validateStructurePassWord(value)) {
                return errorText;
              }
            } else if (value != _passwordController.text || value!.isEmpty) {
              return errorText;
            }
          });
    }

    final _fieldNumber = _field(_numberController, "Numéro de rue *", "Veuillez renseigner votre numéro de rue", 0);
    final _fieldStreet = _field(_streetController, "Nom de rue *", "Veuillez renseigner votre nom de rue", 0);
    final _fieldZipCode = _field(_zipCodeController, "Code postal *", "Veuillez renseigner votre code postal", 0);
    final _fieldCity = _field(_cityController, "Ville *","Veuillez renseigner votre ville", 0);
    final _fieldCountry = _field(_countryController, "Pays *", "Veuillez renseigner votre pays", 0);

    final List<TextFormField> _fieldList = [
      _field(_lastnameController, "Nom *", "Veuillez renseigner votre nom", 0),
      _field(_firstnameController, "Prénom *",
          "Veuillez renseigner votre prénom", 0),
      _field(_emailController, "Adresse email *",
          "Veuillez renseigner un email valable", 1),
      _field(_usernameController, "Nom d'utilisateur *",
          "Veuillez renseigner votre nom d'utilisateur", 0),
      //_field(_numberController, "Numéro de rue *",
      //    "Veuillez renseigner votre numéro de rue", 0),
      //_field(_streetController, "Nom de rue *",
      //    "Veuillez renseigner votre nom de rue", 0),
      //_field(_zipCodeController, "Code postal *",
      //    "Veuillez renseigner votre code postal", 0),
      //_field(_cityController, "Ville *",
      //    "Veuillez renseigner votre ville", 0),
      //_field(_countryController, "Pays *",
      //   "Veuillez renseigner votre pays", 0),
    ];

    final List<TextFormField> _hiddenFieldList = [
      _hiddenfield(
          _passwordController,
          "Mot de passe *",
          "Le mot de passe doit être de minimum 8 caractères, dont une minuscule, une majuscule et un chiffre.",
          0),
      _hiddenfield(_repeatPasswordController, "Confirmation du mot de passe *",
          "Veuillez répéter correctement votre mot de passe", 1),
    ];

    final registerForm = Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      WeezlyIcon.facebook_official,
                      size: 20,
                    ),
                  ),
                  const Text(
                    "S'inscrire avec facebook",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: WeezlyColors.white,
                    ),
                  ),
                ]),
              fillColor: WeezlyColors.facebook,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.5),
              ),
              padding: EdgeInsets.all(15),
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: WeezlyColors.white,
              ),
            ),
            SizedBox(
              height: _separator,
            ),
            const Text(
              "Ou",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: WeezlyColors.primary,
              ),
            ),
            SizedBox(
              height: _separator,
            ),
            const Text(
              "S'inscrire avec un email",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: WeezlyColors.primary,
              ),
            ),
            SizedBox(
              height: _separator,
            ),
            for (TextFormField field in _fieldList) field,
            Row(
              children: [
                Expanded(
                    child:
                    _fieldNumber,
                ),
                SizedBox(width: 50),
                Expanded(
                    child: _fieldStreet,
                ),
              ]),
            Row(
              children: [
                Expanded(
                  child: _fieldZipCode,
                ),
                SizedBox(width: 50),
                Expanded(
                  child: _fieldCity,
                ),
              ]),
            _fieldCountry,
            for (TextFormField hiddenField in _hiddenFieldList) hiddenField,
            Row(children: [
              Icon(
                WeezlyIcon.calendar2,
              ),
              SizedBox(width: 10),
              Expanded(
                  child: GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration (
                        labelText: "Date de naissance"
                      ),
                  style: TextStyle(height: 0),
                  controller: _birthdayController,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez renseigner une valeur";
                    }
                    return null;
                  },
                )),
              )),
            ]),
            SizedBox(
              height: _separator,
            ),
            CheckboxListTile(
              title: const Text(
                "J'accepte les conditions d'utilisation",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: WeezlyColors.grey4,
                ),
              ),
              value: _condition,
              onChanged: (bool? value) {
                setState(() {
                  _condition = value!;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            SizedBox(
              height: _separator,
            ),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String lastname = _lastnameController.text;
                    String firstname = _firstnameController.text;
                    String password = _passwordController.text;
                    String email = _emailController.text;
                    String username = _usernameController.text;
                    User user = User(
                        lastname: lastname,
                        firstname: firstname,
                        password: password,
                        email: email,
                        username: username,
                        dateOfBirthday: dateOfBirthday,
                        address: Address (
                          number: int.parse(_numberController.text),
                          street: _streetController.text,
                          zipCode: _zipCodeController.text,
                          city: _cityController.text,
                          country: _countryController.text
                        ));
                    var response = await createUser(user);
                    if (response.statusCode == 201)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Inscription effectuée !')),
                      );
                    saveData(response.body);
                    Navigator.pushNamed(context, '/');
                  }
                },
                child: const Text("S'INSCRIRE GRATUITEMENT"),
                fillColor: WeezlyColors.blue2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.5),
                ),
                padding: EdgeInsets.all(15),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: WeezlyColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Inscription"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                registerForm,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
