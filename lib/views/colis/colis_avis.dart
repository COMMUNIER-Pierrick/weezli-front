import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/views/colis/colis_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ColisAvis extends StatefulWidget {
  const ColisAvis({Key? key}) : super(key: key);
  static const routeName = '/colis-avis';

  @override
  _ColisAvisState createState() => _ColisAvisState();
}

class _ColisAvisState extends State<ColisAvis> {
  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final double _separator = 20;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes colis"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Donner un avis",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: _separator,
              ),
              RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                allowHalfRating: true,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: WeezlyColors.primary,
                  ),
                  half: Icon(
                    Icons.star_half,
                    color: WeezlyColors.primary,
                  ),
                  empty: Icon(
                    Icons.star_border,
                    color: WeezlyColors.primary,
                  ),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(
                height: _separator,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: WeezlyColors.grey1,
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: WeezlyColors.blue3,
                      ),
                    ),
                    labelText: "Partagez votre expérience",
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _separator,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.4,
                    height: 45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1,
                          color: WeezlyColors.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, ColisDetail.routeName);
                      },
                      child: Text(
                        "ANNULER",
                        style: TextStyle(
                          color: WeezlyColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _mediaQuery.width * 0.4,
                    height: 45,
                    child: RawMaterialButton(
                      fillColor: WeezlyColors.primary,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.5)),
                      onPressed: () {
                        Navigator.pushNamed(context, ColisDetail.routeName);
                      },
                      child: const Text(
                        "NOTER",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
