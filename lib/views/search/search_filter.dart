import 'dart:io';
import 'package:baloogo/widgets/sizes.dart';
import 'package:baloogo/widgets/travelMode.dart';
import 'package:flutter/material.dart';

import '../../commons/filter_datas.dart';
import '../../widgets/custom_radio.dart';

class SearchFilter extends StatefulWidget {
  final Function saveFilters;
  SearchFilter(this.saveFilters);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  String? size;
  String? weight;
  String? _travelMode;
  final _amountWeightCtrl = TextEditingController();

  void _setUserFilters(dynamic userChoiceFilter, String type) {
    setState(() => type == 'size'
        ? size = userChoiceFilter
        : type == 'weight'
            ? weight = 'kg'
            : _travelMode = userChoiceFilter);
  }

  @override
  void initState() {
    super.initState();
    TravelMode(null, null, null).resetTravelMode();
    Sizes().resetSizes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check_circle,
                    ),
                    color: Colors.yellow,
                    iconSize: 30,
                    onPressed: () {
                      final selectedFilter = <String, String?>{
                        'size': size,
                        'weight': _amountWeightCtrl.text.isNotEmpty
                            ? '${_amountWeightCtrl.text} $weight'
                            : null,
                        'travelMode': travelMode.value
                      };
                      widget.saveFilters(selectedFilter);
                      Navigator.of(context).pop();
                      sizes.forEach((element) {
                        element.isSelected = false;
                      });
                      weights.forEach((element) {
                        element.isSelected = false;
                      });
                      travelModes.forEach((element) {
                        element.isSelected = false;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleFilter('Dimension'),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.9,
                                  ),
                                  itemCount: sizes.length,
                                  itemBuilder: (context, index) {
                                    return _buildRadio(
                                        sizes[index], sizes, 'size');
                                  },
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      _buildTitleFilter("Poids"),
                      Row(
                        children: [
                          ...weights.map((e) {
                            return _buildRadio(e, weights, 'weight');
                          }).toList(),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Poids',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              controller: _amountWeightCtrl,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildTitleFilter("Moyen de transport"),
                      TravelMode(
                          Theme.of(context).primaryColor, Colors.white, 0.5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildRadio(items, listChanging, String type) {
    return Container(
      height: 43,
      width: 95,
      margin: EdgeInsets.only(right: 10, top: 20),
      child: type == 'size'
          ? Column(
              children: [
                InkWell(
                  onTap: () => setState(
                    () {
                      listChanging.forEach((element) {
                        if (items != element) element.isSelected = false;
                      });
                      if (items.isSelected) {
                        items.isSelected = false;
                        _setUserFilters(null, type);
                      } else {
                        items.isSelected = true;
                        _setUserFilters(items.text, type);
                      }
                    },
                  ),
                  splashColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(21.5),
                  child: CustomRadio(
                    item: items,
                    type: type,
                    colorBackground: Theme.of(context).primaryColor,
                    colorIcon: Colors.white,
                    colorBorder: Colors.white,
                    sizeRow: false,
                  ),
                ),
                Text(items.text, style: Theme.of(context).textTheme.bodyText1)
              ],
            )
          : InkWell(
              onTap: () => setState(
                () {
                  listChanging.forEach((element) {
                    if (items != element) element.isSelected = false;
                  });
                  if (items.isSelected) {
                    items.isSelected = false;
                    _setUserFilters(null, type);
                  } else {
                    items.isSelected = true;
                    _setUserFilters(items.text, type);
                  }
                },
              ),
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(21.5),
              child: CustomRadio(
                item: items,
                type: type,
                colorBackground: Theme.of(context).primaryColor,
                colorIcon: null,
                colorBorder: Colors.white,
                sizeRow: false,
              ),
            ),
    );
  }

  Text _buildTitleFilter(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
