import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/models/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final ConsolidatedWeather consolidatedWeather;

  const WeatherLoadSuccess({
    @required this.consolidatedWeather
  }) : assert(consolidatedWeather != null);

  @override
  List<Object> get props => [consolidatedWeather];
}

class WeatherRefreshPreSuccess extends WeatherLoadSuccess {
  const WeatherRefreshPreSuccess({
    consolidatedWeather
  }) : super(consolidatedWeather: consolidatedWeather);
}

class WeatherLoadFailure extends WeatherState {}