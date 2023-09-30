import 'package:flutter/material.dart';

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
