import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/announce/findByType.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/views/announce/create_carrier_announce.dart';
import 'package:weezli/views/announce/create_sender_announce.dart';
import 'package:weezli/views/search_results.dart';
import 'package:weezli/widgets/build_loading_screen.dart';
import 'package:weezli/widgets/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './search_filter.dart';
import '../../commons/weezly_icon_icons.dart';

class Search extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Announce> announcesList = [];

  DateTime _selectedDate = DateTime.now();
  Map<String, String?> _filters = {
    'size': null,
    'weight': null,
    'travelMode': null
  };
  Map<String, dynamic> _search = {
    'start': '',
    'landing': '',
    'date': '',
    'filter': null,
    'searchType': null
  };
  String? searchType; // == sending || transfer

  @override
  void didChangeDependencies() {
    searchType = ModalRoute.of(context)!.settings.arguments as String?;
    _search = {
      'start': '',
      'landing': '',
      'date': DateTime.now().toString(),
      'filter': _filters,
      'searchType': searchType
    };
    super.didChangeDependencies();
  }

  final _form = GlobalKey<FormState>();

  InputDecoration _textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: WeezlyColors.blue5),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: WeezlyColors.blue5),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: WeezlyColors.blue5),
      ),
    );
  }

  void _selectDate(DateTime dateSelected) {
    setState(() => _selectedDate = dateSelected);
  }

  void _setFilters(filterData) {
    setState(() => _filters = filterData);
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    _search = {
      'start': _search['start'],
      'landing': _search['landing'],
      'date': _selectedDate.toString(),
      'filter': _filters,
      'type': searchType, // == sending || transfer
    };
    Navigator.pushNamed(context, '/resultat', arguments: _search);
  }


  Future _createAnnounce() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    if (user != null) {
      searchType == "sending"
          ? Navigator.pushNamed(context, CreateSenderAnnounce.routeName, arguments: user)
          : Navigator.pushNamed(context, CreateCarrierAnnounce.routeName, arguments: user);
    }
    else Navigator.pushNamed(context, "/login");
  }

  Future<List<Announce>> getAnnouncesList() async {
    String? searchType = ModalRoute.of(context)!.settings.arguments as String?;
    int type;
    searchType == "sending" ? type = 2 : type = 1;
    announcesList = await findByType(type);
    return announcesList;
  }

  Future<User?> getActualUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    return user;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(searchType == "sending"
            ? "Recherche transporteur"
            : "Recherche paquet"),
        backgroundColor: /*searchType == "sending" ? WeezlyColors.blue2:*/ WeezlyColors
            .yellowgreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                /*gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: //Theme.of(context).primaryColor,
                    searchType == "sending" ? [WeezlyColors.blue3,  WeezlyColors.yellow,] : [WeezlyColors.yellow,  WeezlyColors.blue2,]
                ),*/
                color: /*searchType == "sending" ? WeezlyColors.yellowgreen:*/ WeezlyColors
                    .blue6,
              ),
              // color: Gradient() Theme.of(context).primaryColor,
              height: 320,
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration:
                            _textFieldDecoration('Ville ou pays de départ'),
                        style: TextStyle(color: WeezlyColors.blue5),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                        onSaved: (value) => _search = {
                          'start': value,
                          'landing': _search['landing'],
                          'date': _search['date'],
                          'filter': _search['filter'],
                        },
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: _textFieldDecoration(
                            'Ville ou pays de destination'),
                        style: TextStyle(color: WeezlyColors.blue5),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                        onSaved: (value) => _search = {
                          'start': _search['start'],
                          'landing': value,
                          'date': _search['date'],
                          'filter': _search['filter'],
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == DateTime.now()
                                ? DateFormat.yMd('fr')
                                    .format(DateTime.now())
                                    .toString()
                                : DateFormat.yMd('fr')
                                    .format(_selectedDate)
                                    .toString(),
                            style: TextStyle(color: WeezlyColors.blue5),
                          ),
                          IconButton(
                            onPressed: () =>
                                openDatePicker(context),
                            icon: Icon(
                              WeezlyIcon.calendar2,
                              color: WeezlyColors.blue5,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchFilter(_setFilters),
                              ),
                            ),
                            icon: Icon(
                              WeezlyIcon.calendar,
                              color: WeezlyColors.blue5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (_filters['size'] != null)
                              _displayTextFilter(
                                  'Dimension : ${_filters['size']}'),
                            Spacer(),
                            if (_filters['weight'] != null)
                              _displayTextFilter(
                                  'Poids : ${_filters['weight']}'),
                          ],
                        ),
                        //SizedBox(height: 20),
                        if (_filters['travelMode'] != null)
                          _displayTextFilter(
                              'Moyen de transport : ${_filters['travelMode']}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: _saveForm,
                  child: Text('Rechercher'.toUpperCase()),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: /*searchType == "sending" ? WeezlyColors.blue2:*/ WeezlyColors
                        .yellowgreen,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 11),
                    elevation: 5,
                  )),
            ])),
            Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: _createAnnounce,
                  child: Text('Créer une annonce'.toUpperCase()),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: /*searchType == "sending" ? WeezlyColors.blue2:*/ WeezlyColors
                        .blue6,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 11),
                    elevation: 5,
                  )),
            ])),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "Annonces récentes",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(children: [
              FutureBuilder(
                  future: Future.wait([getAnnouncesList(), getActualUser()]),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      List<Announce> announcesList =
                          snapshot.data![0] as List<Announce>;
                      User user = snapshot.data![1] as User;
                      return Container(
                          child: Column(children: [
                        for (Announce announce in announcesList)
                          SearchResults().oneResult(context, announce, user)
                      ]));
                    }
                    else
                      return buildLoadingScreen();
                  }),
            ]),
          ],
        ),
      ),
    );
  }

  Text _displayTextFilter(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  }
}
