import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/character_model.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CharactersCubit>()
        .fetchCharacters(); // Fetch characters on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Rick and Morty',
          style: TextStyle(
            fontSize: 18,
            color: MyColors.myBrownColor,
          ),
        ),
        backgroundColor: MyColors.myGreenColor,
      ),
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return buildLoadingIndicator(); // Show loading indicator
          } else if (state is CharactersLoaded) {
            if (state.characters.isEmpty) {
              return const Center(
                child: Text(
                  'No Characters!',
                  style: TextStyle(color: MyColors.myGreenColor),
                ),
              );
            }
            return buildGridViewChars(
                state.characters); // Pass characters to the builder
          } else if (state is CharactersError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: MyColors.myBrownColor),
              ),
            );
          }
          return const Center(child: Text('Unexpected state')); // Default case
        },
      ),
    );
  }

  Center buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myGreenColor,
      ),
    );
  }

  Widget buildGridViewChars(List<CharacterModel> characters) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: characters.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: characters[index],
        );
      },
    );
  }
}
