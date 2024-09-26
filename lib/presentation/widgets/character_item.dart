import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display cached network image with error and loading placeholders
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: character.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: character.image,
                      placeholder: (context, url) =>
                          Lottie.asset('assets/animations/greenLoading.json'),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 50, color: Colors.red),
                      fit: BoxFit.fill,
                    )
                  : Lottie.asset("assets/animations/greenLoading.json"),
            ),
          ),

          // Name and description
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              character.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
