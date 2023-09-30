import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/input_convertor.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecase/get_concrete_number_trivia.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String kInputInvalidFailureMessage =
    'Invalid Input - You must enter a positive integer';
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

        await inputEither.fold(
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
