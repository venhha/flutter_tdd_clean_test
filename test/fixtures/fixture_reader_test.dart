import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tdd_clean_test/features/news/data/models/article.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

// public the fixture NumberTrivia Object to test
const NumberTrivia fixtureNumberTrivia = NumberTrivia(
  text: '188 is the rank of Tonga in world population.',
  number: 188,
);

final currentDirectory = Directory.current.path;
String fixture(String name) =>
    File('$currentDirectory/test/fixtures/$name').readAsStringSync();

void main() {
  test("print fixture", () {
    debugPrint(fixture('article.json'));
    String strMap = fixture('article.json');

    ArticleModel articleModel = ArticleModel.fromJsonStrMap(strMap);

  });
}
