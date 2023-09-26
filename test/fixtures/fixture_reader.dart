import 'dart:io';

import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';

// public the fixture NumberTrivia Object to test
const NumberTrivia fixtureNumberTrivia = NumberTrivia(
  text: '188 is the rank of Tonga in world population.',
  number: 188,
);

final currentDirectory = Directory.current.path;
String fixture(String name) =>
    File('$currentDirectory/test/fixtures/$name').readAsStringSync();
