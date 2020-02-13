import 'api_keys.dart' as keys;

class LocationHelper {

  static String generateLocationPreviewImage(double latitude, double longitute) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitute&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitute&key=${keys.ApiKeys.googleMapsApi}";
  }


}