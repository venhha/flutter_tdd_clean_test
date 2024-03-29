import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// [Type] is the return type of the use case. [Params] is the parameters that the use case needs to run.
///
/// Pass [NoParams] if the use case doesn't need any parameters
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
