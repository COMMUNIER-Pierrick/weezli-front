import 'package:baloogo/commons/disconnect.dart';
import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({Key? key}) : super(key: key);
  static const routeName = '/phone-verification';

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final _formPhoneVerificationKey = GlobalKey<FormState>();
  final double _separator = 20;
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    TextFormField _field() {
      return TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          suffixIcon: _isValid == true
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
          labelText: "Numéro de téléphone",
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            setState(() {
              _isValid = false;
            });
          } else {
            setState(() {
              _isValid = true;
            });
          }
          if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
            setState(() {
              _isValid = false;
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Veuillez renseigner correctement votre numéro de téléphone";
          }
          return null;
        },
      );
    }

    Future<void> _saveForm() async {
      final isValid = _formPhoneVerificationKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formPhoneVerificationKey.currentState!.save();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            disconnect,
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                  key: _formPhoneVerificationKey,
                  child: Column(
                    children: <Widget>[
                      _field(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('VERIFIER'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  WeezlyColors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  WeezlyColors.primary),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: WeezlyColors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('MODIFIER'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  WeezlyColors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  WeezlyColors.primary),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: WeezlyColors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
