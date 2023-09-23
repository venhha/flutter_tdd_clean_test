// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String summary; //Title of the event.
  final DateTime start;
  final DateTime end;
  final String? description; //Description of the event.HTML --Optional
  final String? location;

  const EventEntity({
    required this.summary,
    required this.start,
    required this.end,
    this.description,
    this.location,
  });

  @override
  List<Object?> get props => [summary, start, end, description, location];
}
