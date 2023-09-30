import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Animal extends Equatable {
  String? name;

  Animal({
    this.name,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Cat extends Animal {
  int age;

  Cat({
    required this.age,
  });
}

void main() {
  Animal animal = Animal();
  Cat cat = Cat(age: 1);
  animal.name = 'cat';

  debugPrint(animal.name);
  debugPrint(cat.name);
  debugPrint(cat.age.toString());
}
