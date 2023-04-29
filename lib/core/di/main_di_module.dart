import 'package:casino_test/domain/usecases/get_characters_use_case.dart';
import 'package:casino_test/presentation/bloc/characters_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../../data/data_sources/character_remote_datasource.dart';
import '../../data/repository/characters_repository.dart';
import '../../data/repository/characters_repository_impl.dart';

final locator = GetIt.instance;

void locatorSetup() {
  final httpClient = Client();

  locator.registerFactory<CharactersBloc>(
      () => CharactersBloc(locator.get<GetCharacters>()));

  locator.registerLazySingleton<GetCharacters>(
      () => GetCharacters(locator.get<CharactersRepository>()));

  locator.registerLazySingleton<Client>(() => httpClient);

  locator.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl(client: locator.get()));

  locator.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(locator.get()));
}
