import 'api_keys.dart' as keys;
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationHelper {

  static String generateLocationPreviewImage(double latitude, double longitute) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitute&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitute&key=${keys.ApiKeys.googleMapsApi}";
  }

  static Future<String> getPlaceAdress(double lat, double lon) async {
    final response = await http.get('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=${keys.ApiKeys.googleMapsApi}');
    return json.decode(response.body)['results'][0]['formatted_address'];
  }


}