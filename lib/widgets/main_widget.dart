import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  MainWidget({
    @required this.location,
    @required this.temp,
    @required this.tempMin,
    @required this.tempMax,
    @required this.weather,
    @required this.humidity,
    @required this.windSpeed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          color: Color(0xfff1f1f1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${location.toString()}",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "${temp.toInt().toString()}\u00B0c",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                "High of ${tempMin.toInt().toString()}\u00B0c & Low of ${tempMax.toInt().toString()}\u00B0c",
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  WeatherTile(
                      icon: Icons.thermostat_outlined,
                      title: "Temperature",
                      subtitle: "${temp.toInt().toString()}\u00B0c"),
                  WeatherTile(
                      icon: Icons.filter_drama_outlined,
                      title: "Weather",
                      subtitle: "${weather.toString()}"),
                  WeatherTile(
                      icon: Icons.wb_sunny,
                      title: "Humidity",
                      subtitle: "${humidity.toInt().toString()}%"),
                  WeatherTile(
                      icon: Icons.waves, title: "Wind Speed", subtitle: "${windSpeed.toInt().toString()} kmph"),
                ],
              ),
            )
        ),
      ],
    );
  }
}

