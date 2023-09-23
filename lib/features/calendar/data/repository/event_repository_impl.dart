import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repository/event_repository.dart';

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
