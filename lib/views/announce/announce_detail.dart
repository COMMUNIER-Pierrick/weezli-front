import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/sizesList.dart';
import 'package:weezli/model/Announce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weezli/service/announce/deleteAnnounce.dart';
import '../../commons/weezly_colors.dart';
import '../../commons/weezly_icon_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AnnounceDetail extends StatefulWidget {
  static const routeName = '/seller-announce-detail';

  @override
  _AnnounceDetail createState() => _AnnounceDetail();
}

class _AnnounceDetail extends State<AnnounceDetail> {
  double widthSeparator = 20;

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Announce announce= arg['announce'];
    int idUser= arg['idUser'];
    String? sizes = sizesList(announce.package.size); //Fonction qui retourne une chaîne de caractères avec tous les éléments de la liste
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
            onPressed: () => Navigator.pushNamed(context, '/mes_annonces', arguments: idUser)),
        title: Text("Détail"),
      ),
      body: Container(
          color: Color(0xE5E5E5),
          height: height * 0.9,
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _viewImage(announce),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(WeezlyIcon.card_plane,
                        color: WeezlyColors.blue3, size: 20),
                    SizedBox(width: widthSeparator),
                    Text(
                      announce.package.addressDeparture.city,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.arrow_right_alt),
                    Text(
                      announce.package.addressArrival.city,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                if (announce.type == 2)
                  Row(children: [
                    Text("Moyen de transport : "),
                    Text(announce.package.transportation!.name!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                Divider(
                  color: WeezlyColors.black,
                ),
                Row(children: [
                  Icon(WeezlyIcon.calendar2,
                      size: 20, color: WeezlyColors.blue3),
                  SizedBox(width: widthSeparator),
                  Text(announce.type == 2
                      ? "Date de départ : "
                      : "Date limite : "),
                  Text(format(announce.package.datetimeDeparture),
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 10),
                if (announce.type == 2)
                  Row(children: [
                    Icon(WeezlyIcon.calendar2,
                        size: 20, color: WeezlyColors.blue3),
                    SizedBox(width: widthSeparator),
                    Text("Date d'arrivée : "),
                    Text(format(announce.package.dateTimeArrival),
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
                SizedBox(height: 10),
                Row(children: [
                  Icon(WeezlyIcon.box, size: 20, color: WeezlyColors.blue3),
                  SizedBox(width: widthSeparator),
                  Text("Dimensions : "),
                  Text(sizes!, style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 10),
                Row(children: [
                  Icon(WeezlyIcon.kg, size: 20, color: WeezlyColors.blue3),
                  SizedBox(width: widthSeparator),
                  Text("Poids : "),
                  Text(announce.package.kgAvailable.toString() + " kg",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(WeezlyIcon.ticket,
                        size: 20, color: WeezlyColors.blue3),
                    SizedBox(width: widthSeparator),
                    Text("Commission de base : "),
                    Text(announce.price!.toString() + " €",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                  ]),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined,
                        size: 20, color: WeezlyColors.blue3),
                    SizedBox(width: widthSeparator),
                    Text("Nombre de vues : "),
                    Text(announce.views.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: 10),
                Row(children: [
                  Text("Description : ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 10),
                Row(children: [
                  Flexible(
                      child: Text(announce.package.description,
                          textAlign: TextAlign.justify))
                ]),
                SizedBox(height: 25),
                if(idUser == announce.userAnnounce.id)// Conditions incomplète attention
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          var response = await deleteAnnounce(announce.id);
                          if (response.statusCode == 200)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Annonce supprimée !')),
                            );
                          Navigator.pushNamed(context, '/mes_annonces', arguments: idUser);
                        },
                        child: Text(
                          "SUPPRIMER L'ANNONCE",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                          backgroundColor: WeezlyColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.5),
                          ),
                        ),
                    )]
                  ),
            ]),
          )),
    );
  }

  // Afficher les images sur la page
  Widget _viewImage(Announce announce){
    if (announce.type == 1 && announce.imgUrl != ''){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            CarouselSlider.builder(
              itemCount: _listImage(announce).length,
              options: CarouselOptions(
                height: 170,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
              itemBuilder: (context, index, realIndex) {
                final image = _listImage(announce)[index];
                return _buildImage(image);
              },
            ),
          SizedBox(height: 5),
          _buildIndicator(announce),
        ],
      );
    }else if(announce.type == 1 && announce.imgUrl == "no_picture.png") {
      return Container(
          alignment: Alignment.center,
          child:
          Image(
            image: AssetImage("assets/images/no_picture.png"),
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.height * 0.15,
            fit: BoxFit.cover,
          ),
      );
    }else{
      return Column();
    }
  }

  // Afficher une image dans mon caroussel
  Widget _buildImage(String image){
    return Container(
      color: Colors.grey,
      child: Image(
        image: NetworkImage('http://10.0.2.2:5000/images/' +
        image),
        width: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.15,
        fit: BoxFit.cover,
      ),
    );
  }

  // Indicateur de position sous les images
  Widget _buildIndicator(Announce announce) => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: _listImage(announce).length,
    effect: JumpingDotEffect(
      dotWidth: 10,
      dotHeight: 10,
    ),
  );

  //Récupération de la liste d'image
  _listImage(Announce announce) {
      List <String> listImage = announce.imgUrl!.split(",");
      return listImage;
  }
}