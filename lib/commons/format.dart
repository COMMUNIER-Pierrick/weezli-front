import 'package:intl/intl.dart';

String format(date) {
  String formattedDate = DateFormat.yMMMMd('fr_fr').format(date) +
      ' - ' +
      DateFormat.Hm('fr_fr').format(date);
  return formattedDate;
}