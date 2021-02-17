import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class LocationRequested extends LocationEvent {
  const LocationRequested();

   @override
  List<Object> get props => [];
}