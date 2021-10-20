import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/order/findOrdersByUserSender.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/views/orders/order_details.dart';
import 'package:flutter/material.dart';
import 'package:weezli/widgets/build_loading_screen.dart';

class SearchOrders extends StatefulWidget {
  const SearchOrders({Key? key}) : super(key: key);
  static const String routeName = "/search-orders";

  @override
  _SearchOrdersState createState() => _SearchOrdersState();
}

class _SearchOrdersState extends State<SearchOrders> {
  final TextEditingController _searchController = TextEditingController();

  List listOrders = [];

  Future<List<Order>> getOrdersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    return listOrders = await findOrdersByUserSender(user!.id);
  }

  @override
  Widget build(BuildContext context) {
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

    GestureDetector _cardOrder(Order order) {
      return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, OrderDetail.routeName,
                arguments: order);
          },
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
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      WeezlyIcon.calendar2,
                      color: WeezlyColors.primary,
                      size: 15,
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
                        Text("Montant : ",
                            style: Theme.of(context).textTheme.headline5),
                        Text(
                          order.finalPrice.proposition.toString() + "€",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        order.status.name == "Payé"
                            ? Row(children: [
                                Icon(
                                  Icons.circle,
                                  color: WeezlyColors.yellow,
                                ),
                                SizedBox(width: 10),
                                Text("En cours"),
                              ])
                            : Row(children: [
                                Icon(
                                  Icons.circle,
                                  color: WeezlyColors.green,
                                ),
                                SizedBox(width: 10),
                                Text("Livré"),
                              ])
                      ],
                    ),
                  ],
                )
              ],
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes commandes"),
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
                  future: getOrdersList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      List<Order> _listOrders = snapshot.data as List<Order>;
                      return Column(
                        children: [
                          for (Order item in _listOrders) _cardOrder(item),
                        ],
                      );
                    } else
                      return buildLoadingScreen();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

