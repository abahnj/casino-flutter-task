import 'package:casino_test/src/domain/entities/character_entity.dart';
import 'package:casino_test/src/presentation/ui/widgets/character_card.dart';
import 'package:casino_test/src/presentation/ui/widgets/character_image.dart';
import 'package:flutter/material.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({Key? key, required this.character})
      : super(key: key);

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(character.name),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double maxHeight = constraints.maxHeight;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    CharacterImage(
                      character: character,
                      size: maxHeight * 0.3,
                    ),
                    const SizedBox(height: 10),
                    HeroCharacterName(character: character),
                    const SizedBox(height: 10),
                    HeroCharacterStatus(character: character, center: true),
                    const SizedBox(height: 5),
                    Container(
                      height: maxHeight * 0.5,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InfoRow(
                              label: 'Gender:',
                              value: character.gender,
                            ),
                            InfoRow(
                              label: 'Origin:',
                              value: character.origin.name,
                            ),
                            InfoRow(
                              label: 'Last known location:',
                              value: character.location.name,
                            ),
                            InfoRow(
                              label: 'Number of episodes:',
                              value: character.episode.length.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
