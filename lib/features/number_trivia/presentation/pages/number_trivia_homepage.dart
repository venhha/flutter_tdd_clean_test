// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/widgets/barrel_number_widgets.dart';
import 'package:flutter_tdd_clean_test/injection_container.dart';

class NumberTriviaHomePage extends StatelessWidget {
  const NumberTriviaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Number Trivia App'),
    );
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
                builder: (_, state) {
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
