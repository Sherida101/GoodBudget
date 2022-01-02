import 'package:good_budget/models/transaction.dart';
import 'package:good_budget/utils/constants.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>(Constants.hiveDBName);
}
