import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/helpers/input_convertor.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([
  GetConcreteNumberTriviaUseCase,
  InputConvertor,
])
void main() {
  late GetConcreteNumberTriviaUseCase usecase;
  late InputConvertor inputConvertor;
  late NumberTriviaBloc bloc;

  setUp(() => {
        usecase = MockGetConcreteNumberTriviaUseCase(),
        inputConvertor = MockInputConvertor(),
        bloc = NumberTriviaBloc(
          usecase,
          inputConvertor,
        )
      });

  const tNumberString = '188';
  const tNumberParsed = 188;
  const tNumberTrivia = fixtureNumberTrivia;

  test('should init EmptyState', () async {
    // --expect something equals, isA, throwsA
    expect(bloc.state, equals(EmptyState()));
  });

  group("NumberTriviaBloc", () {
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [LoadingState,LoadedState] when GetConcreteEvent is added',
      build: () {
        when(inputConvertor.stringToUnsignedInteger(tNumberString))
            .thenReturn(const Right(tNumberParsed));
        when(usecase(tNumberParsed))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetConcreteEvent(tNumberString)),
      expect: () => [
        LoadingState(),
        const LoadedState(trivia: tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [LoadingState,ErrorState] when the input is invalid',
      build: () {
        when(inputConvertor.stringToUnsignedInteger(tNumberString))
            .thenReturn(Left(Failure()));
        when(usecase(tNumberParsed))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetConcreteEvent(tNumberString)),
      expect: () => [
        LoadingState(),
        const ErrorState(message: kInputInvalidFailureMessage),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [LoadingState,ErrorState] when the server fails',
      build: () {
        when(inputConvertor.stringToUnsignedInteger(tNumberString))
            .thenReturn(const Right(tNumberParsed));
        when(usecase(tNumberParsed))
            .thenAnswer((_) async => Left(Failure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetConcreteEvent(tNumberString)),
      expect: () => [
        LoadingState(),
        const ErrorState(message: kServerFailureMessage),
      ],
    );
  });
}
