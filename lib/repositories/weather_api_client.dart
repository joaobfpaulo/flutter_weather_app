import 'package:flutter_weather_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<int> getLocationIdForCity(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await this.httpClient.get(locationUrl);

    if(locationResponse.statusCode != 200) {
      throw Exception('error ${locationResponse.statusCode} getting location for city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<int> getLocationIdFromCoordinates(String coordinates) async {
    final locationUrl = '$baseUrl/api/location/search/?lattlong=$coordinates';
    final locationResponse = await this.httpClient.get(locationUrl);

    if(locationResponse.statusCode != 200) {
      throw Exception('error ${locationResponse.statusCode} getting location from coordinates');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if(weatherResponse.statusCode != 200) {
      throw Exception('error ${weatherResponse.statusCode} getting location for city');
    }

    String source = Utf8Decoder().convert(weatherResponse.bodyBytes);
    final weatherJson = jsonDecode(source);
    return Weather.fromJson(weatherJson);
  }


}