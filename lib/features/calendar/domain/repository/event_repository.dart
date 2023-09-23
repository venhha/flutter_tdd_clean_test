import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<FailureMessage, EventEntity>> getEvent(String summary);
}

