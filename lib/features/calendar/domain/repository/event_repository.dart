import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_test/core/error/failures.dart';

import '../entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<FailureMessage, EventEntity>> getEvent(String summary);
}

