import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'package:weezli/commons/saveData.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Address.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/authentication/logout.dart';
import 'package:weezli/service/user/modifyProfile.dart';
import 'package:weezli/views/account/email_verification.dart';
import 'package:weezli/views/account/phone_verification.dart';
import 'package:weezli/views/account/userProfile.dart';
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
    final lastNameController = TextEditingController(text : user.lastname);
    final firstNameController = TextEditingController(text : user.firstname);
    final emailController = TextEditingController(text : user.email);
    final phoneController = TextEditingController (text : user.phone);
    final TextEditingController _numberController = TextEditingController(text : user.address![0].number.toString());
    final TextEditingController _streetController = TextEditingController(text : user.address![0].street);
    final TextEditingController _zipCodeController = TextEditingController(text : user.address![0].zipCode);
    final TextEditingController _cityController = TextEditingController(text : user.address![0].city);
    final TextEditingController _countryController = TextEditingController(text : user.address![0].country);

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

    Icon suffixIcon(TextEditingController controller) {
      if (controller.text != "")
        return Icon(
          Icons.check_circle_rounded,
          color: WeezlyColors.green,
        );
      else
        return Icon(
          WeezlyIcon.attention,
          color: WeezlyColors.yellow,
        );
    }


    Future<void> _saveForm() async {
      final isValid = _formPersonalKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        _formPersonalKey.currentState!.save();
        final Response response = await modifyProfile(User(
          id : user.id,
          lastname: lastNameController.text,
          firstname: firstNameController.text,
          phone: phoneController.text,
          email: emailController.text,
            address: [Address (
                number: int.parse(_numberController.text),
                street: _streetController.text,
                zipCode: _zipCodeController.text,
                city: _cityController.text,
                country: _countryController.text
            )]
        ));
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Modification effectuée')),
          );
            saveData(response.body);
            Navigator.pushNamed(context, UserProfile.routeName, arguments: user.id);
        }
      }
    }



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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: lastNameController,
                        onTap: () => lastNameController.clear(),
                        decoration: InputDecoration (
                          suffixIcon: suffixIcon(lastNameController),
                          hintText: user.lastname,
                        ),
                      ),
                      TextFormField(
                        controller: firstNameController,
                        onTap: () => firstNameController.clear(),
                        decoration: InputDecoration (
                            suffixIcon: suffixIcon(firstNameController)
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        onTap: () => emailController.clear(),
                        decoration: InputDecoration (
                            suffixIcon: suffixIcon(emailController)
                        ),
                      ),
                      TextFormField(
                        controller: phoneController,
                        onTap: () => phoneController.clear(),
                        decoration: InputDecoration (
                            suffixIcon: suffixIcon(phoneController)
                        ),
                      ),
                      TextFormField(
                        controller: _numberController,
                        onTap: () => _numberController.clear(),
                        decoration: InputDecoration (
                            suffixIcon: suffixIcon(_numberController)
                        )),
                        TextFormField(
                          controller: _streetController,
                          onTap: () => _streetController.clear(),
                          decoration: InputDecoration (
                              suffixIcon: suffixIcon(_streetController)
                          ),
                      ),
                      TextFormField(
                        controller: _zipCodeController,
                        onTap: () => _zipCodeController.clear(),
                        decoration: InputDecoration (
                            suffixIcon: suffixIcon(_zipCodeController)
                        ),
                      ),
                      TextFormField(
                        controller: _cityController,
                        onTap: () => _cityController.clear(),
                        decoration: InputDecoration (
                            suffixIcon: suffixIcon(_cityController)
                        ),
                      ),
                      TextFormField(
                        controller: _countryController,
                        onTap: () => _countryController.clear(),
                        decoration: InputDecoration (
                            suffixIcon: suffixIcon(_countryController)
                        ),
                      ),
                      SizedBox(
                        height: _separator,
                      ),
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
