import '../models/character_model.dart';
import '../models/location_model.dart';
import '../services/web_services.dart';

class Repositories {
  final WebServices charactersWebServices;

  Repositories(this.charactersWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final response = await charactersWebServices.getAllCharacters();
    final characterResponse = CharacterResponse.fromJson(response);
    return characterResponse.results; // Return the list of CharacterModel
  }

  Future<List<LocationModel>> getAllLocations() async {
    final response = await charactersWebServices.getAllLocations();
    final locationResponse = LocationsResponse.fromJson(response);
    return locationResponse.results;
  }
}
