import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationScreen extends StatefulWidget {

  final locationWeather;

  const LocationScreen({Key key, this.locationWeather}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  double temperature;
  int conditionCode;
  String cityName;
  String weatherIcon;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic weatherData){
    setState(() {
      if(weatherData == null){
        temperature = 0;
        weatherMessage = 'Error gathering data';
        cityName = '';
        return;
      }

      temperature = weatherData['main']['temp'];
      conditionCode = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherMessage = WeatherModel().getMessage(temperature.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {

                       var weatherData = await WeatherModel().getLocationData();
                       updateUi(weatherData);

                    },
                    child: FaIcon(
                      FontAwesomeIcons.locationArrow,
                      size: 24.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var result = await Navigator.push(context,
                          MaterialPageRoute(builder:
                              (BuildContext context) {
                        return CityScreen();
                          }));
                      if(result != null){
                        var weatherData = await WeatherModel().getCityWeather(result);
                        updateUi(weatherData);
                      }
                    },
                    child: FaIcon(
                      FontAwesomeIcons.city,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.all(20),
                color: Colors.white,
                elevation: 20.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${temperature.toStringAsFixed(0)}°c',
                        style: kTempTextStyle,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        WeatherModel().getWeatherIcon(conditionCode) ?? 'Error',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
