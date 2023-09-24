import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/network/network_info.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/repository/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
  //         int number) async =>
  //     await _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number));
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    Future<NumberTriviaModel> Function() getConcreteOrRandomNumberTrivia,
  ) async {
    if (await networkInfo.isConnectedByConnectivity) {
      try {
        NumberTriviaModel remoteNumberTriviaModel =
            await getConcreteOrRandomNumberTrivia();
        localDataSource.cacheNumberTrivia(remoteNumberTriviaModel);
        return Right(remoteNumberTriviaModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        NumberTriviaModel localNumberTriviaModel =
            await localDataSource.getLastNumberTrivia();
        return Right(localNumberTriviaModel);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
