import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_tdd_clean_test/features/news/data/data_sources/remote/news_remote_datasource.dart';
import 'package:flutter_tdd_clean_test/features/news/data/repository/article_repository_impl.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/repository/article_repository.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/usecase/get_article.dart';
import 'package:flutter_tdd_clean_test/features/news/presentation/bloc/news_bloc.dart';
import 'core/helpers/input_convertor.dart';
import 'core/network/network_info.dart';
import 'features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> initLocator() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() => NumberTriviaBloc(sl(), sl()));
  sl.registerFactory(() => NewsBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTriviaUseCase(sl()));
  sl.registerLazySingleton(() => GetArticleUseCase(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            localDataSource: sl(),
            networkInfo: sl(),
            remoteDataSource: sl(),
          ));
  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
        networkInfo: sl(),
        newsRemoteDataSource: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerFactory(() => InputConvertor());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity()); //NOTE this can be remove
}
