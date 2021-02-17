import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequestedForCity extends WeatherEvent {
  final String city;

  const WeatherRequestedForCity({
    @required this.city
  }) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class WeatherRefreshRequested extends WeatherEvent {
  final String city;

  const WeatherRefreshRequested({
    @required this.city
  }) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class WeatherRequestedFromCoordinates extends WeatherEvent {
  final String coordinates;

  const WeatherRequestedFromCoordinates({
    @required this.coordinates
  }) : assert(coordinates != null);

  @override
  List<Object> get props => [coordinates];
}