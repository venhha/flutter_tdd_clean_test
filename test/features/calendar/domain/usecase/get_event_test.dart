import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/features/calendar/domain/entities/event_entity.dart';
import 'package:flutter_tdd_clean_test/features/calendar/domain/repository/event_repository.dart';
import 'package:flutter_tdd_clean_test/features/calendar/domain/usecase/get_event.dart';
import 'package:logger/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_event_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late GetEvent getEvent;
  setUp(() => {
        mockEventRepository = MockEventRepository(),
        getEvent = GetEvent(mockEventRepository),
      });

  EventEntity eventEntity = EventEntity(
    summary: 'summary',
    description: 'description',
    start: DateTime.now(),
    end: DateTime.now(),
  );

  test('should return an EventEntity when call getEvent', () async {
    //Arrange
    when(mockEventRepository.getEvent(any))
        .thenAnswer((_) async => Right(eventEntity));
    //Act
    final result = await getEvent('summary');
    //Assert
    expect(result, Right(eventEntity));
  });
}
