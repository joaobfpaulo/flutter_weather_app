import 'dart:async';
import 'package:meta/meta.dart';
import 'weather_api_client.dart';
import 'package:flutter_weather_app/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({
    @required this.weatherApiClient
  }) : assert(weatherApiClient != null);

  Future<Weather> getWeatherForCity(String city) async {
    final int locationId = await weatherApiClient.getLocationIdForCity(city);
    return weatherApiClient.fetchWeather(locationId);
  }

  Future<Weather> getWeatherFromCoordinates(String coordinates) async {
    final int locationId = await weatherApiClient.getLocationIdFromCoordinates(coordinates);
    return weatherApiClient.fetchWeather(locationId);
  }
}