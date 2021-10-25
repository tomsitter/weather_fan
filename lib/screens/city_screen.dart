import 'package:flutter/material.dart';
import 'package:weather_fan/util/styles.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/city_background.jpg'),
            fit: BoxFit.cover),
      ),
      constraints: const BoxConstraints.expand(),
      child: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context, '');
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 50.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              style: const TextStyle(color: Colors.black),
              decoration: ThemeText.textFieldInputDecoration,
              onChanged: (value) {
                cityName = value;
              },
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context, cityName);
            },
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(8.0),
                backgroundColor: Colors.grey.withOpacity(0.8),
                side: BorderSide(width: 2.0, color: Colors.white)),
            child: const Text('Get Weather',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Spartan',
                  fontSize: 30.0,
                )),
          ),
        ],
      )),
    ));
  }
}
