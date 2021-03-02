import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/simple_bloc_observer.dart';
import 'package:flutter_weather_app/blocs/blocs.dart';
import 'package:flutter_weather_app/repositories/repositories.dart';
import 'package:flutter_weather_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';


void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(location: Location())
      ),
      BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()
      )
    ],
        child: App(weatherRepository: weatherRepository)
    )
  );
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Flutter Weather',
          theme: themeState.theme,
          home: BlocProvider(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepository),
            child: Weather(),
          ),
        );
      },
    );
  }
}