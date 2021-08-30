
import 'package:baloogo/service/formule/read_one.dart';
import 'package:baloogo/commons/weezly_colors.dart';
import 'package:flutter/material.dart';
import 'package:baloogo/model/formules.dart';
import 'package:baloogo/service/formule/create_formule.dart';
import 'package:baloogo/service/formule/read_all.dart';

class FormulesView extends StatefulWidget{
  
  @override
  FormulesViewState createState () => FormulesViewState();

}
class FormulesViewState extends State<FormulesView>{

//-------------------------------------   Début Brut pour apk sans DB   --------------------------------------------------------------------
Formules formule_1 = Formules(
    id: 1, 
    name: "un",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 5.0
  );
  Formules formule_2 = Formules(
    id: 2, 
    name: "deux",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 15.0
  );
  Formules formule_3 = Formules(
    id: 3, 
    name: "trois",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 30.0
  );
  Formules formule_4 = Formules(
    id: 4, 
    name: "quatre",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esseillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    price: 40.0
  );
//-------------------------------------   Fin Brut pour apk sans DB   --------------------------------------------------------------------
  
  List<Formules> formulesList = [];
  late Future<List<Formules>> formulesListe;
  var status_code = null;

  List<Widget> formulesListWidget = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formulesListe = readAllFormules();
    print(formulesListe);
  }

  @override
  Widget build(BuildContext context) {
    //-------------------------------------   Début Brut pour apk sans DB   --------------------------------------------------------------------
    formulesList = [formule_1, formule_2, formule_3, formule_4];
    if(formulesListWidget.isEmpty) {allFormulesBrut();}
    //-------------------------------------   Fin Brut pour apk sans DB   --------------------------------------------------------------------
    if(formulesListWidget.isEmpty) {allFormules();}
    return Scaffold(
      appBar: AppBar(title: Text("Formules"), backgroundColor: WeezlyColors.green,),
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
              ...formulesListWidget,
            ],
          ),
        ),
    );
  }
  //-------------------------------------   Début Brut pour apk sans DB   --------------------------------------------------------------------
allFormulesBrut(){
    formulesList.forEach((formule) { 
      formulesListWidget.add(cardFormule(formule));
    });
  }
//-------------------------------------   Fin Brut pour apk sans DB   --------------------------------------------------------------------
  allFormules(){
    formulesListe.then((value) {
      value.forEach((formule) { 
        setState(() {
          formulesListWidget.add(cardFormule(formule));
        });
      });
    });
  }

  Widget cardFormule(Formules formule){
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
              "Formule ${formule.name}",
              style: TextStyle(color: Theme.of(context).buttonColor, fontSize: 25, fontWeight: FontWeight.bold,)
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(formule.description),
            ),
            /*Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [*/
                Text.rich( 
                  TextSpan(
                    text: "${formule.price}€",
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