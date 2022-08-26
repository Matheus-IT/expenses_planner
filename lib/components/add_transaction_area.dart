import 'package:flutter/material.dart';

class AddTransactionArea extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void Function(String, String) onSubmit;

  AddTransactionArea({required this.onSubmit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(label: Text('Title')),
            controller: titleController,
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Amount')),
            controller: amountController,
          ),
          TextButton(
            style: TextButton.styleFrom(surfaceTintColor: Colors.purple),
            onPressed: () =>
                onSubmit(titleController.text, amountController.text),
            child: const Text('Add transaction'),
          )
        ]),
      ),
    );
  }
}
