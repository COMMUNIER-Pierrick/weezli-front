import 'package:baloogo/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/sizes.dart';
import '../../widgets/travelMode.dart';
import '../../commons/weezly_colors.dart';
import '../../widgets/calendar.dart';

class CreateCarrierAnnounce extends StatefulWidget {
  static const routeName = '/carrier-announce';

  @override
  _CreateCarrierAnnounce createState() => _CreateCarrierAnnounce();
}

class _CreateCarrierAnnounce extends State<CreateCarrierAnnounce> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _dateDepartureCtrl = TextEditingController();
  var _timeDepartureCtrl = TextEditingController();
  var _dateArrivalCtrl = TextEditingController();
  var _timeArrivalCtrl = TextEditingController();
  String? typePrice;
  Map<String, bool> debate = {
    'yes': false,
    'no': false,
  };
  bool? debateToSave;
  Map<String, dynamic> announce = {};

  void _selectDate(DateTime dateSelected, String? type) {
    setState(
      () => type == 'departure'
          ? _dateDepartureCtrl.text = DateFormat.yMd('fr').format(dateSelected)
          : _dateArrivalCtrl.text = DateFormat.yMd('fr').format(dateSelected),
    );
  }

  void _setDebate(String keyToChange, String keyToChange2) {
    setState(
      () {
        if (debate[keyToChange]!) {
          debate[keyToChange] = !debate[keyToChange]!;
          debateToSave = null;
        } else {
          debate[keyToChange] = !debate[keyToChange]!;
          debate[keyToChange2] = !debate[keyToChange]!;
          debateToSave = debate['yes'];
        }
      },
    );
  }

  void _selectTime(TimeOfDay timeSelected, String type) {
    setState(
      () => type == 'departure'
          ? _timeDepartureCtrl.text = DateFormat.Hm('fr').format(
              DateFormat.jm().parse(
                timeSelected.format(context),
              ),
            )
          : _timeArrivalCtrl.text = DateFormat.Hm('fr').format(
              DateFormat.jm().parse(
                timeSelected.format(context),
              ),
            ),
    );
  }

  Future<void> _saveCarrierAnnounce() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(title: Text('Votre annonce'));
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xE5E5E5),
              height: height * 0.9,
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Déposez une annonce pour transporter des colis',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _field('text', 'Ville ou pays de départ'),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildDateOrTime(
                                      'Date de départ*',
                                      _dateDepartureCtrl,
                                      'Choisir une date',
                                      'date',
                                      'departure'),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: _buildDateOrTime(
                                      'Heure*',
                                      _timeDepartureCtrl,
                                      'Choisir l\'heure de départ',
                                      'time',
                                      'departure'),
                                ),
                              ],
                            ),
                            height: 80,
                          ),
                          _field(
                            'text',
                            'Ville ou pays destination',
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildDateOrTime(
                                      'Date de d\'arrivée*',
                                      _dateArrivalCtrl,
                                      'Choisir une date',
                                      'date',
                                      'arrival'),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: _buildDateOrTime(
                                      'Heure',
                                      _timeArrivalCtrl,
                                      'Choisir l\'heure de départ',
                                      'time',
                                      'arrival'),
                                ),
                              ],
                            ),
                            height: 80,
                          ),
                          Text("Moyen de transport *",
                              style: Theme.of(context).textTheme.headline5),
                          TravelMode(Colors.white, WeezlyColors.blue4, 0.35),
                          Row(
                            children: [
                              Text("Dimension",
                                  style: Theme.of(context).textTheme.headline5),
                              _buildTooltip(
                                  'Vous pouvez choisir 1 ou plusieurs choix'),
                            ],
                          ),
                          Sizes(),
                          _field(
                            'number',
                            'Poids approximatif en kg: disponible*',
                            field: 'weight',
                          ),
                          Row(children: [
                            Text("Commission",
                                style: Theme.of(context).textTheme.headline5),
                            _buildTooltip(
                              "Vous pouvez choisir un prix par kilo ou pour un ensemble. Vous pouvez aussi de ne pas renseigner un prix et attendre qu'un expéditeur fasse une proposition",
                            ),
                          ]),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: _field('number', 'Proposition en €',
                                      field: 'price')),
                              SizedBox(width: 10),
                              DropdownButton(
                                value: typePrice,
                                onChanged: (String? value) =>
                                    setState(() => typePrice = value),
                                items: [
                                  'Par kilos',
                                  'L\'ensemble'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          Text("Votre proposition est-elle négociable?",
                              style: Theme.of(context).textTheme.headline5),
                          Row(
                            children: [
                              _buildDebate('Oui', 'yes'),
                              _buildDebate('Non', 'no'),
                              Spacer(),
                            ],
                          ),
                          _field('textarea', 'Description'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Footer(
                height: height,
                childLeft: FooterChildLeft(),
                childRight: "Enregistrer",
                saveForm: _saveCarrierAnnounce)
          ],
        ),
      ),
    );
  }

  Column _buildDateOrTime(String label, TextEditingController controller,
      String hintText, String type, String typeTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Expanded(
            child: GestureDetector(
          onTap: type == 'date'
              ? () => openDatePicker(context, _selectDate, typeTime: typeTime)
              : () => openTimePicker(context, _selectTime, typeTime),
          child: AbsorbPointer(
            child: TextFormField(
              style: TextStyle(height: 0),
              controller: controller,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                // hintText: !hide ? hintText : '',
                labelText: hintText,
                labelStyle: TextStyle(
                  color: WeezlyColors.grey3,
                  fontSize: 12,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: WeezlyColors.blue3),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: WeezlyColors.blue3),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || controller.text.isEmpty) {
                  return "Veuillez renseigner Une valeur";
                }
                return null;
              },
            ),
          ),
        )),
      ],
    );
  }

  Expanded _buildDebate(String text, String key) {
    return Expanded(
      child: Container(
        height: 43,
        width: 95,
        margin: EdgeInsets.only(right: 10, top: 20),
        child: InkWell(
          onTap: () =>
              text == 'Oui' ? _setDebate('yes', 'no') : _setDebate('no', 'yes'),
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(21.5),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: debate[key] == true
              ? Color.fromRGBO(127, 205, 243, 0.95)
              : Colors.transparent,
          border: Border.all(
              width: 1,
              color: debate[key] == true ? Colors.transparent : Colors.black),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(110.0),
          ),
        ),
      ),
    );
  }

  TextFormField _field(String type, String label, {String field = 'field'}) {
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
        if (((value == null || value.isEmpty) &&
                field != 'weight' &&
                field != 'price') ||
            (travelMode.value == 'Avion' &&
                field == 'weight' &&
                (value == null || value.isEmpty))) {
          return "Veuillez renseigner Une valeur";
        }
        return null;
      },
    );
  }

  Tooltip _buildTooltip(String message) {
    return Tooltip(
      message: message,
      child: Icon(Icons.info_outline),
    );
  }
}

class FooterChildLeft extends StatelessWidget {
  const FooterChildLeft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        "Annuler".toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50),
        primary: WeezlyColors.grey3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
