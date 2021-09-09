import 'package:baloogo/views/announce/announce_detail.dart';
import 'package:baloogo/views/announce/announces.dart';
import 'package:baloogo/views/orders/colis_avis.dart';
import 'package:baloogo/views/deliveries/delivery_details.dart';
import 'package:baloogo/views/orders/order_details.dart';
import 'package:baloogo/views/deliveries/search_deliveries.dart';
import 'package:baloogo/views/orders/search_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:baloogo/commons/colorSwatch.dart';
import 'package:baloogo/views/account/opinions.dart';
import 'package:baloogo/views/account/email_verification.dart';
import 'package:baloogo/views/account/personal.dart';
import 'package:baloogo/views/account/phone_verification.dart';
import 'package:baloogo/views/paiement/paiement_view.dart';
import './commons/weezly_colors.dart';
import './views/announce/announce_detail.dart';
import './views/announce/create_carrier_announce.dart';
import './views/announce/create_sender_announce.dart';
import './views/authentication/login.dart';
import './views/authentication/register.dart';
import './views/formules/formules_view.dart';
import './views/home/bottom_menu.dart';
import './views/message/message_view.dart';
import './views/resultat_recherche.dart';
import './views/search/search.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('fr', ''),
      ],
      theme: ThemeData(
        primarySwatch: generateMaterialColor(WeezlyColors.primary),
        primaryColor: WeezlyColors.primary,
        buttonColor: WeezlyColors.blue2,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: WeezlyColors.primary,
                fontSize: 16,
              ),
              bodyText1: TextStyle(
                color: Colors.white,
              ),
              bodyText2: GoogleFonts.poppins(
                color: WeezlyColors.primary,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BottomMenu(),
        '/register': (context) => Register(),
        '/login': (context) => Login(),
        '/personal': (context) => Personal(),
        '/resultat': (context) => ResultatRecherche(),
        Search.routeName: (context) => Search(),
        MessageView.routeName: (context) => MessageView(),
        '/paiement': (context) => PaiementView(),
        '/formules': (context) => FormuleView(),
        '/users': (context) => FormuleView(),
        AnnounceDetail.routeName: (context) => AnnounceDetail(),
        '/avis': (context) => Opinions(),
        CreateCarrierAnnounce.routeName: (context) => CreateCarrierAnnounce(),
        CreateSenderAnnounce.routeName: (context) => CreateSenderAnnounce(),
        OrderDetail.routeName: (context) => OrderDetail(),
        DeliveryDetail.routeName: (context) => DeliveryDetail(),
        SearchOrders.routeName: (context) => SearchOrders(),
        SearchDeliveries.routeName: (context) => SearchDeliveries(),
        ColisAvis.routeName: (context) => ColisAvis(),
        EmailVerification.routeName: (context) => EmailVerification(),
        PhoneVerification.routeName: (context) => PhoneVerification(),
        Announces.routeName : (context) => Announces(),
       },
    ),
  );
}
