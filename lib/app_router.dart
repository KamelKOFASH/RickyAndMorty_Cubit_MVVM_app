import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/characters_cubit.dart';
import 'business_logic/cubit/locations_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character_model.dart';
import 'data/repositories/repositories.dart';
import 'data/services/web_services.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/characters_screen.dart';

class AppRouter {
  late Repositories dataRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    dataRepository = Repositories(WebServices());
    charactersCubit = CharactersCubit(dataRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
               LocationsCubit(dataRepository),
            child: CharacterDetailsScreen(
              character: character,
            ),
          ),
        );
    }
    return null;
  }
}
