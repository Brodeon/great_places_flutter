import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {

                }),
            FlatButton.icon(
                icon: Icon(Icons.map),
                label: Text(
                  'Select on map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {

                }),
          ],
        )
      ],
    );
  }
}
