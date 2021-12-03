
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Opinion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/user/userById.dart';
import 'package:weezli/widgets/buildLoadingScreen.dart';

class Opinions extends StatefulWidget {
  const Opinions({Key? key}) : super(key: key);

  @override
  _AvisState createState() => _AvisState();
}

class _AvisState extends State<Opinions> {

  Future<List<User>> getListUsersPostedOpinion(
      List<Opinion> listOpinions) async {
    List<User> listUsers = [];
    for (Opinion opinion in listOpinions) {
      User user = await userById(opinion.idUserOpinion);
      listUsers.add(user);
    }
    return listUsers;
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
    List<Opinion> listOpinions = arg["listOpinions"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Avis"),
      ),
      body: SingleChildScrollView(
          child: Column(
              children: [
                FutureBuilder(
                    future: getListUsersPostedOpinion(listOpinions),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        List<User> listUsersComment = snapshot.data as List<User>;
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
                              _affichageListOpinons(listOpinions, listUsersComment)
                            ]);
                      }else
                        return buildLoadingScreen();
                    }),
              ])
      ),
    );
  }

  Container _opinionCard(Opinion opinion, User userComment) {
    return Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
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
                        userComment.firstname! +
                            " " +
                            userComment.lastname!,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                      ),
                      Row(
                        children: [
                          _affichageRole(opinion)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(opinion.comment),
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
        ));
  }

  Widget _affichageListOpinons(List<Opinion> listOpinions, List<User> listUsersComment) {
    for (int i = 0; i < listOpinions.length; i++) {
      return _opinionCard(listOpinions[i], listUsersComment[i]);
    }
    return Row();
  }

  Widget _affichageRole(Opinion opinion){

    if(opinion.idTypes == 2){
      return Text("Transporteur",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
    }else{
      return Text("Expéditeur",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
    }
  }
}