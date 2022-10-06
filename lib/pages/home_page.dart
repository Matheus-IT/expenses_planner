import 'package:expenses_planner/components/chart.dart';
import 'package:expenses_planner/components/no_transactions_notice.dart';
import 'package:expenses_planner/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final List<TransactionModel> transactions =
      TransactionProvider().getAllTransactions();

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddNewTransactionArea(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  children: const [
                    Text('Expenses Planner'),
                    SizedBox(width: 4),
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () => showAddNewTransactionArea(context),
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Chart(recentTransactions: recentTransactions),
              ]),
            ),
            SliverPrototypeExtentList(
              prototypeItem: TransactionItem(
                transactionModel: transactions[0],
                onDeleteTransaction: handleDeleteTransaction,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => transactions.isEmpty
                    ? const NoTransactionsNotice()
                    : TransactionItem(
                        transactionModel: transactions[i],
                        onDeleteTransaction: handleDeleteTransaction,
                      ),
                childCount: transactions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
