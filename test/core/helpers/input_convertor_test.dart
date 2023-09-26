import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/core/helpers/input_convertor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConvertor inputConvertor;
  setUp(() => {
        inputConvertor = InputConvertor(),
      });

  test('should return [int] when the *str is represent an unsigned integer',
      () async {
    // Arrange
    const str = '188';

    // Act
    final result = inputConvertor.stringToUnsignedInteger(str);

    // Assert
    // --verify something should(not) happen/call
    expect(result, const Right(188));
    // --expect something equals, isA, throwsA
  });

  test('should return [FailureMessage] when the *str is not an integer',
      () async {
    // Arrange
    const str = 'abc';
    const strNegativeNumber = '-123';

    // Act
    final result = inputConvertor.stringToUnsignedInteger(str);
    final result2 = inputConvertor.stringToUnsignedInteger(strNegativeNumber);

    // Assert
    // --verify something should(not) happen/call
    expect(result, Left(Failure()));
    expect(result2, Left(Failure()));
    // --expect something equals, isA, throwsA
  });
}
