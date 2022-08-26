import 'package:expenses_planner/components/transaction_item.dart';
import 'package:flutter/material.dart';

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

class MyHomePage extends StatelessWidget {
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
  ];

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 5,
              child: Text('Card 1'),
            ),
          ),
          AddTransactionArea(),
          Column(
            children: transactions.map((transaction) {
              return TransactionItem(transactionModel: transaction);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
