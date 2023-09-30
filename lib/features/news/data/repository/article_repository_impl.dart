import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/network/network_info.dart';
import 'package:flutter_tdd_clean_test/features/news/data/data_sources/remote/news_remote_datasource.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NetworkInfo networkInfo;
  final NewsRemoteDataSource newsRemoteDataSource;

  const ArticleRepositoryImpl({
    required this.networkInfo,
    required this.newsRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles({
    String q = '',
    String from = '',
    String to = '',
    String sortBy = '',
  }) async {
    // check network connection
    try {
      if (await networkInfo.isConnectedByConnectivity) {
        final result = await newsRemoteDataSource.getArticleModelsFromRemote(
          q: q,
          from: from,
          to: to,
          sortBy: sortBy,
        );
        return Right(result);
      } else {
        return const Left(NetworkFailure());
      }
    } on ServerException {
      // .DONE : handle ServerException with specific exception
      return const Left(ServerFailure());
    }
  }
}
