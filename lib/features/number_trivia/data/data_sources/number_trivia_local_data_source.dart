import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/number_trivia_model.dart';

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    try {
      return sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA,
        json.encode(triviaToCache.toJson()),
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    try {
      final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
      if (jsonString != null) {
        return Future.value(
            NumberTriviaModel.fromJson(json.decode(jsonString)));
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}

// const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

// class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
//   final SharedPreferences sharedPreferences;

//   NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

//   @override
//   Future<NumberTriviaModel> getLastNumberTrivia() {
//     final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
//     if (jsonString != null) {
//       return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
//     } else {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
//     return sharedPreferences.setString(
//       CACHED_NUMBER_TRIVIA,
//       json.encode(triviaToCache.toJson()),
//     );
//   }
// }
