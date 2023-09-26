import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_clean_test/core/helpers/input_convertor.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String kInputInvalidFailureMessage = 'Invalid Input';
const String kServerFailureMessage = 'Server Input';
const String kCacheFailureMessage = 'Cache Input';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUseCase _getConcreteNumberTrivia;
  final InputConvertor _inputConvertor;

  NumberTriviaBloc(
    this._getConcreteNumberTrivia,
    this._inputConvertor,
  ) : super(EmptyState()) {
    on<GetConcreteEvent>(
      (event, emit) async {
        emit(LoadingState());
        final inputEither =
            _inputConvertor.stringToUnsignedInteger(event.numberString);

        inputEither.fold(
          (inputFailure) {
            emit(const ErrorState(message: kInputInvalidFailureMessage));
          },
          (number) async {
            final result = await _getConcreteNumberTrivia(number);
            result.fold(
              (repoFailure) {
                emit(const ErrorState(message: kServerFailureMessage));
              },
              (trivia) {
                emit(LoadedState(trivia: trivia));
              },
            );
          },
        );
      },
    );
  }

  // NumberTriviaBloc(this._getConcreteNumberTrivia, this.inputConvertor)
  //     : super(Empty()) {
  //   on<NumberTriviaEvent>((event, emit) {
  //     if (event is GetTriviaForConcreteNumber) {

  //     }
  //   });
  // }
}
