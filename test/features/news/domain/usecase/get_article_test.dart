import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/repository/article_repository.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/usecase/get_article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:logger/logger.dart';

import 'get_article_test.mocks.dart';

@GenerateMocks([ArticleRepository])
void main() {
  late MockArticleRepository repository;
  late GetArticleUseCase usecase;

  setUp(() {
    repository = MockArticleRepository();
    usecase = GetArticleUseCase(repository);
  });

  test('should return [List<ArticleEntity>] when OK', () async {
    // Arrange (setup @mocks)
    when(repository.getArticles(
      q: 'google',
      from: '',
      to: '',
      sortBy: '',
    )).thenAnswer((_) async => const Right(<ArticleEntity>[]));

    // Act
    final result = await usecase(GetArticleParams(q: 'google'));

    // Assert
    // --verify something should(not) happen/call
    verify(repository.getArticles(
      q: 'google',
      from: '',
      to: '',
      sortBy: '',
    ));
    // --expect something equals, isA, throwsA
    expect(result, const Right(<ArticleEntity>[]));
  });

  test('should return [Failure] when not OK', () async {
    // Arrange (setup @mocks)
    when(repository.getArticles(
      q: 'google',
      from: '',
      to: '',
      sortBy: '',
    )).thenAnswer((_) async => const Left(ServerFailure()));
    // Act
    final result = await usecase(GetArticleParams(q: 'google'));

    // Assert
    // --verify something should(not) happen/call
    verify(repository.getArticles(
      q: 'google',
      from: '',
      to: '',
      sortBy: '',
    ));
    // --expect something equals, isA, throwsA
    expect(result, const Left(ServerFailure()));
  });
}
