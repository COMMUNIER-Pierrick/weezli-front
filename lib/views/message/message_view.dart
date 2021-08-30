import 'dart:core';

import 'package:flutter/material.dart';
import '../../commons/weezly_icon_icons.dart';
import '../../commons/weezly_colors.dart';

class MessageView extends StatefulWidget {
  static const routeName = "/messages";

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  bool transporteur = true;

  List<List<String>> messagesList = [
    [
      "other",
      "Bonjour, j'aimerais solliciter Bonjour, j'aimerais solliciter votre aide pour transporter mon colis et si possible j’aimerais faire une contre proposition"
    ],
    [
      "other",
      "Bonjour, j'aimerais solliciter Bonjour, j'aimerais solliciter votre aide pour transporter mon colis et si possible j’aimerais faire une contre proposition"
    ],
    ["me", "Bonjour, bien sur à votre service"],
    ["other", "Bonjour, bien sur à votre service"],
    ["me", "Bonjour, bien sur à votre service"],
    ["other", "Bonjour, bien sur à votre service"],
    ["me", "Bonjour, bien sur à votre service"],
    ["other", "Bonjour, bien sur à votre service"],
    ["me", "Bonjour, bien sur à votre service"],
    ["other", "Bonjour, bien sur à votre service"],
    ["me", "Bonjour, bien sur à votre service"],
    ["other", "Bonjour, bien sur à votre service"],
    ["me", "Bonjour, bien sur à votre service"],
    ["other", "Bonjour, bien sur à votre service"],
    [
      "me",
      "Bonjour, j'aimerais solliciter votre aide pour transporter mon colis et si possible j’aimerais faire une contre proposition"
    ],
    [
      "other",
      "Bonjour, j'aimerais solliciter votre aide pour transporter mon colis et si possible j’aimerais faire une contre proposition"
    ],
  ];
  List<Widget> messagesWidgetList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.5,
        flexibleSpace: Container(height: 202,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10,),
            person(),
            Divider(thickness: 2,),
            listMessages(),
            SizedBox(height: 10,),
            sendLine(),
          ],
        ),
      ),
    );
  }

  Widget person() {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left)),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 20, //MediaQuery.of(context).size.width/15,
              foregroundImage: NetworkImage(
                  "https://images.assetsdelivery.com/compings_v2/macrovector/macrovector1901/macrovector190100030.jpg"),
            ),
            Icon(
              WeezlyIcon.check_circle,
              size: 10,
              color: WeezlyColors.green,
            )
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Melinda Rochel",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(
                    transporteur
                        ? WeezlyIcon.delivery
                        : WeezlyIcon.paper_plane_empty,
                    color: transporteur ? WeezlyColors.black : WeezlyColors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    transporteur ? "Transporteur" : "Colis",
                    style: TextStyle(
                        color: transporteur ? WeezlyColors.black : WeezlyColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: transporteur ? WeezlyColors.yellow : Theme.of(context).buttonColor,
                  borderRadius: BorderRadiusDirectional.horizontal(
                      end: Radius.circular(20))),
            )
          ],
        )
      ],
    );
  }

  Widget sendIcon() {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        WeezlyIcon.paper_plane_empty,
        color: WeezlyColors.white,
      ),
    );
  }

  Widget carryIcon() {
    return CircleAvatar(
      backgroundColor: WeezlyColors.yellow,
      child: Icon(
        WeezlyIcon.delivery,
        color: WeezlyColors.white,
      ),
    );
  }

  Widget sendLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          child: Text(
            "€",
            style: TextStyle(
                fontSize: 18, color: WeezlyColors.white, fontWeight: FontWeight.w900),
          ),
          radius: 12,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        Container(
          child: TextField(
              minLines: 1,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                )
              ),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 30,
        ),
        Icon(
          Icons.send,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }

  Widget listMessages() {
    return Container(
      height: MediaQuery.of(context).size.height - 240,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: messagesList.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            margin: messagesList[index][0].contains("me")
                ? EdgeInsets.only(right: 50)
                : EdgeInsets.only(left: 50),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: messagesList[index][0].contains("me")
                  ? WeezlyColors.grey1
                  : WeezlyColors.blue6, 
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('${messagesList[index][1]}'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
      )
    );
  }
}
