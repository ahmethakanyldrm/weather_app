import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';

const apiKey = '************************';

class WeatherDisplayData{
  Icon weatherIcon;

  AssetImage weatherImage;

  WeatherDisplayData({@required this.weatherIcon, this.weatherImage});
}

class WeatherData {
  WeatherData({@required this.locationData});
  LocationHelper locationData;
  double currentTemperature;
  String city;
  String country;
  int currentCondition;

  Future<void> getcurrentTemperature() async {
    Response response = await get("http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric");

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city=currentWeather['name'];
        country=currentWeather['sys']['country'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API den değer gelmiyor");
    }

  }

  WeatherDisplayData getWeatherDisplayData(){
    if(currentCondition<600){
      //hava bulutlu
      return WeatherDisplayData(weatherIcon: Icon(
        FontAwesomeIcons.cloud,
        size: 75,
        color: Colors.white,
      ),
      weatherImage: AssetImage("assets/images/bulutlu.png"),
      );
    }
    else{
      // hava güzel
      // gece gündüz kontrolü
      var now=new DateTime.now();
      if(now.hour>=18){
        return WeatherDisplayData(weatherIcon: Icon(
          FontAwesomeIcons.moon,
          size: 75,
          color: Colors.white,
        ),
          weatherImage: AssetImage("assets/images/gece.png"),
        );
      }else{
        return WeatherDisplayData(weatherIcon: Icon(
          FontAwesomeIcons.sun,
          size: 75,
          color: Colors.white,
        ),
          weatherImage: AssetImage("assets/images/gunesli.png"),
        );
      }
    }
  }
}
