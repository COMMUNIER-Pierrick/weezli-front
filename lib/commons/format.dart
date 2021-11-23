import 'package:intl/intl.dart';

String format(date) {
  String formattedDate = DateFormat.yMMMMd('fr_fr').format(date) +
      ' - ' +
      DateFormat.Hm('fr_fr').format(date);
  return formattedDate;
}

String formatDate(date) {
  String formattedDate = DateFormat.yMd('fr_fr').format(date);
  return formattedDate;
}

String format2(date) {
  String formattedDate = DateFormat.yMMMMd('fr_fr').format(date);
  return formattedDate;
}