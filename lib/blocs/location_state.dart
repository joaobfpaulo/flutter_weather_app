import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoadInProgress extends LocationState {}

class LocationLoadSuccess extends LocationState {
  final String coordinates;

  const LocationLoadSuccess({
    @required this.coordinates
  }) : assert(coordinates != null);

  @override
  List<Object> get props => [coordinates];
}

class LocationLoadFailure extends LocationState {}