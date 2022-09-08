import 'package:expenses_planner/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final List<TransactionModel> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    const daysOfWeek = 7;
    return List.generate(daysOfWeek, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final dayShortVersion = DateFormat.E(weekDay);

      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': dayShortVersion, 'amount': totalSum};
    });
  }

  const CustomCard({required this.recentTransactions, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(8),
      child: Row(
        children: [],
      ),
    );
  }
}
