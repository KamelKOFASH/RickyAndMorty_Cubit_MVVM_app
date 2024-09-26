import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickey_and_morty_adv_app/presentation/widgets/rotating_arcs.dart';

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
  late List<CharacterModel> characters;
  late List<CharacterModel> filteredCharacters;
  bool isFiltered = false; // To track if search is active
  bool isSearching = false; // To control whether the search bar is visible
  final _filterController = TextEditingController();

  // Build the search TextField widget
  Widget _buildFilterTextField() {
    return TextField(
      controller: _filterController,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (value) {
        addSearchedOrItemToFilteredList(value);
      },
    );
  }

  //? Search functionality: Filter the characters list based on the query
  void addSearchedOrItemToFilteredList(String query) {
    List<CharacterModel> results = [];
    if (query.isEmpty) {
      results = characters;
    } else {
      results = characters
          .where((character) =>
              character.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredCharacters = results;
      isFiltered = query.isNotEmpty; // Toggle filtering state
    });
  }

  @override
  void initState() {
    super.initState();
    context
        .read<CharactersCubit>()
        .fetchCharacters(); // Fetch characters on init
  }

  @override
  void dispose() {
    _filterController
        .dispose(); // Dispose of controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      body: buildBlocBuilderWidget(),
      backgroundColor: MyColors.myBrownColor,
    );
  }

  BlocBuilder<CharactersCubit, CharactersState> buildBlocBuilderWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharacterLoading) {
          return buildLoadingIndicator(); // Show loading indicator
        } else if (state is CharactersLoaded) {
          characters = state.characters;
          if (state.characters.isEmpty) {
            return const Center(
              child: Text(
                'No Characters!',
                style: TextStyle(color: MyColors.myGreenColor),
              ),
            );
          }
          return buildGridViewChars(isFiltered
              ? filteredCharacters
              : characters); // Use filtered list if search is active
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
      title: isSearching // Toggle between title and search field
          ? _buildFilterTextField()
          : const Text(
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
          onPressed: () {
            setState(() {
              isSearching = !isSearching; // Toggle search mode
              if (!isSearching) {
                _filterController
                    .clear(); // Clear search field when exiting search mode
                isFiltered = false; // Reset filtered state
              }
            });
          },
          icon: Icon(
            isSearching ? Icons.clear : CupertinoIcons.search,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }

  Center buildLoadingIndicator() {
    return const Center(
      child: RotatingArcs(),
    );
  }

  // Grid view for displaying characters
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
