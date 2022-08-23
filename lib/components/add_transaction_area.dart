import 'package:flutter/material.dart';

class AddTransactionArea extends StatelessWidget {
  const AddTransactionArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(decoration: InputDecoration(label: Text('Title'))),
          TextField(decoration: InputDecoration(label: Text('Amount'))),
          TextButton(
            style: TextButton.styleFrom(surfaceTintColor: Colors.purple),
            onPressed: () {},
            child: const Text('Add transaction'),
          )
        ]),
      ),
    );
  }
}
