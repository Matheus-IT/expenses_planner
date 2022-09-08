import 'package:expenses_planner/components/chart_bar.dart';
import 'package:expenses_planner/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> recentTransactions;

  const Chart({required this.recentTransactions, super.key});

  List<Map<String, Object>> get groupedTransactionValues {
    const daysOfWeek = 7;
    return List.generate(daysOfWeek, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final dayShortVersion = DateFormat.E().format(weekDay).substring(0, 1);

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

  double get totalSpending {
    return groupedTransactionValues.fold<double>(0.0, (accumulator, item) {
      return accumulator + (item['amount'] as double);
    });
  }

  double calcSpendingPercentageOfTotal(double amount) {
    if (totalSpending == 0) {
      return 0;
    }
    return amount / totalSpending;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: groupedTransactionValues
              .map(
                (transactionData) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: transactionData['day'] as String,
                    spendingAmount: transactionData['amount'] as double,
                    spendingPercentageOfTotal: calcSpendingPercentageOfTotal(
                        transactionData['amount'] as double),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
