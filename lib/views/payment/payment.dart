import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weezli/commons/weezly_colors.dart';

class PaymentView extends StatefulWidget{
  @override
  PaymentViewState createState() => PaymentViewState();
}

class PaymentViewState extends State<PaymentView>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Paiement et transaction"), backgroundColor: WeezlyColors.green,),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Ici se trouvera la listes des transactions!")
            ],
          ),
        ),
      ),
    );
  }
}