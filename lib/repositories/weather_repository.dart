import 'dart:async';
import 'package:flutter_weather_app/models/consolidated_weather.dart';
import 'package:meta/meta.dart';
import 'weather_api_client.dart';
import 'package:flutter_weather_app/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({
    @required this.weatherApiClient
  }) : assert(weatherApiClient != null);

  Future<ConsolidatedWeather> getWeatherForCity(String city) async {
    final int locationId = await weatherApiClient.getLocationIdForCity(city);
    return weatherApiClient.fetchWeather(locationId);
  }

  Future<ConsolidatedWeather> getWeatherFromCoordinates(String coordinates) async {
    final int locationId = await weatherApiClient.getLocationIdFromCoordinates(coordinates);
    return weatherApiClient.fetchWeather(locationId);
  }
}