import 'dart:convert';

import 'package:http/http.dart';

const MAPQUEST_TOKEN = 'XGAXxH0G8keJqyfGmDZ4FKBaNXIsBPgW';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://www.mapquestapi.com/staticmap/v4/getmap?key=$MAPQUEST_TOKEN&size=600,400&type=map&imagetype=png&zoom=17&center=$latitude,$longitude&pois=1,$latitude,$longitude';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'http://www.mapquestapi.com/geocoding/v1/reverse?key=$MAPQUEST_TOKEN&location=$lat,$lng&includeNearestIntersection=true';
    final reponse = await get(Uri.parse(url));
    print(reponse.body);
    final address = jsonDecode(reponse.body)['results'][0]['locations'][0];

    return '${address['street']}, ${address['adminArea5']}, ${address['adminArea3']}, ${address['adminArea1']}  (${address['postalCode']})';
  }
}


// 'https://api.mapbox.com/styles/v1/mapbox/light-v10/static/pin-s-l+000(-87.0186,32.4055)/-87.0186,32.4055,14/500x300?access_token=pk.eyJ1IjoiYmwwMGR5a2kxMWVyIiwiYSI6ImNrcmt1cHhqZzI0eDEyb28ycjlycHhiNWgifQ.jGvPALWZN7NyvPiSS5CxDw';



//  'https://api.mapbox.com/styles/v1/mapbox/light-v10/static/pin-s-m+ff0000($longitude,$latitude)/$longitude,$latitude,14,0,0/400x400?access_token=$MAPQUEST_TOKEN';

//pk.eyJ1IjoiYmwwMGR5a2kxMWVyIiwiYSI6ImNrcmt1dDB0YjA3NHEycW52MnNpMWxjeXQifQ.zq7puRVu_dZokKRRzx4qtQ

// 'https://www.mapquestapi.com/staticmap/v4/getmap?key=XGAXxH0G8keJqyfGmDZ4FKBaNXIsBPgW&size=600,400&type=map&imagetype=png&pois=1,40.0986,-76.3988,-20,-20|2,40.0692,-76.4012|3,40.0981,-76.3461|4,40.0697,-76.352';