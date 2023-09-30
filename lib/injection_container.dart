import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'features/joke/data/datasources/get_joke_datasource.dart';
import 'features/joke/data/repositories/get_joke_repository_impl.dart';
import 'features/joke/domain/repositories/get_joke_repository.dart';
import 'features/joke/domain/usecases/get_joke_usecase.dart';
import 'features/joke/presentation/blocs/joke_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => http.Client());

  jokeInjection();
}

void jokeInjection() {
  ///to get joke list
  sl.registerLazySingleton(() => JokeBloc(getJokeUseCase: sl()));

  sl.registerLazySingleton(() => GetJokeUseCase(sl()));

  sl.registerLazySingleton<GetJokeRepository>(
      () => GetJokeRepositoryImpl(networkInfo: sl(), getJokeDataSource: sl()));

  sl.registerLazySingleton<GetJokeDataSource>(
      () => GetJokeDataSourceImpl(client: sl()));
}
