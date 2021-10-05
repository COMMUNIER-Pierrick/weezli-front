import 'package:weezli/model/filter.dart';

import '../commons/filter_datas.dart';
import '../commons/weezly_colors.dart';
import 'package:weezli/widgets/custom_radio.dart';
import 'package:flutter/material.dart';

class Sizes extends StatefulWidget {
  resetSizes() => createState().resetSizes();
  @override
  _SizesState createState() => _SizesState();
}

class _SizesState extends State<Sizes> {
  List<String> _size = [];
  List<String> _setSelected(dynamic userSizeFilter) {
    if (_size.contains(userSizeFilter)) {
      _size.remove(userSizeFilter);
      return _size;
    }
    setState(() => _size.add(userSizeFilter));
    return _size;

  }

  void resetSizes() {
    _size = [];
    sizes.forEach((element) => element.isSelected = false);
  }

  @override
  void initState() {
    super.initState();
    resetSizes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  InkWell _buildSizes(SizeRadioModel item) {
    return InkWell(
      onTap: () => setState(
        () {
          item.isSelected = !item.isSelected;
          _setSelected(item.text);
        },
      ),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(100),
      child: CustomRadio(
        item: item,
        type: 'size',
        colorBackground: Color.fromRGBO(242, 242, 242, 1),
        colorIcon: Colors.black,
        colorBorder: Colors.black,
        sizeRow: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sizeRow = [];

    sizes.forEach((item) {
      sizeRow.add(
        Expanded(
          child: Container(
            height: 110,
            width: 95,
            margin: EdgeInsets.only(right: 10, top: 20),
            child: Column(
              children: [
                _buildSizes(item),
                Text(
                  item.text,
                  style: TextStyle(color: WeezlyColors.blue4, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      );
    });

    return Row(
      children: sizeRow,
    );
  }
}
