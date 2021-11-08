
import 'package:weezli/model/Choice.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:flutter/material.dart';
import 'package:weezli/service/Formule/create_Formule.dart';
import 'package:weezli/service/Formule/read_all.dart';
import 'package:http/http.dart' as http;

class FormuleView extends StatefulWidget{


  @override
  FormuleViewState createState () => FormuleViewState();

}
class FormuleViewState extends State<FormuleView>{

  final _controller = TextEditingController();
  late String _tf = "";
  String valeur = "";

  String choice = "";

  bool dataOk = false;
  List list = [];
  List<Choice> _choiceList = [];

  Future<List<Choice>> getAllFormules() async {
    _choiceList = await readAllFormules();
    _choiceList.forEach((Choice) {
      setState(() {
        choiceListWidget.add(cardFormule(Choice));
      });
    });
    return _choiceList;
  }

  var status_code = null;

  List<Widget> choiceListWidget = [];


  @override
  void initState() {
    getAllFormules();
    super.initState();
  }

  _readResult(){
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Formule"), backgroundColor: WeezlyColors.green,),
      body: SingleChildScrollView(
        child: Container(
        alignment: Alignment.center,
          child: Column(
          children: [
            ElevatedButton(
                onPressed: ()  {
                  status_code = createFormule("nom", "une pztitz descroi^trepon ça fait pas de mal, juste enlever les fautes d'orthographe", 10.5);
                  print(status_code);
                },
                child: Text("Ajouter Formule DB"),
            ),
            ...choiceListWidget,
          ],
        ),
        ),
      ),
    );
  }


  Widget cardFormule(Choice Choice){
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
                "Formule ${Choice.name}",
                style: TextStyle(color: Theme.of(context).buttonColor, fontSize: 25, fontWeight: FontWeight.bold,)
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Text.rich(
                TextSpan(
                    text: "${Choice.price}€",
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
              onPressed: () => {
             // _tf = "${Choice.id_payment}";
              _readResult()
              },
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