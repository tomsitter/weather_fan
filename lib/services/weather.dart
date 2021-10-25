import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_fan/auth/keys.dart';

import 'location.dart';
import '../util/forecast.dart';

/// Convenience functions for creating OpenWeatherMap API queries
/// Currently supports using current GPS location, or using a provided city name
class OpenWeatherMapHelper {
  /// Gets the users current position and queries OpenWeatherMap for current weather
  /// Returns a Forecast object with some key fields.
  Future<Forecast> getForecastForCurrentLocation() async {
    var locationService = Location();
    var position = await locationService.getCurrentLocation();

    var forecast = await NetworkHelper.getJsonData(
      url: OpenWeatherMapHelper.createWeatherUrlFromCoords(
          lat: position.latitude, lon: position.longitude),
    ).then(
      (jsonData) => Forecast.fromJson(jsonData),
    );

    return forecast;
  }

  /// Uses a provided city name to query OpenWeatherMap for current weather
  /// Returns a [Forecast] object with some key fields.
  Future<Forecast> getForecastForCityName(String cityName) async {
    try {
      var forecast = await NetworkHelper.getJsonData(
        url: OpenWeatherMapHelper.createWeatherUrlFromCityName(
            cityName: cityName),
      ).then(
        (jsonData) => Forecast.fromJson(jsonData),
      );

      return forecast;
    } catch (e) {
      print('Could not retrieve forecast for $cityName');
      return Forecast(
          condition: 1000,
          lat: 0,
          lon: 0,
          main: 'Unknown',
          description: 'Unknown',
          temp: -300,
          cityName: cityName);
    }
  }

  /// Provided a city name and optional temperature units ('metric' or 'imperial'),
  /// creates a URI for the OpenWeatherMap Weather by City Name API
  static String createWeatherUrlFromCityName(
      {required String cityName, String units = 'metric'}) {
    final queryParams = {
      'q': cityName,
      'appid': openWeatherMapKey,
      'units': units
    };
    final uri =
        Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParams);
    return uri.toString();
  }

  /// Provider a latitude and longitude, and optional temperature units ('metric' or 'imperial')
  /// Creates a URI for the OpenWeatherMap Weather by City Name API
  static String createWeatherUrlFromCoords(
      {required double lat, required double lon, String units = 'metric'}) {
    // Creates URL string for querying weather data using lat/lon
    final queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': openWeatherMapKey,
      'units': units,
    };

    final uri =
        Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParams);
    return uri.toString();
  }
}

/// Helper class for making API calls and decoding returned JSON
class NetworkHelper {
  static Future<Map<String, dynamic>> getJsonData({required String url}) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      //Forecast forecast = fromJson(jsonDecode(response.body));
      // String weather = jsonDecode(data)['weather']['main'];

      return json.decode(response.body);
      //print(forecast.main);
    } else {
      return {'Error': '${response.statusCode}'};
    }
  }
}
