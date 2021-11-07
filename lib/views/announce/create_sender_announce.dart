import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Address.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/Package.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/announce/createSenderAnnounce.dart';
import 'package:weezli/service/announce/findAllSizes.dart';
import 'package:weezli/views/search/search.dart';
import 'package:weezli/widgets/build_loading_screen.dart';
import 'package:weezli/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/widgets/travelMode.dart';
import 'announce_detail.dart';

class CreateSenderAnnounce extends StatefulWidget {
  static const routeName = '/sender-announce';

  @override
  _CreateSenderAnnounceState createState() => _CreateSenderAnnounceState();
}

class _CreateSenderAnnounceState extends State<CreateSenderAnnounce> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _dateDepartureCtrl = TextEditingController();
  var _placeDepartureCtrl = TextEditingController();
  var _countryDepartureCtrl = TextEditingController();
  var _placeArrivalCtrl = TextEditingController();
  var _countryArrivalCtrl = TextEditingController();
  var _weightCtrl = TextEditingController();
  var _descriptionCtrl = TextEditingController();
  DateTime dateDeparture = DateTime.now();
  List<int> _currentSelectedIndexSize = [];
  List<PackageSize> sizes = [];
  List <File> imgList = [];
  final picker = ImagePicker();
  int activeIndex = 0;

  pickImageFromGallery() async {
    var number = "5";

    if(_compteurImage().toString() != number) {
      final image = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        imgList.add(File(image!.path));
      });
    }
  }

  Future<List<PackageSize>> getSizes() async {
    List<PackageSize> sizes = await findAllSizes();
    return sizes;
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
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
      dateDeparture = picked;
    }
  }

  _saveSenderAnnounce(User user) async {
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
          datetimeDeparture: dateDeparture,
          size: sizes,
          kgAvailable: double.parse(_weightCtrl.text),
          addressArrival: Address(
              city: _placeArrivalCtrl.text, country: _countryArrivalCtrl.text),
        ),
        type: 1,
        userAnnounce: user,

      );
      var response = await createSenderAnnounce(announce, imgList);
      var mapAnnounce = AnnouncesListDynamic.fromJson(jsonDecode(response.body)).announcesListDynamic;
      Announce newAnnounce = Announce.fromJson(mapAnnounce);

      showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildPopupSavedSenderAnnounce(context, newAnnounce, user),
      );
      _formKey.currentState!.save();
    }
    else return;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(title: Text('Informations du colis'));
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Column(children: [
          Column(
            children: <Widget>[
              Container(
                color: Color(0xE5E5E5),
                height: height * 0.9,
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Complétez le formulaire pour expédier votre colis',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: height * 0.02),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _field(
                                'text', 'Ville de départ', _placeDepartureCtrl),
                            _field('text', 'Pays de départ',
                                _countryDepartureCtrl),
                            SizedBox(height: height * 0.03),
                            _field('text', 'Ville de destination',
                                _placeArrivalCtrl),
                            _field('text', 'Pays de destination',
                                _countryArrivalCtrl),
                            SizedBox(height: height * 0.05),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date limite d'expédition",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    "Poids approximatif en kg :",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ]),
                            Row(children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () =>
                                    _selectDate(context, _dateDepartureCtrl),
                                child: AbsorbPointer(
                                    child: TextFormField(
                                  style: TextStyle(height: 0),
                                  controller: _dateDepartureCtrl,
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Veuillez renseigner une valeur";
                                    }
                                    return null;
                                  },
                                )),
                              )),
                              SizedBox(width: 50),
                              Expanded(
                                  child: TextFormField(
                                style: TextStyle(height: 0),
                                controller: _weightCtrl,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Veuillez renseigner une valeur";
                                  }
                                  return null;
                                },
                              ))
                            ]),
                            SizedBox(height: height * 0.05),
                            Text(
                              "Dimensions",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
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
                            SizedBox(height: height * 0.01),
                            _field('textarea', 'Description', _descriptionCtrl),
                            SizedBox(height: height * 0.03),
                            if(imgList.length < 5)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                            ElevatedButton (
                              onPressed: pickImageFromGallery,
                              child:
                                Text ("Ajouter une image"),
                            )],
                            ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Photos (" +_compteurImage() +"/5) : ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold,)
                                  ),
                                ],
                             ),
                            SizedBox(height: height * 0.03),
                            if(imgList.length != 0)
                              Row(
                                children: [
                                  _image(0, user),
                                  SizedBox(width: 10,),
                                  _image(1, user)
                                  ],
                              ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                _image(2, user),
                                SizedBox(width: 10,),
                                _image(3, user)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                _image(4, user), // Affiche chaque image de la liste d'image
                              ],
                            )
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
                      onPressed: () => _saveSenderAnnounce(user),
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
          )
        ])));
  }

  // Affiche le nombre d'image dans la liste d'image
  _compteurImage(){
    var compteur = imgList.length;
      if (compteur <= 5) {
        return compteur.toString();
      }else if( compteur > 5){
      compteur = 5;
      return compteur.toString();
    }
    compteur = 0;
    return compteur.toString();
}

// Affiche une image
  _image(int number, User user){
    if (imgList.isNotEmpty && number <= imgList.length-1) {
      return GestureDetector(
      onTap: () => _deleteImage(context, number, user),
      child: Image.file(
        imgList[number],
        width: MediaQuery.of(context).size.width * 0.41,
        height: MediaQuery.of(context).size.height * 0.15,
        fit: BoxFit.cover,
          )
      );
    }
    return Row(
        children:[]
    );
  }

  _deleteImage(BuildContext context, int number, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          _buildPopupDeleteImage(context, number, user),
    );
  }

  _buildPopupDeleteImage(BuildContext context, int number, User user){
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
                children: [CustomTitle("SUPPRESSION IMAGE")],
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
                      onPressed: () =>
                      {
                        imgList.remove(imgList[number]),
                        Navigator.pop(context),
                      },
                    child: const Text("SUPPRIMER"),
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
                      onPressed: () => Navigator.pop(context),
                      child: const Text("ANNULER"),
                  ),
                ),
              ]),
            ]),
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

Widget _buildPopupSavedSenderAnnounce(BuildContext context, Announce? announce, User user) {
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
                  onPressed: () => Navigator.pushNamed(context, AnnounceDetail.routeName, arguments:{
                    'announce': announce,
                    'idUser': user.id
                  },),
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
                      arguments: 'sending'),
                  child: const Text("TROUVER UN TRANSPORTEUR"),
                ),
              ),
            ]),
          ]),
    ),
  );
}
