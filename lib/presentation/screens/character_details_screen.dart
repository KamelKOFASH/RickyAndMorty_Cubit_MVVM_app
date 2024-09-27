import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../business_logic/cubit/locations_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/location_model.dart';

import '../../data/models/character_model.dart';

class CharacterDetailsScreen extends StatefulWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final CharacterModel character;

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late List<LocationModel> locations = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationsCubit>(context).fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myBrownColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          buildAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCharacterInfo("Status: ", widget.character.status),
                    buildDivider(280),
                    buildCharacterInfo("Species: ", widget.character.species),
                    buildDivider(270),
                    buildCharacterInfo("Gender: ", widget.character.gender),
                    buildDivider(280),
                    buildCharacterInfo(
                        "Origin: ", widget.character.origin.name),
                    buildDivider(290),
                    buildCharacterInfo(
                        "Location: ", widget.character.location.name),
                    buildDivider(250),
                    buildCharacterInfo("No.of times appeared in episode: ",
                        widget.character.episode.length.toString()),
                    buildDivider(80),
                    const SizedBox(height: 20),
                    Text(
                      "Created: ${widget.character.name}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.character.created))} at ${DateFormat.jm().format(DateTime.parse(widget.character.created))}',
                      style: const TextStyle(
                        color: MyColors.myYellowColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //? Animated Texts
                    const SizedBox(height: 10),
                    const Text(
                      "All locations: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<LocationsCubit, LocationsState>(
                      builder: (context, state) {
                        if (state is LocationsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: MyColors.myYellowColor,
                            ),
                          );
                        } else if (state is LocationsLoaded) {
                          locations = state.locations;
                        } else if (state is LocationsError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                color: MyColors.myYellowColor,
                              ),
                            ),
                          );
                        }
                        return buildListLocationsView(locations);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget buildListLocationsView(List<LocationModel> locations) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              Icons.location_on,
              color: MyColors.myGreenColor,
            ),
            title: AnimatedTextKit(
              animatedTexts: [
                FlickerAnimatedText(locations[index].name,
                    textStyle: const TextStyle(
                      color: MyColors.myYellowColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: MyColors.myYellowColor,
                            offset: Offset(0, 0),
                            blurRadius: 10)
                      ],
                    )),
              ],
              isRepeatingAnimation: true,
            ),
            subtitle: Text(
              locations[index].type,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              locations[index].dimension,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            color: MyColors.myGreenColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        )
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellowColor,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  SliverAppBar buildAppBar() {
    return SliverAppBar(
      backgroundColor: MyColors.myGreenColor,
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.character.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        background: Hero(
          tag: widget.character.id,
          child: Image.network(
            widget.character.image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
