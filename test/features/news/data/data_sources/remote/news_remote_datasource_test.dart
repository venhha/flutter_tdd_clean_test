import 'package:flutter/foundation.dart';
import 'package:flutter_tdd_clean_test/features/news/data/data_sources/remote/news_remote_datasource.dart';
import 'package:flutter_tdd_clean_test/features/news/data/models/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  late NewsRemoteDataSource remoteDateSource;
  setUp(() => {
        remoteDateSource = NewsRemoteDataSourceImpl(client: http.Client()),
      });
  group('getArticleModelsFromRemote', () {
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      //arrange
      //act
      final result =
          await remoteDateSource.getArticleModelsFromRemote(q: 'tesla');
      debugPrint(result.toString());

      //assert
      expect(result, isA<List<ArticleModel>>());
    });
  });
}
