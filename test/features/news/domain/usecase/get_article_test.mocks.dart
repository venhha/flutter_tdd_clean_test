// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_tdd_clean_test/test/features/news/domain/usecase/get_article_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter_tdd_clean_test/core/error/failures.dart' as _i5;
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart'
    as _i6;
import 'package:flutter_tdd_clean_test/features/news/domain/repository/article_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ArticleRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockArticleRepository extends _i1.Mock implements _i3.ArticleRepository {
  MockArticleRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ArticleEntity>>> getArticles({
    String? q = r'',
    String? from = r'',
    String? to = r'',
    String? sortBy = r'',
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getArticles,
          [],
          {
            #q: q,
            #from: from,
            #to: to,
            #sortBy: sortBy,
          },
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.ArticleEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.ArticleEntity>>(
          this,
          Invocation.method(
            #getArticles,
            [],
            {
              #q: q,
              #from: from,
              #to: to,
              #sortBy: sortBy,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.ArticleEntity>>>);
}
