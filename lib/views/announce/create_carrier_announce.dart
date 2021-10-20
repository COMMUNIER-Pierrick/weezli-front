import 'dart:convert';

import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Address.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/FinalPrice.dart';
import 'package:weezli/model/Package.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/Transportation.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/announce/createCarrierAnnounce.dart';
import 'package:weezli/service/announce/findAllSizes.dart';
import 'package:weezli/service/announce/findAllTransportations.dart';
import 'package:weezli/views/search/search.dart';
import 'package:weezli/widgets/build_loading_screen.dart';
import 'package:weezli/widgets/custom_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/travelMode.dart';
import '../../commons/weezly_colors.dart';
import 'announce_detail.dart';

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
  var _placeDepartureCtrl = TextEditingController();
  var _countryDepartureCtrl = TextEditingController();
  var _placeArrivalCtrl = TextEditingController();
  var _countryArrivalCtrl = TextEditingController();
  var _weightCtrl = TextEditingController();
  var _priceCtrl = TextEditingController();
  var _descriptionCtrl = TextEditingController();
  DateTime dateDeparture = DateTime.now();
  DateTime dateArrival = DateTime.now();
  TimeOfDay timeDeparture = TimeOfDay.now();
  TimeOfDay timeArrival =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 60)));
  int _currentSelectedIndexTransportation = 0;
  List<int> _currentSelectedIndexSize = [];
  List<PackageSize> sizes = [];
  int transact = 0;
  Transportation? transportationSelected;

