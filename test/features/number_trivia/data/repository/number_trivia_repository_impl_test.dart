import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/network/network_info.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NumberTriviaLocalDataSource])
@GenerateMocks([NumberTriviaRemoteDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  late MockNumberTriviaLocalDataSource localDataSource;
  late MockNumberTriviaRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late NumberTriviaRepositoryImpl repository;
  setUp(() {
    localDataSource = MockNumberTriviaLocalDataSource();
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
        networkInfo: networkInfo);
  });

  NumberTriviaModel tNumberTriviaModel = const NumberTriviaModel(
      number: 188,
      text: '188 is the rank of Tonga in world population.',
      found: true,
      type: 'trivia');

  test('should return [NumberTriviaModel] from the local storage', () async {
    //Arrange
    when(localDataSource.getLastNumberTrivia())
        .thenAnswer((_) async => tNumberTriviaModel);
    //Act
    final result = await localDataSource.getLastNumberTrivia();
    //Assert
    verify(localDataSource.getLastNumberTrivia());
    expect(result, equals(tNumberTriviaModel));
  });

  group('device is online', () {
    setUp(() => {when(networkInfo.isConnectedByConnectivity).thenAnswer((_) async => true)});
    test(
        'should return [NumberTriviaModel] when the call to {remoteDataSource} is successful',
        () async {
      // Arrange
      when(remoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);
      when(localDataSource.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      // Act
      final result = await repository.getConcreteNumberTrivia(188);

      // Assert
      verify(repository.getConcreteNumberTrivia(188));
      expect(result, equals(Right(tNumberTriviaModel)));
    });

    test(
        'should cache the data [NumberTriviaModel] locally when the call to {remoteDataSource} is successful',
        () async {
      // Arrange
      when(remoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);

      // Act
      await repository.getConcreteNumberTrivia(188);

      // Assert
      verify(remoteDataSource.getConcreteNumberTrivia(188));
      verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });
    test(
        'should return [ServerFailure] when the call to {remoteDataSource} is unsuccessful',
        () async {
      // Arrange
      when(remoteDataSource.getConcreteNumberTrivia(any))
          .thenThrow(ServerException());

      // Act
      final result = await repository.getConcreteNumberTrivia(188);

      // Assert
      verify(remoteDataSource.getConcreteNumberTrivia(188));
      verifyZeroInteractions(localDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('device is offline', () {
    setUp(() => {when(networkInfo.isConnectedByConnectivity).thenAnswer((_) async => false)});
    test(
        'should return [NumberTriviaModel] the last locally cached data in {localDataSource} if there is cache data present',
        () async {
      // Arrange
      when(localDataSource.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      // Act
      final result = await repository.getConcreteNumberTrivia(188);

      // Assert
      verify(localDataSource.getLastNumberTrivia());
      verifyZeroInteractions(remoteDataSource);
      expect(result, equals(Right(tNumberTriviaModel)));
    });
    test(
        'should return [CacheFailure] in {localDataSource} if there is no cache data present',
        () async {
      // Arrange
      when(localDataSource.getLastNumberTrivia()).thenThrow(CacheException());

      // Act
      final result = await repository.getConcreteNumberTrivia(188);

      // Assert
      verify(localDataSource.getLastNumberTrivia());
      verifyZeroInteractions(remoteDataSource);
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
