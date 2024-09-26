import '../models/character_model.dart';
import '../services/get_characters_service.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final response = await charactersWebServices.getAllCharacters();
    final characterResponse = CharacterResponse.fromJson(response);
    return characterResponse.results; // Return the list of CharacterModel
  }
}
