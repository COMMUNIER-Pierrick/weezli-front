import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Proposition.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/proposition/findAll.dart';
import 'package:flutter/material.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/widgets/build_loading_screen.dart';

class SearchPropositions extends StatefulWidget {
  const SearchPropositions({Key? key}) : super(key: key);
  static const String routeName = "/all-proposition";

  @override
  _SearchPropositionsState createState() => _SearchPropositionsState();
}

class _SearchPropositionsState extends State<SearchPropositions> {
  final TextEditingController _searchController = TextEditingController();

  List listPropositions = [];

  Future<List<Proposition>> getPropositionsList() async {
    return listPropositions = await findAll();
  }

  Future<User?> getActualUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final Container _searchBar = Container(
      padding: EdgeInsets.only(
        bottom: 15.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              width: _mediaQuery.width * 0.8,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Recherche",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: WeezlyColors.blue3),
                  ),
                  suffixIcon: Icon(
                    WeezlyIcon.search,
                    color: WeezlyColors.white,
                  ),
                ),
              ),
            ),
          ),
          Icon(
            WeezlyIcon.calendar,
            color: WeezlyColors.white,
          ),
        ],
      ),
    );

    GestureDetector _cardProposition(Proposition proposition, int idUser) {
      return GestureDetector(
          onTap: () {
            /*Navigator.pushNamed(context, PropositionDetail.routeName,
                arguments: {
                  'proposition': proposition,
                  'idUser': idUser
                },);*/
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            width: _mediaQuery.width,
            decoration: BoxDecoration(
              color: WeezlyColors.grey1,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //Text(order.announce.package.addressDeparture.city),
                    Icon(Icons.arrow_right_alt),
                    //Text(order.announce.package.addressArrival.city),
                    Spacer(),
                    Icon(
                      WeezlyIcon.arrow_right_square,
                      color: WeezlyColors.primary,
                    ),
                  ],
                ),
                Divider(
                  color: WeezlyColors.black,
                ),
                Text(
                  "Description:",
                  style: Theme.of(context).textTheme.headline5,
                ),
                /*Text(
                  order.announce.package.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),*/
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      WeezlyIcon.calendar2,
                      color: WeezlyColors.primary,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //Text(format(order.announce.package.datetimeDeparture)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Montant : ",
                            style: Theme.of(context).textTheme.headline5),
                        Text(
                          proposition.proposition.toString() + "€",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _status(proposition.statusProposition.name)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Propositions"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: _searchBar,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder(
                  future: Future.wait([getPropositionsList(), getActualUser()]),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      List<Proposition> _listPropositions = snapshot.data![0] as List<Proposition>;
                      User user = snapshot.data![1] as User;
                      return Column(
                        children: [
                          for (Proposition item in _listPropositions) _cardProposition(item, user.id!),
                        ],
                      );
                    } else
                      return buildLoadingScreen();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _status(String statut){
    if(statut == "Proposition"){
      return Row(
        children: [
        Row(children: [
          Icon(
            Icons.circle,
            color: WeezlyColors.yellow,
          ),
          SizedBox(width: 10),
          Text("Proposition"),
          ]
        )]
      );
    }else if (statut == "Contre-proposition"){
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.orange,
              ),
              SizedBox(width: 10),
              Text("Contre-proposition"),
            ]
            )]
      );
    }else if (statut == "Validé"){
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.green,
              ),
              SizedBox(width: 10),
              Text("Validé"),
            ]
            )]
      );
    }else {
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.red,
              ),
              SizedBox(width: 10),
              Text("Refusé"),
            ]
            )]
      );
    }
  }
}

