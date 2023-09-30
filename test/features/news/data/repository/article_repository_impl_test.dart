import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/network/network_info.dart';
import 'package:flutter_tdd_clean_test/features/news/data/data_sources/remote/news_remote_datasource.dart';
import 'package:flutter_tdd_clean_test/features/news/data/models/article.dart';
import 'package:flutter_tdd_clean_test/features/news/data/repository/article_repository_impl.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'article_repository_impl_test.mocks.dart';

@GenerateMocks([NewsRemoteDataSource, NetworkInfo])
void main() {
  late ArticleRepositoryImpl repo;
  late MockNetworkInfo mockNetworkInfo;
  late MockNewsRemoteDataSource mockNewRemoteService;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockNewRemoteService = MockNewsRemoteDataSource();
    repo = ArticleRepositoryImpl(
      networkInfo: mockNetworkInfo,
      newsRemoteDataSource: mockNewRemoteService,
    );
  });

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnectedByConnectivity)
          .thenAnswer((_) async => true);
    });
    // list [List<ArticleEntity>] demo
    List<ArticleEntity> tListArticleEntity = [
      const ArticleEntity(
        id: '1',
        title: 'title',
        description: 'description',
        url: 'url',
        urlToImage: 'urlToImage',
        publishedAt: 'publishedAt',
        content: 'content',
      ),
      const ArticleEntity(
        id: '2',
        title: 'title2',
        description: 'description2',
        url: 'url2',
        urlToImage: 'urlToImage2',
        publishedAt: 'publishedAt2',
        content: 'content2',
      )
    ];

    List<ArticleModel> tListArticleModel = [
      const ArticleModel(
        id: '1',
        title: 'title',
        description: 'description',
        url: 'url',
        urlToImage: 'urlToImage',
        publishedAt: 'publishedAt',
        content: 'content',
      ),
      const ArticleModel(
        id: '2',
        title: 'title2',
        description: 'description2',
        url: 'url2',
        urlToImage: 'urlToImage2',
        publishedAt: 'publishedAt2',
        content: 'content2',
      )
    ];

    test(
        'should return [List<ArticleEntity>] when {getArticles} from repo success',
        () async {
      // Arrange (setup @mocks)
      when(mockNewRemoteService.getArticleModelsFromRemote())
          .thenAnswer((_) async => tListArticleModel);
      // Act
      final result = await repo.getArticles();
      // Assert
      // --verify something should(not) happen/call
      verify(mockNewRemoteService.getArticleModelsFromRemote());
      // --expect something equals, isA, throwsA
      expect(result, isA<Either<Failure, List<ArticleEntity>>>());
      expect(result, equals(Right(tListArticleModel)));
    });

    test('should return [ServerFailure] when {getArticles} from repo unsuccess',
        () async {
      // Arrange (setup @mocks)
      when(mockNewRemoteService.getArticleModelsFromRemote())
          .thenThrow(ServerException());
      // Act
      final result = await repo.getArticles();

      // Assert
      // --verify something should(not) happen/call
      verify(mockNewRemoteService.getArticleModelsFromRemote());
      // --expect something equals, isA, throwsA
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
