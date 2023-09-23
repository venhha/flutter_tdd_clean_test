import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';
import 'package:flutter_tdd_clean_test/features/calendar/domain/entities/event_entity.dart';
import 'package:flutter_tdd_clean_test/features/calendar/domain/repository/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  @override
  Future<Either<FailureMessage, EventEntity>> getEvent(String summary) async {
    if (summary.isNotEmpty) {
      final EventEntity event = EventEntity(
        summary: summary,
        description: 'description',
        start: DateTime.now(),
        end: DateTime.now(),
      );
      return Right(event);
    } else {
      return Left(FailureMessage('FailureMessage'));
    }
  }
}
