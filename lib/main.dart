// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tdd_clean_test/config/theme/app_themes.dart';
import 'package:flutter_tdd_clean_test/features/news/presentation/pages/news_homepage.dart';
import 'package:flutter_tdd_clean_test/injection_container.dart';
import 'package:flutter_tdd_clean_test/test/todo_sample.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia', theme: appTheme(), home: NewsHomePage(),
      // routes: {
      //   '/numberTrivia': (context) => const NumberTriviaHomePage(),
      // },
    );

    // ? NumberTrivia
    // @override
    // Widget build(BuildContext context) {
    //   return MaterialApp(
    //     title: 'Number Trivia',
    //     theme: appTheme(),
    //     home: const IntroPage(),
    //     routes: {
    //       '/numberTrivia': (context) => const NumberTriviaHomePage(),
    //     },
    //   );
    // }
  }
}

class SomePage extends StatefulWidget {
  const SomePage({
    super.key,
  });

  @override
  State<SomePage> createState() => _SomePageState();
}

class _SomePageState extends State<SomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Index 0: Business')),
    const Text('Index 1: Business'),
    const Text('Index 2: School'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home-outline.svg'),
            label: '',
            backgroundColor: Colors.blue,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '',
            backgroundColor: Colors.green,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '',
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
