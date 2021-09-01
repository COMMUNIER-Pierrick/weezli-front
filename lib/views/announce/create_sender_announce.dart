import 'dart:io';

import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:baloogo/views/announce/create_carrier_announce.dart';
import 'package:baloogo/widgets/custom_title.dart';
import 'package:baloogo/widgets/footer.dart';
import 'package:baloogo/widgets/image_input.dart';
import 'package:baloogo/widgets/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/widgets/calendar.dart';

class CreateSenderAnnounce extends StatefulWidget {
  static const routeName = '/sender-announce';

  @override
  _CreateSenderAnnounceState createState() => _CreateSenderAnnounceState();
}

class _CreateSenderAnnounceState extends State<CreateSenderAnnounce> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _deadlineDate = TextEditingController();

  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectDate(DateTime dateSelected) {
    setState(
      () => _deadlineDate.text = DateFormat.yMd('fr').format(dateSelected),
    );
  }

  Future<void> _saveSenderAnnounce() async {
    //final isValid = _formKey.currentState!.validate();
    //if (!isValid) {
    //return;
    //}
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          _buildPopupSavedSenderAnnounce(context),
    );
    //_formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(title: Text('Informations du colis'));
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.9,
              color: Color(0xE5E5E5),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Completez le formulaire pour expédier votre colis',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _field('text', "Ville ou pays de départ"),
                          SizedBox(height: 5),
                          _field('text', "Ville ou pays de destination"),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                      'Date limite d\'expédition',
                                      _deadlineDate,
                                      'date'),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: _buildTextField(
                                      'Poids approximatif en kg:',
                                      null,
                                      'number'),
                                ),
                              ],
                            ),
                            height: 80,
                          ),
                          Text('Dimensions',
                              style: Theme.of(context).textTheme.headline5),
                          Sizes(),
                          Text('Ajouter photos, document',
                              style: Theme.of(context).textTheme.headline5),
                          ImageInput(_selectImage),
                          _field('textarea', "Description"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Footer(
                height: height,
                childLeft: FooterChildLeft(),
                childRight: "Enregistrer",
                saveForm: _saveSenderAnnounce)
          ],
        ),
      ),
    );
  }

  Column _buildTextField(
      String label, TextEditingController? controller, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          height: 30,
          child: GestureDetector(
            onTap: () => openDatePicker(context, _selectDate),
            child: type == 'date'
                ? AbsorbPointer(
                    child: _formField(controller: controller, type: type),
                  )
                : _formField(type: type),
          ),
        ),
      ],
    );
  }

  TextFormField _formField(
      {TextEditingController? controller, required String type}) {
    return TextFormField(
      controller: controller,
      keyboardType:
          type == 'date' ? TextInputType.datetime : TextInputType.number,
      decoration: InputDecoration(
        // labelText: label,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: WeezlyColors.blue3),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: WeezlyColors.blue3),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty || controller!.text.isEmpty) {
          return "Veuillez renseigner une valeur";
        }
        return null;
      },
    );
  }

  TextFormField _field(String type, String label) {
    TextInputType textInputType = TextInputType.name;
    switch (type) {
      case "number":
        {
          textInputType = TextInputType.number;
        }
        break;
      case "textarea":
        {
          textInputType = TextInputType.multiline;
        }
        break;
      default:
        {
          textInputType = TextInputType.name;
        }
        break;
    }
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputType != TextInputType.multiline
          ? TextInputAction.next
          : TextInputAction.newline,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        labelText: label,
        labelStyle: TextStyle(
          color: WeezlyColors.grey3,
          fontSize: 14,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: WeezlyColors.blue3),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: WeezlyColors.blue3),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Veuillez renseigner une valeur";
        }
        return null;
      },
    );
  }
}

Widget _buildPopupSavedSenderAnnounce(BuildContext context) {
  return new Dialog(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(
                  WeezlyIcon.check_circle,
                size: 60,
                color: Colors.green,
              )],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomTitle("ANNONCE ENREGISTRÉE")],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 40,
                child: RawMaterialButton(
                  fillColor: WeezlyColors.white,
                  textStyle: TextStyle(
                    color: WeezlyColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5),
                      side: BorderSide(color: WeezlyColors.primary)),
                  onPressed: null,
                  child: const Text("VOIR L'ANNONCE"),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 40,
                child: RawMaterialButton(
                  fillColor: WeezlyColors.primary,
                  textStyle: TextStyle(
                    color: WeezlyColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.5),
                  ),
                  onPressed: null,
                  child: const Text("TROUVER UN COLIS"),
                ),
              ),
            ]),
          ]),
    ),
  );
}
