import 'package:expenses_planner/components/chart.dart';
import 'package:expenses_planner/components/no_transactions_notice.dart';
import 'package:expenses_planner/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/add_transaction_area.dart';
import '../components/transaction_item.dart';
import '../models/transaction_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionModel> transactions = dummyData;

  void handleAddTransaction(
    String title,
    String amount,
    DateTime selectedDate,
  ) {
    final newTransaction = TransactionModel(
      title: title,
      amount: double.parse(amount),
      date: selectedDate,
      id: const Uuid().v4(),
    );
    setState(() => transactions.add(newTransaction));
    Navigator.of(context).pop();
  }

  void handleDeleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void showAddNewTransactionArea(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransactionArea(onSubmit: handleAddTransaction);
        });
  }

  List<TransactionModel> get recentTransactions {
    return transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print('build() _HomePageState');
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
      body: SafeArea(
        child: Column(
          children: [
            transactions.isEmpty
                ? const NoTransactionsNotice()
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        if (index == 0) {
                          return Chart(recentTransactions: transactions);
                        }
                        return TransactionItem(
                          transactionModel: transactions[index],
                          onDeleteTransaction: handleDeleteTransaction,
                        );
                      },
                      itemCount: transactions.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
