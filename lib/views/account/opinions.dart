
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Opinion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/opinion/findOpinionsReceivedByUser.dart';
import 'package:weezli/widgets/buildLoadingScreen.dart';

class Opinions extends StatefulWidget {
  const Opinions({Key? key}) : super(key: key);

  @override
  _AvisState createState() => _AvisState();
}

class _AvisState extends State<Opinions> {

  List<Opinion> listOpinions = [];

  Future<List<Opinion>> getOpinionsList(int idUser) async {
    listOpinions = await findOpinionsReceivedByUser(idUser);
    return listOpinions;
  }

  Future<User> userById(int idUser) async {
    User userComment = await userById(idUser);
    return userComment;
  }

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery
        .of(context)
        .size;
    final arg = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    User user = arg['User'];

    Widget _opinionCard(Opinion opinion) {

      int idUserComment = opinion.idUserOpinion;

      _userComment(int idUserComment) async{
        dynamic userComment = userById(idUserComment);
        return userComment;
      }

      dynamic userComment = _userComment(idUserComment) as User;
      print(userComment);

      return Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: userById(opinion.idUserOpinion),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  User userComment = snapshot.data as User;
                }
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/200'),
                          radius: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //opinion.order.announce.userAnnounce.firstname! +
                                " ", //+
                                //opinion.order.announce.userAnnounce.lastname!,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("",
                                    //opinion.order.announce.package.addressDeparture.city,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Icon(Icons.arrow_right_alt),
                                  Text("",
                                    //opinion.order.announce.package.addressArrival.city,
                                  ),
                                ],
                              ),
                              Text(opinion.comment ?? ""),
                              Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: WeezlyColors.yellow,
                                  borderRadius: BorderRadius.circular(22.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Icon(
                                      WeezlyIcon.star,
                                      size: 10,
                                    ),
                                    Text(opinion.number.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      color: WeezlyColors.grey2,
                    ),
                  ],
                );
              })
      ]));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Avis"),
      ),
      body: SingleChildScrollView(
          child: Column(
              children: [
                FutureBuilder(
                    future: getOpinionsList(user.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        List<Opinion> listOpinions = snapshot.data as List<Opinion>;
                        }
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              user.username!,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline5,
                            ),
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              padding: const EdgeInsets.all(10.0),
                              width: _mediaQuery.width * 0.50,
                              decoration: BoxDecoration(
                                border: Border.all(color: WeezlyColors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(22.5),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Avis: ",
                                    style: TextStyle(
                                      color: WeezlyColors.primary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: user.moyenneAvis!.toDouble(),
                                    direction: Axis.horizontal,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    allowHalfRating: true,
                                    itemSize: _mediaQuery.width < 321 ? 15 : 20,
                                    itemPadding: EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    itemBuilder: (context, _) =>
                                        Icon(
                                          Icons.star,
                                          color: WeezlyColors.yellow,
                                        ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Text(listOpinions.length.toString() + " avis"),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            for (Opinion opinion in listOpinions)_opinionCard(opinion)
                          ],
                        );
                    }),
              ])
      ),
    );
  }
}