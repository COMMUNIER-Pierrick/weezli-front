
import 'package:weezli/commons/weezly_colors.dart';
import 'package:flutter/material.dart';
import '../model/filter.dart';

class CustomRadio extends StatelessWidget {
  final SizeRadioModel item;
  final String type;
  final Color colorBackground;
  final Color? colorIcon;
  final Color? colorContainer;
  final Color colorBorder;
  final bool sizeRow;

  CustomRadio(
      {required this.item,
      required this.type,
      required this.colorBackground,
      this.colorIcon,
      this.colorContainer,
      required this.colorBorder,
      required this.sizeRow});

  @override
  Widget build(BuildContext context) {
    return type == 'travelModes'
        ? Stack(alignment: Alignment.center, children: [
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: item.isSelected
                    ? Color.fromRGBO(0, 136, 186, 1)
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              left: -5,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: colorBackground, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              child: Icon(
                item.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ])
        : Container(
            width: type == 'size' ? 70 : null,
            height: type == 'size' ? 70 : null,
            child: type == 'size'
                ? Icon(
                    item.icon,
                    color: sizeRow && item.isSelected
                        ? WeezlyColors.blue3
                        : colorIcon,
                    size: item.sizeIcon,
                  )
                : Center(
                    child: Text(
                      item.text,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
            decoration: BoxDecoration(
              color: item.isSelected && !sizeRow
                  ? Color.fromRGBO(0, 136, 186, 1)
                  : colorBackground,
              border: Border.all(
                  width: 1,
                  color: sizeRow && item.isSelected
                      ? WeezlyColors.blue3
                      : !sizeRow && item.isSelected
                          ? Colors.transparent
                          : colorBorder),
              shape: type == 'size' ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: type != 'size'
                  ? BorderRadius.all(Radius.circular(110.0))
                  : null,
            ),
          );
  }
}
