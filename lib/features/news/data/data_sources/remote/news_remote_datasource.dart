import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_tdd_clean_test/core/constants/constants.dart';
import 'package:flutter_tdd_clean_test/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_test/features/news/data/models/article.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  /// Calls the https://newsapi.org/v2/everything endpoint and return [List<ArticleModel>].
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ArticleModel>> getArticleModelsFromRemote({
    String q = '',
    String from = '',
    String to = '',
    String sortBy = '',
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getArticleModelsFromRemote({
    String q = '',
    String from = '',
    String to = '',
    String sortBy = '',
  }) async {
    return _getArticleModelFromUrl('$newsAPIBaseURL'
        '?q=$q&from=$from&to=$to&sortBy=$sortBy');
  }

  Future<List<ArticleModel>> _getArticleModelFromUrl(String url) async {
    Uri uri = Uri.parse(url);
    var response = await client.get(uri, headers: {'X-Api-Key': newsAPIKey});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      if (jsonMap['totalResults'] != 0) {
        List<ArticleModel> articleModels = [];
        jsonMap['articles'].forEach((article) {
          articleModels.add(ArticleModel.fromJson(article));
        });
        return articleModels;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException("ServerException with statusCode: ${response.statusCode}");
    }
  }
}
