import 'dart:io';

final currentDirectory = Directory.current.path;
String fixture(String name) =>
    File('$currentDirectory/test/fixtures/$name').readAsStringSync();