// Actual hour + 1 hour

  Future<List<Transportation>> getTransportations() async {
    List<Transportation> transportations = await findAllTransportations();
    return transportations;
  }

  Future<List<PackageSize>> getSizes() async {
    List<PackageSize> sizes = await findAllSizes();
    return sizes;
  }

  _selectDate(BuildContext context, TextEditingController controller,
      bool departure) async {
    final DateTime? picked = await showDatePicker(
      locale: Locale('fr'),
      context: context,
      initialDate: dateDeparture,
      firstDate: dateDeparture,
      lastDate: dateDeparture.add(const Duration(days: 365)),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat.yMd('fr_FR').format(picked);
      });
      if (departure)
        dateDeparture = picked;
      else
        dateArrival = picked;
    }
  }

  _selectTime(BuildContext context, TextEditingController controller,
      bool departure) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeDeparture,
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
      if (departure)
        timeDeparture = picked;
      else
        timeArrival = picked;
    }
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  _saveCarrierAnnounce(User user) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      Announce announce = Announce(
        views: 0,
        dateCreated: DateTime.now(),
        package: Package(
          description: _descriptionCtrl.text,
          addressDeparture: Address(
              city: _placeDepartureCtrl.text,
              country: _countryDepartureCtrl.text),
          datetimeDeparture: join(dateDeparture, timeDeparture),
          transportation:
              Transportation(id: _currentSelectedIndexTransportation),
          size: sizes,
          kgAvailable: double.parse(_weightCtrl.text),
          addressArrival: Address(
              city: _placeArrivalCtrl.text, country: _countryArrivalCtrl.text),
          dateTimeArrival: join(dateArrival, timeArrival),
        ),
        type: 2,
        price: double.parse(_priceCtrl.text),
        transact: transact,
        userAnnounce: user,
        finalPrice: FinalPrice (
          accept: 1,
          proposition: double.parse(_priceCtrl.text),
          user: user)
      );
      var response = await createCarrierAnnounce(announce);
      if (response.statusCode == 200) {
        print("Réponse : " + response.body);
        var mapAnnounce = AnnouncesListDynamic
            .fromJson(jsonDecode(response.body))
            .announcesListDynamic;
        Announce newAnnounce = Announce.fromJson(mapAnnounce);

        showDialog(
          context: context,
          builder: (BuildContext context) =>
              _buildPopupSavedCarrierAnnounce(context, newAnnounce),
        );
      }
      _formKey.currentState!.save();
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(title: Text('Votre annonce'));
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _field(
                              'text', 'Ville de départ', _placeDepartureCtrl),
                          _field(
                              'text', 'Pays de départ', _countryDepartureCtrl),
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
                                      'departure',
                                      true),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: _buildDateOrTime(
                                      'Heure*',
                                      _timeDepartureCtrl,
                                      'Choisir l\'heure de départ',
                                      'time',
                                      'departure',
                                      true),
                                ),
                              ],
                            ),
                            height: 80,
                          ),
                          Row(children: [
                            Expanded(
                                child: _field('text', 'Ville de destination',
                                    _placeArrivalCtrl))
                          ]),
                          Row(children: [
                            Expanded(
                                child: _field('text', 'Pays de destination',
                                    _countryArrivalCtrl))
                          ]),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildDateOrTime(
                                    'Date d\'arrivée*',
                                    _dateArrivalCtrl,
                                    'Choisir une date',
                                    'date',
                                    'arrival',
                                    false,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: _buildDateOrTime(
                                      'Heure',
                                      _timeArrivalCtrl,
                                      'Choisir l\'heure de départ',
                                      'time',
                                      'arrival',
                                      false),
                                ),
                              ],
                            ),
                            height: 80,
                          ),
                          Text("Moyen de transport"),
                          FutureBuilder(
                              future: getTransportations(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  List<Transportation> transportations =
                                      snapshot.data as List<Transportation>;
                                  return Column(
                                    children:[ Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (var transportation
                                            in transportations)
                                          if (transportation.name !=
                                              "non-identifier" && transportation.id < 5)
                                            _setTransportation(transportation)
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        for (var transportation
                                        in transportations)
                                          if (transportation.name !=
                                              "non-identifier" && transportation.id > 4)
                                            _setTransportation(transportation)
                                      ])]);
                                }
                                return buildLoadingScreen();
                              }),
                          Text("Tailles d'objets possibles"),
                          FutureBuilder(
                              future: getSizes(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  List<PackageSize> sizes =
                                      snapshot.data as List<PackageSize>;
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (var size in sizes) _setSize(size)
                                      ]);
                                }
                                return buildLoadingScreen();
                              }),
                          _field(
                            'number',
                            'Poids approximatif disponible (en kg)*',
                            _weightCtrl,
                            field: 'weight',
                          ),
                          SizedBox(height: 15),
                          Row(children: [
                            Text("Commission",
                                style: Theme.of(context).textTheme.headline5),
                            _buildTooltip(
                              "Le prix est pour l'ensemble. Vous pouvez aussi laisser libre et attendre qu'un expéditeur vous fasse une offre.",
                            ),
                          ]),
                          SizedBox(height: 5),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: _field(
                                      'number', 'Proposition en €', _priceCtrl,
                                      field: 'price')),
                            ],
                          ),
                          SizedBox(height: 15),
                          /*Text("Votre proposition est-elle négociable ?",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              ToggleSwitch(
                                minWidth: 90.0,
                                cornerRadius: 20.0,
                                activeBgColors: [
                                  [Colors.red[800]!],
                                  [WeezlyColors.blue2],
                                ],
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.white,
                                initialLabelIndex: 0,
                                totalSwitches: 2,
                                labels: ['Non', 'Oui'],
                                radiusStyle: true,
                                onToggle: (index) {
                                  transact = index;
                                },
                              ),
                            ],
                          ),*/
                          SizedBox(height: 15),
                          _field('textarea', 'Description', _descriptionCtrl),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: WeezlyColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.26),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(0, 1), // changes position of shadow
                  )
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FooterChildLeft(),
                    ElevatedButton(
                        onPressed: () => _saveCarrierAnnounce(user),
                        child: Text(
                          "Enregistrer".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          primary: Theme.of(context).buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ))
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _setTransportation(Transportation transportation) {
    int index = transportation.id;
    bool selected = index == _currentSelectedIndexTransportation;
    Color tileColor = selected ? WeezlyColors.blue6 : Colors.white;

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                child: ClipOval(
                    child: GestureDetector(
                        child: CircleAvatar(
                            radius: 27,
                            backgroundColor: tileColor,
                            child: Image(
                                width: 45,
                                image: NetworkImage(
                                    'http://10.0.2.2:5000/images/' +
                                        transportation.name! +
                                        ".png"))),
                        onTap: () {
                          setState(() {
                            _currentSelectedIndexTransportation = index;
                            Transportation transportationSelected =
                                transportation;
                          });
                        })),
                radius: 30,
                backgroundColor: WeezlyColors.primary,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _setSize(PackageSize size) {
    int index = size.id;
    bool selected;
    if (_currentSelectedIndexSize.contains(index))
      selected = true;
    else
      selected = false;
    Color tileColor = selected ? WeezlyColors.blue6 : Colors.white;
    String image = size.name == "très grand"
        ? 'http://10.0.2.2:5000/images/tresgrand.png'
        : 'http://10.0.2.2:5000/images/' + size.name + ".png";

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                child: ClipOval(
                    child: GestureDetector(
                        child: CircleAvatar(
                            radius: 27,
                            backgroundColor: tileColor,
                            child:
                                Image(width: 45, image: NetworkImage(image))),
                        onTap: () {
                          setState(() {
                            if (!_currentSelectedIndexSize.contains(index)) {
                              _currentSelectedIndexSize.add(index);
                              sizes.add(size);
                            } else {
                              _currentSelectedIndexSize.remove(index);
                              sizes.removeAt(sizes
                                  .indexWhere(((size) => size.id == index)));
                            }
                          });
                        })),
                radius: 30,
                backgroundColor: WeezlyColors.primary,
              )
            ],
          )
        ],
      ),
    );
  }

  Column _buildDateOrTime(String label, TextEditingController controller,
      String hintText, String type, String typeTime, bool departure) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Expanded(
            child: GestureDetector(
          onTap: type == 'date'
              ? () => _selectDate(context, controller, departure)
              : () => _selectTime(context, controller, departure),
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
                if (value == null || value.isEmpty) {
                  return "Veuillez renseigner une valeur";
                }
                return null;
              },
            ),
          ),
        )),
      ],
    );
  }

  TextFormField _field(
      String type, String label, TextEditingController controller,
      {String field = 'field'}) {
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
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputType != TextInputType.multiline
          ? TextInputAction.next
          : TextInputAction.newline,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        labelText: label,
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
          return "Veuillez renseigner une valeur";
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
      onPressed: () {
        Navigator.pushNamed(context, '/');
      },
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

Widget _buildPopupSavedCarrierAnnounce(BuildContext context, Announce? announce) {
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
              children: [
                Icon(
                  WeezlyIcon.check_circle,
                  size: 60,
                  color: Colors.green,
                )
              ],
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
                  onPressed: () => Navigator.pushNamed(context, AnnounceDetail.routeName, arguments: announce),
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
                  onPressed: () => Navigator.pushNamed(context, Search.routeName,
                      arguments: 'transfer'),
                  child: const Text("TROUVER UN COLIS"),
                ),
              ),
            ]),
          ]),
    ),
  );
}

