// ignore_for_file: prefer_const_constructors //TODO: remove this line, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_tdd_clean_test/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaHomePage extends StatelessWidget {
  const NumberTriviaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia Page'),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: buildBody());
  }

  BlocProvider<NumberTriviaBloc> buildBody() {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Top part --display trivia number
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is EmptyState) {
                    return DisplayMessage(message: 'Start');
                  } else if (state is LoadingState) {
                    return DisplayLoading();
                  } else if (state is LoadedState) {
                    return DisplayMessage(message: state.trivia.text);
                  } else if (state is ErrorState) {
                    return DisplayMessage(message: state.message);
                  }
                  return DisplayMessage(message: 'Some thing went wrong!!!');
                },
              ),

              // Bottom part --display controls
              // Textfield
              TriviaControl(),
            ],
          ),
        ),
      ),
    );
  }

  Container displayText(String state) {
    return Container(
      child: Text(state),
    );
  }
}

class DisplayMessage extends StatelessWidget {
  final String message;
  const DisplayMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: SingleChildScrollView(
        child: Text(
          message,
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DisplayLoading extends StatelessWidget {
  const DisplayLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

class TriviaControl extends StatefulWidget {
  const TriviaControl({
    super.key,
  });

  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  String inputStr = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            inputStr = value;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
        ),

        // Buttons search
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<NumberTriviaBloc>(context)
                .add(GetConcreteEvent(inputStr));
          },
          child: Text('Search'),
        ),
      ],
    );
  }
}
