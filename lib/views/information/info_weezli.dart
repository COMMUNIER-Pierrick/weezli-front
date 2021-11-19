import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weezli/commons/weezly_colors.dart';

class InfoWeezliView extends StatefulWidget{
  @override
  InfoWeezliViewState createState() => InfoWeezliViewState();
}

class InfoWeezliViewState extends State<InfoWeezliView>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Comment ça marche"), backgroundColor: WeezlyColors.green,),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Nous vous expliquons ici comment ca marche!")
            ],
          ),
        ),
      ),
    );
  }
}