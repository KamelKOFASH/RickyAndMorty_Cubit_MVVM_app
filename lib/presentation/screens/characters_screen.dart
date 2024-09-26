import 'package:flutter/cupertino.dart';
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
      appBar: buildAppBarWidget(),
      body: buildBlocBuilderWidget(),
    );
  }

  BlocBuilder<CharactersCubit, CharactersState> buildBlocBuilderWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
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
    );
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      title: const Text(
        'Rick And Morty',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 34,
          letterSpacing: 1.5,
          fontFamily: 'get_schwifty',
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/Rick and Morty Character Design.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.search,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
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
