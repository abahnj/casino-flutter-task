import 'package:casino_test/src/core/di/main_di_module.dart';
import 'package:casino_test/src/presentation/bloc/characters_bloc.dart';
import 'package:casino_test/src/presentation/bloc/characters_event.dart';
import 'package:casino_test/src/presentation/bloc/characters_state.dart';
import 'package:casino_test/src/presentation/ui/exception_indicators/error_indicator.dart';
import 'package:casino_test/src/presentation/ui/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CharacterScreen extends StatelessWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersBloc>(
      create: (context) =>
          locator.get<CharactersBloc>()..add(const FetchCharacters()),
      child: const CharactersScreenConsumer(),
    );
  }
}

class CharactersScreenConsumer extends StatefulWidget {
  const CharactersScreenConsumer({Key? key}) : super(key: key);

  @override
  State<CharactersScreenConsumer> createState() =>
      _CharactersScreenConsumerState();
}

class _CharactersScreenConsumerState extends State<CharactersScreenConsumer> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    //if the bottom of the list is reached, request a new page
    if (_isBottom) {
      context.read<CharactersBloc>().add(const FetchCharacters());
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  //check when we have reached the bottom
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * _scrollThreshold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters')),
      body: BlocConsumer<CharactersBloc, CharactersState>(
        listener: (context, state) {},
        builder: (blocContext, state) => state.match(
          onLoading: (data) => data == null
              ? _loadingWidget(context)
              : _successfulWidget(
                  context: context,
                  data: data,
                  controller: _scrollController,
                  loading: true,
                ),
          onError: (error, data) => data == null
              ? CharactersErrorContent(
                  error: error,
                  retry: () => context
                      .read<CharactersBloc>()
                      .add(const RetryAfterFailure()))
              : _successfulWidget(
                  context: context,
                  data: data,
                  controller: _scrollController,
                ),
          onLoaded: (data) => _successfulWidget(
            context: context,
            data: data,
            controller: _scrollController,
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _successfulWidget(
          {required BuildContext context,
          required CharactersData data,
          required ScrollController controller,
          bool loading = false}) =>
      CharactersContent(
        charactersData: data,
        scrollController: controller,
        loading: loading,
      );
}

class CharactersErrorContent extends StatelessWidget {
  const CharactersErrorContent({
    super.key,
    this.error,
    this.retry,
  });

  final Object? error;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    return ErrorIndicator(
      error: error,
      onTryAgain: retry,
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class RetryButton extends StatelessWidget {
  const RetryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.read<CharactersBloc>().add(const FetchCharacters());
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            textStyle: const TextStyle(fontSize: 18.0),
          ),
          child: const Text('Retry'),
        ),
      ),
    );
  }
}

class CharactersContent extends StatelessWidget {
  const CharactersContent({
    super.key,
    required this.charactersData,
    required this.scrollController,
    this.loading = false,
  });

  final CharactersData charactersData;
  final ScrollController scrollController;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final characters = charactersData.characterList.characters;
    return ListView.builder(
      controller: scrollController,
      cacheExtent: 2,
      itemCount:
          characters.length + (loading || charactersData.hasError ? 1 : 0),
      itemBuilder: (_, index) {
        if (index < characters.length) {
          // Display the character item at this index
          return CharacterCard(character: characters[index]);
        } else {
          // Display the LoadingIndicator as the last item
          return charactersData.hasError
              ? const RetryButton()
              : const LoadingIndicator();
        }
      },
    );
  }
}
