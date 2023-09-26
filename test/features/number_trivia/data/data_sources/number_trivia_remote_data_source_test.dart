import 'package:flutter_tdd_clean_test/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late NumberTriviaRemoteDataSourceImpl remoteDataSource;
  setUp(() => {
        mockHttpClient = MockClient(),
        remoteDataSource =
            NumberTriviaRemoteDataSourceImpl(client: mockHttpClient)
      });

  int tNumber = 188;
  int tBoringNumber = 39485634;
  var url = "http://numbersapi.com/$tNumber?json";
  Uri uri = Uri.parse(url);
  // NumberTriviaModel tNumberTriviaModel = const NumberTriviaModel(
  //     text: "188 is the rank of Tonga in world population.",
  //     number: 188,
  //     found: true,
  //     type: "trivia");

  NumberTriviaModel tBoringTriviaModel = NumberTriviaModel(
      text: "$tBoringNumber is a boring number.",
      number: tBoringNumber,
      found: false,
      type: "trivia");

  group('NumberTriviaRemoteDataSourceImpl', () {
    test(
        'should perform GET request on URL with [int]number being the end point + application/json header',
        () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('number188.json'), 200));

      // Act
      remoteDataSource.getConcreteNumberTrivia(188);

      // Assert
      // --verify something should(not) happen/call
      verify(mockHttpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ));
      // --expect something equals, isA, throwsA
    });

    test(
        'should return [NumberTriviaModel] when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('number188.json'), 200));

      // Act
      final result = await remoteDataSource.getConcreteNumberTrivia(tNumber);

      // Assert
      // --verify something should(not) happen/call
      verify(mockHttpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ));
      // --expect something equals, isA, throwsA
      expect(result, isA<NumberTriviaModel>());
    });

    test(
        'should return boring [NumberTriviaModel] when the response code is 200 & *found is false',
        () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('number_boring.json'), 200));

      // Act
      final result =
          await remoteDataSource.getConcreteNumberTrivia(tBoringNumber);

      // Assert
      // --verify something should(not) happen/call
      // --expect something equals, isA, throwsA
      expect(result, isA<NumberTriviaModel>());
      expect(result, equals(tBoringTriviaModel));
    });

    test('should throw a [ServerException] when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('something go wrong', 404));

      // Act

      // Assert
      // --verify something should(not) happen/call
      // --expect something equals, isA, throwsA
      expect(() => remoteDataSource.getConcreteNumberTrivia(tBoringNumber),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
