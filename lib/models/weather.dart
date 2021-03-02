import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final String created;
  final String date;

  const Weather({
    this.condition,
    this.formattedCondition,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.created,
    this.date
  });

  @override
  List<Object> get props => [
    condition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    created,
    date
  ];

  static Weather fromJson(dynamic json) {
    final String dateFormatted = DateFormat("dd/MM").format(DateTime.parse(json['applicable_date']));

    return Weather(
      formattedCondition: json['weather_state_name'],
      condition: mapStringToWeatherCondition(json['weather_state_abbr']),
      created: json['created'],
      date: dateFormatted,
      minTemp: json['min_temp'] as double,
      maxTemp: json['max_temp'] as double,
      temp: json['the_temp'] as double
    );
  }

  static WeatherCondition mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }

}