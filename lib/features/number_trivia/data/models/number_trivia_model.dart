import 'package:flutter_tdd_clean_test/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final String type;
  final bool found;

  const NumberTriviaModel({
    required super.text,
    required super.number,
    required this.found,
    required this.type,
  });

  @override
  List<Object> get props => [text, number];

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number: (json['number'] as num).toInt(),
      found: json['found'], //bool
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
      'found': found,
      'type': type,
    };
  }
}
