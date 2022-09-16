import 'package:expenses_planner/dummy_data.dart';
import 'package:expenses_planner/models/transaction_model.dart';

class TransactionProvider {
  final List<TransactionModel> allTransactions = dummyData;

  List<TransactionModel> getAllTransactions() {
    return [...allTransactions];
  }
}
