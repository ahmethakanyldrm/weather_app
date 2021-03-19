import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/utils/weather.dart';

class MainScreen extends StatefulWidget {
//  MainScreen({Key key}) : super(key: key);

  final WeatherData weatherData;

  const MainScreen({@required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  double temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;
  String city;
  String country;

  void updateDisplayInfo(WeatherData weatherData){
    setState(() {
      temperature=weatherData.currentTemperature;
      city=weatherData.city;
      country=weatherData.country;
      WeatherDisplayData weatherDisplayData=weatherData.getWeatherDisplayData();
      backgroundImage=weatherDisplayData.weatherImage;
      weatherDisplayIcon=weatherDisplayData.weatherIcon;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                child:weatherDisplayIcon
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "$temperature °",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    letterSpacing: -5,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  country,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    letterSpacing: -5,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  city,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    letterSpacing: -5,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
