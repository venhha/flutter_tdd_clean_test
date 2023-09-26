import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';

class InputConvertor {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(Failure());
    }
  }
}
