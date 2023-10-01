import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test syntax', () async {
    //Arrange

    //Act

    //Assert
    String? dataCanNull;
    bool? isOk;


    if (isOk!) {
      debugPrint('isOk is true');
    } else {
      debugPrint('isOk is false');
    }

    // display(dataCanNull!);

    // if (!dataCanNull.isEmpty) {
    //   debugPrint('dataCanNull is empty');
    // } else {
    //   debugPrint('dataCanNull is not empty');
    // }
  });
}

void display(String dataCanNotNull) {
  debugPrint(dataCanNotNull);
}
