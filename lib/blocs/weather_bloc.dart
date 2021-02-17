import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_weather_app/repositories/repositories.dart';
import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/blocs/blocs.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequestedForCity) {
      yield* mapWeatherRequestedToState(event);
    } else if(event is WeatherRequestedFromCoordinates) {
      yield* mapWeatherRequestedFromCoordinatesToState(event);
    } else if (event is WeatherRefreshRequested) {
      yield* mapWeatherRefreshRequestedToState(event);
    }
  }

  Stream<WeatherState> mapWeatherRequestedToState(WeatherRequestedForCity event) async* {
    yield WeatherLoadInProgress();
    try {
      final Weather weather = await weatherRepository.getWeatherForCity(event.city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> mapWeatherRequestedFromCoordinatesToState(WeatherRequestedFromCoordinates event) async* {
    yield WeatherLoadInProgress();
    try {
      final Weather weather = await weatherRepository.getWeatherFromCoordinates(event.coordinates);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> mapWeatherRefreshRequestedToState(WeatherRefreshRequested event) async* {
    try {
      final Weather weather = await weatherRepository.getWeatherForCity(event.city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {}
  }
}