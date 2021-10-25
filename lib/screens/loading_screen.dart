import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_fan/screens/permission_screen.dart';
import 'package:weather_fan/util/forecast.dart';
import 'package:weather_fan/services/weather.dart';
import 'package:weather_fan/util/styles.dart';

import 'weather_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getForecastData();
  }

  void getForecastData() async {
    var weatherHelper = OpenWeatherMapHelper();
    try {
      Forecast forecast = await weatherHelper.getForecastForCurrentLocation();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(
              forecast: forecast,
            );
          },
        ),
      );
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const PermissionScreen();
          },
        ),
      ).then((_) => getForecastData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            SpinKitDoubleBounce(color: Colors.blue, size: 100.0),
            Text(
              'Getting weather for your location',
              style: ThemeText.buttonTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
