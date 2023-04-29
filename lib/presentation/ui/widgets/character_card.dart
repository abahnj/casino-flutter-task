import 'package:casino_test/core/utils/colors.dart';
import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:casino_test/presentation/ui/character_detail_page.dart';
import 'package:casino_test/presentation/ui/widgets/character_image.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    Key? key,
    required this.character,
  }) : super(key: key);

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    const double sizeImage = 100;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(sizeImage),
          right: Radius.circular(90),
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CharacterDetailPage(character: character),
                ),
              );
            },
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Ink(
              height: 100,
              width: double.infinity,
              color: Theme.of(context).colorScheme.onSecondary,
              child: Row(
                children: <Widget>[
                  CharacterImage(
                    character: character,
                    size: sizeImage,
                  ),
                  const SizedBox(width: 20),
                  CharacterCardData(character: character),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterCardData extends StatelessWidget {
  const CharacterCardData({super.key, required this.character});
  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeroCharacterName(character: character),
          const SizedBox(height: 5),
          HeroCharacterStatus(character: character),
        ],
      ),
    );
  }
}

class HeroCharacterStatus extends StatelessWidget {
  const HeroCharacterStatus({
    super.key,
    required this.character,
    this.center = false,
  });

  final CharacterEntity character;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${character.status}${character.id}',
      child: Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          CharacterStatusCircle(status: character.status),
          const SizedBox(width: 8),
          Text(
            '${character.status} - ${character.species}',
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: center ? TextAlign.center : null,
          ),
        ],
      ),
    );
  }
}

class HeroCharacterName extends StatelessWidget {
  const HeroCharacterName({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${character.name}${character.id}',
      child: Text(
        character.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class CharacterStatusCircle extends StatelessWidget {
  const CharacterStatusCircle({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: status.colorStatus,
          boxShadow: [
            BoxShadow(color: status.colorStatus, blurRadius: 5, spreadRadius: 2)
          ]),
    );
  }
}

extension StatusColor on String {
  Color get colorStatus {
    return this == 'Alive'
        ? AppColors.aliveColor
        : this == 'Dead'
            ? AppColors.deadColor
            : Colors.grey;
  }
}
