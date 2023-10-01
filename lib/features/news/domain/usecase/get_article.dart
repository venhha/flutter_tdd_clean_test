import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/usecase/usecase.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/repository/article_repository.dart';

class GetArticleUseCase extends UseCase<List<ArticleEntity>, GetArticleParams> {
  final ArticleRepository repository;

  GetArticleUseCase(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(
      GetArticleParams params) async {
    return await repository.getArticles(
      q: params.q,
      from: params.from,
      to: params.to,
      sortBy: params.sortBy,
    );
  }
}

class GetArticleParams {
  final String q;
  final String from;
  final String to;
  final String sortBy;

  GetArticleParams({
    this.q = '',
    this.from = '',
    this.to = '',
    this.sortBy = '',
  });
}
