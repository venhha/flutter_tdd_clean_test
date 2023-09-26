import 'dart:convert';

import 'package:flutter_tdd_clean_test/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSource numberTriviaLocalDataSource;

  setUp(() => {
        mockSharedPreferences = MockSharedPreferences(),
        numberTriviaLocalDataSource = NumberTriviaLocalDataSourceImpl(
            sharedPreferences: mockSharedPreferences)
      });

  group('getLastNumberTrivia', () {
    test(
        'should return [NumberTriviaModel] from (SharedPreferences) when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA))
          .thenReturn((fixture('number_cached.json')));
      // act
      final result = await numberTriviaLocalDataSource.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(
          result,
          equals(NumberTriviaModel.fromJson(
              json.decode(fixture('number_cached.json')))));
      expect(result, isA<NumberTriviaModel>());
    });

    test(
        'should throw a [CacheException] when there is not a cached value in (SharedPref)',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = numberTriviaLocalDataSource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
