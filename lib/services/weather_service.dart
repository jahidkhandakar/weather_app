import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apikey;

  WeatherService(this.apikey);

  //*Method 1 ________________________get weather infos________________________
  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apikey&units=metric'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['main']); 

       return Weather.fromJson(jsonResponse);     
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  //*Method 2 ________________________get current city________________________
  Future<String> getCurrentCity() async {
    //get permission from user__________________________
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location__________________________
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //convert the location into a list of place mark objects__________________
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract the city name from the first place mark__________________________
    String? city = placemarks[0].locality;

    return city?? '';
  }
}
