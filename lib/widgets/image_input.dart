
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class ImageInput extends StatefulWidget {
  Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
      final image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      setState(() {
        _storedImage = image;
      });
      if (image == null) return;
      final appDir = await pathProvider.getApplicationDocumentsDirectory();
      final imageName = path.basename(image.path);
      final savedImage = await image.copy('${appDir.path}/$imageName');
      widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null ? Image.file(_storedImage, fit: BoxFit.cover, width: double.infinity, height: double.infinity,) : Center(child: Text('No Image Taken', textAlign: TextAlign.center,),),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
