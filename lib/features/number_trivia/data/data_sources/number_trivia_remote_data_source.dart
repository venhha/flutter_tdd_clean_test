import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint and return [NumberTriviaModel].
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  // Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getNumberTriviaFromUrl('http://numbersapi.com/$number?json');

  Future<NumberTriviaModel> _getNumberTriviaFromUrl(String url) async {
    try {
      Uri uri = Uri.parse(url);

      var res = await client.get(
        uri, //the url passed in the function
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(res.body);
        if (jsonMap['found'] == false) {
          return NumberTriviaModel(
              text: jsonMap['text'],
              number: jsonMap['number'],
              found: false,
              type: "trivia");
        } else {
          return NumberTriviaModel.fromJson(jsonMap);
        }
      } else {
        throw ServerException("Error with Code ${res.statusCode}");
      }
    } catch (e) {
      throw ServerException();
    }
  }
}

/*
@override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      url as Uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
*/
