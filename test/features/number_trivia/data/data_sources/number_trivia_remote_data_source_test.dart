import 'package:flutter_tdd_clean_test/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
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
  var url = "http://numbersapi.com/$tNumber";
  Uri uri = Uri.parse(url);

  test(
      'should perform GET request on URL with [int]number being the end point + application/json header',
      () async {
    // Arrange
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('number188.json'), 200));

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
}
