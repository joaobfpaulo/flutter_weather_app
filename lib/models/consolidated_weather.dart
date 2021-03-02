import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/models/models.dart';

class ConsolidatedWeather extends Equatable {
  final List<dynamic> listWeather;
  final String location;
  final int locationId;
  final DateTime lastUpdated;

  const ConsolidatedWeather({
    this.listWeather,
    this.location,
    this.locationId,
    this.lastUpdated
  });

  @override
  List<Object> get props => [
    listWeather
  ];

  static ConsolidatedWeather fromJson(dynamic json) {
    return ConsolidatedWeather(
      listWeather: json['consolidated_weather'].map((data) => Weather.fromJson(data)).toList(),
      location: json['title'],
      locationId: json['woeid'] as int,
      lastUpdated: DateTime.now(),
    );
  }

}