import 'package:flutter/material.dart';

class NoTransactionsNotice extends StatelessWidget {
  const NoTransactionsNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No transactions yet...',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
