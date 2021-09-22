
import 'package:weezli/service/Formule/read_one.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:flutter/material.dart';
import 'package:weezli/model/Formule.dart';
import 'package:weezli/service/Formule/create_Formule.dart';
import 'package:weezli/service/Formule/read_all.dart';

class FormuleView extends StatefulWidget{
  
  @override
  FormuleViewState createState () => FormuleViewState();

}
class FormuleViewState extends State<FormuleView>{

//-------------------------------------   Début Brut pour apk sans DB   --------------------------------------------------------------------
Formule Formule_1 = Formule(
    id: 1, 
    name: "un",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 5.0
  );
  Formule Formule_2 = Formule(
    id: 2, 
    name: "deux",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 15.0
  );
  Formule Formule_3 = Formule(
    id: 3, 
    name: "trois",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 30.0
  );
  Formule Formule_4 = Formule(
    id: 4, 
    name: "quatre",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 40.0
  );
//-------------------------------------   Fin Brut pour apk sans DB   --------------------------------------------------------------------

  List<Formule> FormuleList = [];
  late Future <List<Formule>> FormuleListe;
  var status_code = null;

  List<Widget> FormuleListWidget = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FormuleListe = readAllFormules() as Future <List<Formule>>;
    print(FormuleListe);
  }

  @override
  Widget build(BuildContext context) {
    //-------------------------------------   Début Brut pour apk sans DB   --------------------------------------------------------------------
    FormuleList = [Formule_1, Formule_2, Formule_3, Formule_4];
    if(FormuleListWidget.isEmpty) {allFormuleBrut();}
    //-------------------------------------   Fin Brut pour apk sans DB   --------------------------------------------------------------------
    if(FormuleListWidget.isEmpty) {allFormule();}
    return Scaffold(
      appBar: AppBar(title: Text("Formule"), backgroundColor: WeezlyColors.green,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: ()  {
                  status_code = createFormule("nom", "une pztitz descroi^trepon ça fait pas de mal, juste enlever les fautes d'orthographe", 10.5);
                  print(status_code);
                },
                child: Text("Ajouter Formule DB")
            ),
            ...FormuleListWidget,
          ],
        ),
      ),
    );
  }
  //-------------------------------------   Début Brut pour apk sans DB   --------------------------------------------------------------------
  allFormuleBrut(){
    FormuleList.forEach((Formule) {
      FormuleListWidget.add(cardFormule(Formule));
    });
  }
//-------------------------------------   Fin Brut pour apk sans DB   --------------------------------------------------------------------
  allFormule(){
    FormuleListe.then((value) {
      value.forEach((Formule) {
        setState(() {
          FormuleListWidget.add(cardFormule(Formule));
        });
      });
    });
  }

  Widget cardFormule(Formule Formule){
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "Formule ${Formule.name}",
                style: TextStyle(color: Theme.of(context).buttonColor, fontSize: 25, fontWeight: FontWeight.bold,)
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              //child: Text(Formule.description),
            ),
            /*Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [*/
            Text.rich(
                TextSpan(
                    text: "${Formule.price}€",
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: " /mois",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15, fontStyle: FontStyle.italic)
                      ),
                    ]
                )
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'), // A MODIFIER !!!
              child: Text("SOUSCRIRE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30),
                primary: Theme.of(context).buttonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            /*],
            )*/
          ],
        ),
      ),
    );
  }

}