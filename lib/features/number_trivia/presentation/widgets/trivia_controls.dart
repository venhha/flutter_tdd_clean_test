import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_test/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControl extends StatefulWidget {
  const TriviaControl({
    super.key,
  });

  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  String inputStr = '';
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: textController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
        ),

        // Buttons search
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: dispatchConcrete,
          child: const Text('Search'),
        ),
      ],
    );
  }

  void dispatchConcrete() {
    textController.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetConcreteEvent(inputStr));
  }
}
