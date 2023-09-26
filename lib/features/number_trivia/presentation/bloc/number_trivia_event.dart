part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcreteEvent extends NumberTriviaEvent {
  final String numberString;

  const GetConcreteEvent(this.numberString);

  @override
  List<Object> get props => [numberString];
}
