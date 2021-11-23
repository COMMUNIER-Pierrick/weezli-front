import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Order.dart';
import 'package:flutter/material.dart';
import 'package:weezli/service/order/findOrdersByUserCarrier.dart';
import 'package:weezli/widgets/build_loading_screen.dart';

import 'delivery_details.dart';

class SearchDeliveries extends StatefulWidget {
  const SearchDeliveries({Key? key}) : super(key: key);
  static const String routeName = "/search-deliveries";

  @override
  _SearchDeliveriesState createState() => _SearchDeliveriesState();
}

class _SearchDeliveriesState extends State<SearchDeliveries> {
  final TextEditingController _searchController = TextEditingController();
  List listOrders = [];

  Future<List<Order>> getOrdersList(int idUser) async {
    return listOrders = await findOrdersByUserCarrier(idUser);
  }

  @override
  Widget build(BuildContext context) {
    final idUser = ModalRoute.of(context)!.settings.arguments as int;
    final Size _mediaQuery = MediaQuery.of(context).size;
    final Container _searchBar = Container(
      padding: EdgeInsets.only(
        bottom: 15.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              width: _mediaQuery.width * 0.8,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Recherche",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: WeezlyColors.blue3),
                  ),
                  suffixIcon: Icon(
                    WeezlyIcon.search,
                    color: WeezlyColors.white,
                  ),
                ),
              ),
            ),
          ),
          Icon(
            WeezlyIcon.calendar,
            color: WeezlyColors.white,
          ),
        ],
      ),
    );

    GestureDetector _cardOrder(Order order, int idUser) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, DeliveryDetail.routeName,
            arguments: {
              'order': order,
              'userId': idUser
            },),
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          width: _mediaQuery.width,
          decoration: BoxDecoration(
            color: WeezlyColors.grey1,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(order.announce.package.addressDeparture.city),
                  Icon(Icons.arrow_right_alt),
                  Text(order.announce.package.addressArrival.city),
                  Spacer(),
                  Icon(
                    WeezlyIcon.arrow_right_square,
                    color: WeezlyColors.primary,
                  ),
                ],
              ),
              Divider(
                color: WeezlyColors.black,
              ),
              Text(
                "Description:",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                order.announce.package.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    WeezlyIcon.calendar2,
                    color: WeezlyColors.primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(format(order.announce.package.datetimeDeparture)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Montant: ",
                          style: Theme.of(context).textTheme.headline5),
                      Text(
                        order.announce.price.toString() + "€",
                      ),
                    ],
                  ),
                 _status(order.status.name),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes livraisons"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: _searchBar,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder(
                  future: getOrdersList(idUser),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      List<Order> _listOrders = snapshot.data as List<Order>;
                      return Column(
                        children: [
                          for (Order item in _listOrders) _cardOrder(item, idUser),
                        ],
                      );
                    } else
                      return buildLoadingScreen();
                  }),
            )
          ],
        ),
      ),
    );
  }

  _status(String statut){
    if(statut == "En cours"){
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.yellow,
              ),
              SizedBox(width: 10),
              Text(statut),
            ]
            )]
      );
    }else if (statut == "Livré"){
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.orange,
              ),
              SizedBox(width: 10),
              Text(statut),
            ]
            )]
      );
    }else if (statut == "Terminé"){
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.green,
              ),
              SizedBox(width: 10),
              Text(statut),
            ]
            )]
      );
    }
  }
}


