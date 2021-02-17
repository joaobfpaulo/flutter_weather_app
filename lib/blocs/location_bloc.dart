import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_weather_app/blocs/blocs.dart';
import 'package:location/location.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Location location;

  LocationBloc({@required this.location})
      : assert(location != null),
        super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is LocationRequested) {
      yield LocationLoadInProgress();
      try {
        bool serviceEnabled;
        PermissionStatus _permissionGranted;
        LocationData locationData;

        serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }

        locationData = await location.getLocation();
        final String coordinates = "${locationData.latitude},${locationData.longitude}";
        yield LocationLoadSuccess(coordinates: coordinates);
      } catch (_) {
        yield LocationLoadFailure();
      }
    }
  }
}