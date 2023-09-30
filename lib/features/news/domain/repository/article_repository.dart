import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleEntity>>> getArticles({
    String q = '',
    String from = '',
    String to = '',
    String sortBy = '',
  });
}
