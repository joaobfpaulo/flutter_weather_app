import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/gradient_container.dart';
import 'package:flutter_weather_app/widgets/next_days_weather.dart';
import 'package:flutter_weather_app/widgets/widgets.dart';
import 'package:flutter_weather_app/blocs/blocs.dart';

class Weather extends StatefulWidget {
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> refreshCompleter;

  void initState() {
    super.initState();
    refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherRequestedForCity(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(
                WeatherChanged(condition: state.consolidatedWeather.listWeather[0].condition),
              );
              refreshCompleter?.complete();
              refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is WeatherInitial) {
              return BlocBuilder<LocationBloc, LocationState>(
                builder: (context, locationState) {
                  if (locationState is LocationInitial) {
                    BlocProvider.of<LocationBloc>(context)
                        .add(LocationRequested());
                  }
                  if (locationState is LocationLoadInProgress) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (locationState is LocationLoadSuccess) {
                    if(locationState.coordinates != null) {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(WeatherRequestedFromCoordinates(coordinates: locationState.coordinates));
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                  if (locationState is LocationLoadFailure) {
                    return Text(
                      'Please Select a Location');
                  }
                  return Container();
                },
              );
            }
            if (state is WeatherLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoadSuccess) {
              final consolidatedWeather = state.consolidatedWeather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return GradientContainer(
                        color: themeState.color,
                        child: RefreshIndicator(
                          onRefresh: () {
                            BlocProvider.of<WeatherBloc>(context).add(
                              WeatherRefreshRequested(
                                  city: state.consolidatedWeather.location),
                            );
                            return refreshCompleter.future;
                          },
                          child: Center(
                            child: ListView(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 50.0),
                                  child: Center(
                                    child: City(location: consolidatedWeather.location),
                                  ),
                                ),
                                Center(
                                  child: LastUpdated(
                                      dateTime: consolidatedWeather.lastUpdated),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  child: Center(
                                    child: CombinedWeatherTemperature(
                                      weather: consolidatedWeather.listWeather[0],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Center(
                                    child:  NextDaysWeather(consolidatedWeather: consolidatedWeather),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                    );
                  }
              );
            }
            if (state is WeatherLoadFailure) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}