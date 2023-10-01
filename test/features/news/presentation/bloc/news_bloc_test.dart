import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';
import 'package:flutter_tdd_clean_test/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/usecase/get_article.dart';

import 'news_bloc_test.mocks.dart';

@GenerateMocks([GetArticleUseCase])
void main() {
  late GetArticleUseCase mockUsecase;
  late NewsBloc bloc;

  setUp(() => {
        mockUsecase = MockGetArticleUseCase(),
        bloc = NewsBloc(mockUsecase),
      });

  test('init NewsInitial state', () async {
    //Assert
    expect(bloc.state, equals(NewsInitialState()));
  });

  GetArticleParams tParams = GetArticleParams();
  GetArticleParams tParams2 = GetArticleParams(q: 'google');

  test('test ArticleUsecaseParams', () {
    //Assert
    expect(tParams, isA<GetArticleParams>());
    expect(tParams.q, equals(''));
    expect(tParams.from, equals(''));
    expect(tParams.to, equals(''));
    expect(tParams.sortBy, equals(''));

    expect(tParams2, isA<GetArticleParams>());
    expect(tParams2.q, equals('google'));
  });

  List<ArticleEntity> tListArticles = <ArticleEntity>[];

  group('NewsBloc', () {
    blocTest<NewsBloc, NewsState>(
      'should emit [NewsLoading,NewsLoaded] when {GetNewsEvent} is added success',
      build: () {
        when(mockUsecase(tParams2))
            .thenAnswer((_) async => Right(tListArticles));
        return bloc;
      },
      act: (bloc) => bloc.add(GetNewsEvent(tParams2)),
      expect: () => [
        NewsLoadingState(),
        NewsLoadedState(articles: tListArticles),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'should emit [NewsLoadingState,NewsErrorState] when {GetNewsEvent} is added failure',
      build: () {
        when(mockUsecase(tParams2))
            .thenAnswer((_) async => const Left(NetworkFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetNewsEvent(tParams2)),
      expect: () => [
        NewsLoadingState(),
        NewsErrorState(message: const NetworkFailure().message),
      ],
    );
  });
}
