import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/add_transaction_area.dart';
import '../components/transaction_item.dart';
import '../dummy_data.dart';
import '../models/transaction_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionModel> transactions = dummyData;

  void handleAddTransaction(String title, String amount) {
    final newTransaction = TransactionModel(
      title: title,
      amount: double.parse(amount),
      date: DateTime.now(),
      id: const Uuid().v4(),
    );
    setState(() => transactions.add(newTransaction));
    Navigator.of(context).pop();
  }

  void showAddNewTransactionArea(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransactionArea(onSubmit: handleAddTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: () => showAddNewTransactionArea(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddNewTransactionArea(context),
        child: const Icon(Icons.add),
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
            SizedBox(
              height: 350,
              child: !transactions.isEmpty
                  ? Column(
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
                    )
                  : ListView.builder(
                      itemBuilder: (ctx, index) => TransactionItem(
                          transactionModel: transactions[index]),
                      itemCount: transactions.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
