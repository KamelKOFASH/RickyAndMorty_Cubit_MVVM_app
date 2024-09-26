import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_router.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'data/repositories/characters_repo.dart';
import 'data/services/get_characters_service.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) =>
          CharactersCubit(CharactersRepository(CharactersWebServices())),
      child: RickAndMortyApp(appRouter: AppRouter()),
    ),
  );
}

class RickAndMortyApp extends StatelessWidget {
  final AppRouter appRouter;

  const RickAndMortyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
