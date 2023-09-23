import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

import '../entities/event_entity.dart';
import '../repository/event_repository.dart';

class GetEvent extends UseCase<EventEntity, String> {
  final EventRepository _eventRepository;

  GetEvent(this._eventRepository);

  @override
  Future<Either<Failure, EventEntity>> call(String params) {
    return _eventRepository.getEvent(params);
  }
}
