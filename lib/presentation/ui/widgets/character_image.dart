import 'package:casino_test/core/utils/cached_network_image_wrapper.dart';
import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage(
      {super.key, required this.character, required this.size});

  final CharacterEntity character;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character.id,
      child: ClipOval(
        child: CachedNetworkImageWrapper(
          height: size,
          fit: BoxFit.fitHeight,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          imageUrl: character.image,
          errorWidget: (_, __, ___) => const SizedBox.square(
            dimension: 100,
            child: Icon(Icons.error_outline_outlined),
          ),
        ),
      ),
    );
  }
}
