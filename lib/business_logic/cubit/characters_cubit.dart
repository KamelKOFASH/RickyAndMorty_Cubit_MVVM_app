import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/character_model.dart';
import '../../data/repositories/characters_repo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  Future<void> fetchCharacters() async {
    emit(CharacterLoading()); // Emit loading state
    try {
      final characters = await charactersRepository.getAllCharacters();
      emit(CharactersLoaded(characters)); // Emit loaded state with characters
    } catch (e) {
      emit(CharactersError("Failed to fetch characters")); // Emit error state on failure
    }
  }
}
