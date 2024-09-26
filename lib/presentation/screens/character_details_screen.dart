import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rickey_and_morty_adv_app/constants/colors.dart';

import '../../data/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final CharacterModel character;

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
                    buildCharacterInfo("Status: ", character.status),
                    buildDivider(280),
                    buildCharacterInfo("Species: ", character.species),
                    buildDivider(270),
                    buildCharacterInfo("Gender: ", character.gender),
                    buildDivider(280),
                    buildCharacterInfo("Origin: ", character.origin.name),
                    buildDivider(290),
                    buildCharacterInfo("Location: ", character.location.name),
                    buildDivider(250),
                    buildCharacterInfo("No.of times appeared in episode: ",
                        character.episode.length.toString()),
                    buildDivider(80),
                    const SizedBox(height: 20),
                    Text(
                      "Created: ${character.name}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${DateFormat('dd MMMM yyyy').format(DateTime.parse(character.created))} at ${DateFormat.jm().format(DateTime.parse(character.created))}',
                      style: const TextStyle(
                        color: MyColors.myYellowColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //? Animated Text
                  ],
                ),
              ),
            ],
          ))
        ],
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
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(character.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
