import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/number_trivia_local_data_source.dart';
import '../data_sources/number_trivia_remote_data_source.dart';
import '../models/number_trivia_model.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repository/number_trivia_repository.dart';

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
        return const Left(ServerFailure());
      }
    } else {
      try {
        NumberTriviaModel localNumberTriviaModel =
            await localDataSource.getLastNumberTrivia();
        return Right(localNumberTriviaModel);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }
}
