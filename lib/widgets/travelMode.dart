import 'package:weezli/commons/filter_datas.dart';
import 'package:weezli/widgets/custom_radio.dart';
import 'package:flutter/material.dart';

var travelMode = ValueNotifier('');

class TravelMode extends StatefulWidget {
  final Color? color;
  final double? heightPerCentage;
  final Color? textColor;
  TravelMode(this.color, this.textColor, this.heightPerCentage);

  resetTravelMode() => createState().resetTravelMode();
  @override
  TravelModeState createState() => TravelModeState();
}

class TravelModeState extends State<TravelMode> {
  void _setSelected(dynamic userSizeFilter, String type) {
    setState(() => travelMode.value = userSizeFilter);
  }

  void resetTravelMode() {
    travelMode.value = '';
    travelModes.forEach((element) => element.isSelected = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    resetTravelMode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * widget.heightPerCentage! * 0.8,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: travelModes.length,
          itemBuilder: (context, index) {
            return _buildRadio(travelModes[index], travelModes, 'travelModes',
                context, widget.color!);
          },
        ),
      ),
    );
  }

  Container _buildRadio(
      items, listChanging, String type, BuildContext context, Color color) {
    return Container(
        height: 43,
        width: 95,
        margin: EdgeInsets.only(right: 10, top: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(
                () {
                  listChanging.forEach((element) {
                    if (items != element) element.isSelected = false;
                  });
                  if (items.isSelected) {
                    items.isSelected = false;
                    _setSelected('', type);
                  } else {
                    items.isSelected = true;
                    _setSelected(items.text, type);
                  }
                },
              ),
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(21.5),
              child: CustomRadio(
                item: items,
                type: type,
                colorBackground: color,
                colorIcon: Colors.white,
                colorBorder: Colors.transparent,
                sizeRow: false,
              ),
            ),
            Text(items.text, style: TextStyle(color: widget.textColor))
          ],
        ));
  }
}
