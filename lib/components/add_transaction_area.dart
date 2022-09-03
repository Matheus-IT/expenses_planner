import 'package:flutter/material.dart';

class AddTransactionArea extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final void Function(String, String) onSubmit;

  AddTransactionArea({required this.onSubmit, Key? key}) : super(key: key);

  String? titleValidator(String? inputTitle) {
    if (inputTitle == null || inputTitle.isEmpty) {
      return 'You need to enter some title.';
    }

    if (inputTitle.length > 50) {
      return 'Maximum of 50 characters for title';
    }

    return null;
  }

  String? amountValidator(String? inputAmount) {
    if (inputAmount == null || inputAmount.isEmpty) {
      return 'You need to enter some amount';
    }

    double? amount = double.tryParse(inputAmount);

    if (amount == null || amount <= 0) {
      return 'Invalid amount value';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Title')),
                controller: titleController,
                validator: titleValidator,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                  decoration: const InputDecoration(label: Text('Amount')),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: amountController,
                  validator: amountValidator,
                  textInputAction: TextInputAction.done),
              TextButton(
                style: TextButton.styleFrom(surfaceTintColor: Colors.purple),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onSubmit(titleController.text, amountController.text);
                  }
                },
                child: const Text('Add transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
