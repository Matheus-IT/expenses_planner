import 'package:expenses_planner/components/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'components/add_transaction_area.dart';
import 'models/transaction_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> transactions = [
    TransactionModel(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 't3',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 't4',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 't5',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 't6',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void handleAddTransaction(String title, String amount) {
    final newTransaction = TransactionModel(
      title: title,
      amount: double.parse(amount),
      date: DateTime.now(),
      id: const Uuid().v4(),
    );
    setState(() => transactions.add(newTransaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text('Card 1'),
              ),
            ),
            AddTransactionArea(onSubmit: handleAddTransaction),
            SizedBox(
              height: 350,
              child: ListView.builder(
                itemBuilder: (ctx, index) =>
                    TransactionItem(transactionModel: transactions[index]),
                itemCount: transactions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
