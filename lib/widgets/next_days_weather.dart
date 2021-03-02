import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/models.dart' as model;
import 'package:flutter_weather_app/widgets/widgets.dart';

class NextDaysWeather extends StatelessWidget {
  final model.ConsolidatedWeather consolidatedWeather;

  NextDaysWeather({
    Key key,
    @required this.consolidatedWeather,
  })  : assert(consolidatedWeather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List weatherList = consolidatedWeather.listWeather;
    final List<Widget> columns = List();

    for (var i = 1; i < weatherList.length; i++) {
      var weather = weatherList[i];
      columns.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              weather.date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: WeatherConditions(condition: weather.condition),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
            child: Temperature(
              temperature: weather.temp,
              high: weather.maxTemp,
              low: weather.minTemp,
            ),
          ),
        ],
      ));
    }

    return Container(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: columns
      ),
    );
  }
}
