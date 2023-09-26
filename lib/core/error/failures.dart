import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class FailureMessage extends Failure {
  final String message;

  FailureMessage([this.message = 'Something went wrong!!!']);

  @override
  List<Object> get props => [message];
}
