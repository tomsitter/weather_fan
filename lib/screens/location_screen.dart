import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_fan/util/forecast.dart';
import 'package:weather_fan/services/weather.dart';
import 'package:weather_fan/util/styles.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  Forecast forecast;

  LocationScreen({Key? key, required this.forecast}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  OpenWeatherMapHelper weatherHelper = OpenWeatherMapHelper();
  late Forecast forecast;

  @override
  void initState() {
    super.initState();
    updateUI(widget.forecast);
  }

  void updateUI(Forecast newForecast) {
    setState(() {
      forecast = newForecast;
    });
  }

  _onWillPop(context) async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var forecast =
                            await weatherHelper.getForecastForCurrentLocation();
                        updateUI(forecast);
                      },
                      child: const Icon(Icons.near_me,
                          size: 50.0, color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () async {
                        String typedCityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CityScreen(),
                          ),
                        );
                        if (typedCityName != '') {
                          var forecast = await weatherHelper
                              .getForecastForCityName(typedCityName);
                          updateUI(forecast);
                        }
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Text(
                          (() => forecast.temp == -300
                              ? '?°'
                              : '${forecast.temp}°')(),
                          style: ThemeText.tempTextStyle),
                      Text(forecast.getWeatherIcon(),
                          style: ThemeText.conditionTextStyle)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                      '${forecast.getMessage()} in ${forecast.cityName}',
                      style: ThemeText.messageTextStyle,
                      textAlign: TextAlign.right),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
