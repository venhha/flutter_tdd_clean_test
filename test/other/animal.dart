import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Animal extends Equatable {
  final String? name;

  const Animal(this.name);


  @override
  List<Object?> get props => [name];
}