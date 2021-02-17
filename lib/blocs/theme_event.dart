
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_weather_app/models/weather.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  const WeatherChanged({@required this.condition}) : assert(condition != null);

  @override
  List<Object> get props => [condition];
}
