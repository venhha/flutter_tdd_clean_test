import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_tdd_clean_test/core/helpers/input_convertor.dart';
import 'package:flutter_tdd_clean_test/core/network/network_info.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> initLocator() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() => NumberTriviaBloc(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTriviaUseCase(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            localDataSource: sl(),
            networkInfo: sl(),
            remoteDataSource: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerFactory(() => InputConvertor());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity()); //NOTE this can be remove
}
