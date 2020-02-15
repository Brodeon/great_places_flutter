import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  LocationInput(this.onSelectLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();

    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(location.latitude, location.longitude);
    });

    widget.onSelectLocation(location.latitude, location.longitude);
  }

  Future<void> selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(fullscreenDialog: true, builder: (_) => MapScreen(isSelecting: true,)),);

    if (selectedLocation == null) {
      return;
    }

    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(selectedLocation.latitude, selectedLocation.longitude);
    });

    widget.onSelectLocation(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: _getCurrentUserLocation),
            FlatButton.icon(
                icon: Icon(Icons.map),
                label: Text(
                  'Select on map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: selectOnMap),
          ],
        )
      ],
    );
  }
}
