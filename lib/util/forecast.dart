/// Utility class for storing JSON weather data returned for OpenWeatherMap
/// And presenting interpretations of the results to the user.
class Forecast {
  final int condition;
  final double lat;
  final double lon;
  final String main;
  final String description;
  final int temp;
  final String cityName;

  Forecast({
    required this.condition,
    required this.lat,
    required this.lon,
    required this.main,
    required this.description,
    required this.temp,
    required this.cityName,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      condition: json['weather'][0]['id'],
      lat: json['coord']['lat'],
      lon: json['coord']['lon'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: (() => json['main']['temp'] is int
          ? json['main']['temp']
          : json['main']['temp'].toInt())(),
      cityName: json['name'],
    );
  }

  @override
  String toString() {
    return ''' Forecast(
    condition: $condition,
    lat: $lat,
    lon: $lon,
    main: $condition
    description: $description
    temp: $temp
    cityName: $cityName''';
  }

  String getWeatherIcon() {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp == -300) {
      return 'Could not get forecast';
    } else if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
