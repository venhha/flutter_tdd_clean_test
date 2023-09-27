import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/pages/number_trivia_homepage.dart';
import 'package:flutter_tdd_clean_test/injection_container.dart';

void main() async {
  // Initialize the binding before calling runApp().
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
      ),
      home: const NumberTriviaHomePage(),
    );
  }
}
