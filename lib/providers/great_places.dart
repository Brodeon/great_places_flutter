import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String title, File image) {
    var newPlace = Place(title: title, image: image, id: DateTime.now().toString(), location: null);
    _places.add(newPlace);
    notifyListeners();
  }

}