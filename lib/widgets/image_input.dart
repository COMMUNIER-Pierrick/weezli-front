import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  List<Widget> _listImages = [];

  Future<void> _takePicture() async {
    // open Camera and take image Or
    // take image from gallery
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    setState(() => _storedImage = File(imageFile!.path));
    _createContainer(_storedImage!);
    // Copy the image picked by camera into the phone
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(File(imageFile!.path).toString());
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  Container _createContainers(File selectedImage) {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.only(
        top: 18,
        right: 3,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: WeezlyColors.grey4),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Image.file(selectedImage, fit: BoxFit.cover),
      ),
    );
  }

  void _createContainer(File selectedImage) {
    setState(() {
      _listImages.add(_createContainers(selectedImage));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: _takePicture,
            child: Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(top: 18, right: 3),
              decoration: BoxDecoration(
                border: Border.all(color: WeezlyColors.grey4),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Icon(
                WeezlyIcon.add,
                color: WeezlyColors.grey4,
                size: 50,
              ),
            ),
          ),
          ..._listImages,
        ],
      ),
    );
  }
}
