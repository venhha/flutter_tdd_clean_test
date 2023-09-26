import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/usecase/usecase.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/repository/number_trivia_repository.dart';

class GetConcreteNumberTriviaUseCase implements UseCase<NumberTrivia, int> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUseCase(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(int number) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
