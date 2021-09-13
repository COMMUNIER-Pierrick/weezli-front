import 'package:weezli/commons/colorSwatch.dart';
import 'package:flutter/material.dart';

Future openDatePicker(BuildContext context, Function selectDate,
    {String? typeTime}) {
  return showDatePicker(
    context: context,
    locale: Locale('fr'),
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 30),
  ).then(
    (pickedDate) {
      if (pickedDate == null) {
        return;
      }
      typeTime != null
          ? selectDate(pickedDate, typeTime)
          : selectDate(pickedDate);
    },
  );
}

Future openTimePicker(
    BuildContext context, Function selectTime, String typeTime) {
  return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext ctx, child) {
        return Theme(
          data: ThemeData(
            primarySwatch: generateMaterialColor(
              Color.fromRGBO(20, 37, 83, 1),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      }).then(
    (pickedTime) {
      if (pickedTime == null) {
        return;
      }
      selectTime(pickedTime, typeTime);
    },
  );
}
