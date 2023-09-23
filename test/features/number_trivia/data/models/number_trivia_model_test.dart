import 'dart:convert';

import 'package:flutter_tdd_clean_test/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(
      number: 188,
      text: '188 is the rank of Tonga in world population.',
      found: true,
      type: 'trivia');
  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a [NumberTriviaModel] when the JSON number is an integer',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('number188.json'));
          // act
          final result = NumberTriviaModel.fromJson(jsonMap);
          // assert
          expect(result, tNumberTriviaModel);
        },
      );
    },
  );
}
