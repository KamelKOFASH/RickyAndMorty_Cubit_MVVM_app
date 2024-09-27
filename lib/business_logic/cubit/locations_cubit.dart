import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickey_and_morty_adv_app/data/repositories/repositories.dart';

import '../../data/models/location_model.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  final Repositories locationsRepository;

  LocationsCubit(this.locationsRepository) : super(LocationsInitial());

  Future<void> fetchLocations() async {
    emit(LocationsLoading()); // Emit loading state
    try {
      final characters = await locationsRepository.getAllLocations();
      emit(LocationsLoaded(characters)); // Emit loaded state with characters
    } catch (e) {
      emit(LocationsError(
          "Failed to fetch characters")); // Emit error state on failure
    }
  }
}
