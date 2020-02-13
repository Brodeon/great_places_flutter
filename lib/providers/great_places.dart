import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:great_places_app/helpers/db_helper.dart';
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
    DBHelper.insert('user_places', {'id': newPlace.id, 'title': newPlace.title, 'image': newPlace.image.path});
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _places = dataList.map((item) => Place(id: item['id'], title: item['title'], image: File(item['image']), location: null)).toList();
    notifyListeners();
  }

}