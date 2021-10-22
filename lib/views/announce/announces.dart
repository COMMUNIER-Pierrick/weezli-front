import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/announce/findAllByUser.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/views/account/profile.dart';
import 'package:weezli/views/announce/announce_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Announces extends StatefulWidget {
  @override
  AnnouncesState createState() => AnnouncesState();

  static const routeName = '/mes_annonces';
}

class AnnouncesState extends State<Announces> {
  final TextEditingController _searchController = TextEditingController();
  List<Announce> _listAnnounces = [];

  Future<List<Announce>> getAnnouncesList(int idUser) async {
    return _listAnnounces = await findAllByUser(idUser);
  }

  @override
  Widget build(BuildContext context) {
    final int idUser = ModalRoute.of(context)!.settings.arguments as int;
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

    GestureDetector _cardannounce(Announce announce, int idUser) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, AnnounceDetail.routeName,
            arguments: {
          'announce': announce,
          'idUser': idUser
          },),
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
              Row(children: [
                announce.type == 2
                    ? Text("Transport")
                    : Text("Expédition")
              ]),
              Row(children: [
                Text(announce.package.addressDeparture.city,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Icon(Icons.arrow_right_alt),
                Text(announce.package.addressArrival.city,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Spacer(),
                Icon(
                  WeezlyIcon.arrow_right_square,
                  color: WeezlyColors.primary,
                ),
              ]),
              Divider(
                color: WeezlyColors.black,
              ),
              Row(children: [
                Icon(WeezlyIcon.calendar2, size: 15),
                SizedBox(width: 5),
                announce.type == 2
                    ? Text("Date de départ : ")
                    : Text("Date limite : "),
                Text(format(announce.package.datetimeDeparture),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              if (announce.type == 2)
                Row(
                  children: [
                    Text("Moyen de transport : "),
                    Text(announce.package.transportation!.name!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              Row(children: [
                Text("Dimensions : "),
                Text(_sizes(announce),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              if (announce.type == 2)
                Row(
                  children: [
                    Text("Commission : "),
                    Text(announce.price!.toStringAsFixed(0) + " €",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
            onPressed: () => Navigator.pushNamed(context, Profile.routeName)),
        title: Text("Mes annonces"),
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
                    future: getAnnouncesList(idUser),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        List<Announce> _listAnnounces =
                            snapshot.data as List<Announce>;
                        return Column(
                          children: [
                            for (Announce item in _listAnnounces)
                              _cardannounce(item, idUser),
                          ],
                        );
                      } else
                        return buildLoadingScreen();
                    })),
          ],
        ),
      ),
    );
  }
}
