import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'number_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetConcreteNumberTrivia usecase;

  setUp(() => {
        mockNumberTriviaRepository = MockNumberTriviaRepository(),
        usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository)
      });

  NumberTrivia tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  group('usecase GetConcreteNumberTrivia test', () {
    test('should return [NumberTrivia] when call GetConcreteNumberTrivia',
        () async {
      //Arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //Act
      final result = await usecase(1);
      //Assert
      expect(result, Right(tNumberTrivia));
      //Verify
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(1));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    });
    test(
        'should return [Failure] when getConcreteNumberTrivia call with invalid input',
        () async {
      //Arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any)).thenAnswer(
          (_) async => Left(FailureMessage('invalid input')));
      //Act
      final result = await usecase(1);

      //Assert
      expect(result, Left(FailureMessage('invalid input')));
    });
  });
}
