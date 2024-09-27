part of 'locations_cubit.dart';

@immutable
sealed class LocationsState {}

final class LocationsInitial extends LocationsState {}

final class LocationsLoading extends LocationsState {}  

final class LocationsLoaded extends LocationsState {
  final List<LocationModel> locations;

  LocationsLoaded(this.locations);
}

final class LocationsError extends LocationsState {
  final String message;

  LocationsError(this.message);
} 


