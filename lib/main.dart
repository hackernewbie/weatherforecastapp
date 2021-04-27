import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<WeatherInfo> fetchWeather () async {
  final zipCode = "788009";
  final countryCode = "IN";
  final units       = "metric";
  final apiKey = "";
  final requestURL = "http://api.openweathermap.org/data/2.5/weather?zip=${zipCode},${countryCode}&units=${units}&appid=${apiKey}";

  final response = await http.get(Uri.parse(requestURL));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception(
        "Error loading weather info. Please try again after sometime");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({
      @required this.location,
      @required this.temp,
      @required this.tempMin,
      @required this.tempMax,
      @required this.weather,
      @required this.humidity,
      @required this.windSpeed
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']
    );
  }
}

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Weather Forecast',
    home: WeatherLookup(),
  ));

class WeatherLookup extends StatefulWidget {
  @override
  _WeatherLookupState createState() => _WeatherLookupState();
}

class _WeatherLookupState extends State<WeatherLookup> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: futureWeather,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return MainWidget(
                location: snapshot.data!.location,
                temp: snapshot.data!.temp,
                tempMin: snapshot.data!.tempMin,
                tempMax: snapshot.data!.tempMax,
                weather: snapshot.data!.weather,
                humidity: snapshot.data!.humidity,
                windSpeed: snapshot.data!.windSpeed
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
}
