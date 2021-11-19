import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weezli/commons/weezly_colors.dart';

class SupportView extends StatefulWidget{
  @override
  SupportViewState createState() => SupportViewState();
}

class SupportViewState extends State<SupportView>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Support"), backgroundColor: WeezlyColors.green,),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Nous contacter !"),
              Text("Nous pouvons mettre ici soit un moyen de support ou montrer les differents pays que l'app est supporté "),
            ],
          ),
        ),
      ),
    );
  }
}