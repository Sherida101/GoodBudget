import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:good_budget/models/transaction.dart';
import 'package:good_budget/utils/boxes.dart';
import 'package:good_budget/utils/constants.dart';
import 'package:good_budget/widget/transaction_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String currencySymbol = '\$';

  FlutterSwitch showThemeToggleButton(isDarkModeOn) => FlutterSwitch(
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      value: isDarkModeOn,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: const Color(0xFF6E40C9),
      inactiveToggleColor: const Color(0xFF2F363D),
      activeSwitchBorder: Border.all(
        color: const Color(0xFF3C1E70),
        width: 6.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: const Color(0xFFD1D5DA),
        width: 6.0,
      ),
      activeColor: const Color(0xFF271052),
      inactiveColor: Colors.white,
      activeIcon: const Icon(
        Icons.nightlight_round,
        color: Color(0xFFF8E3A1),
      ),
      inactiveIcon: const Icon(
        Icons.wb_sunny,
        color: Color(0xFFFFDF5D),
      ),
      onToggle: (val) {
        EasyDynamicTheme.of(context).changeTheme();
        setState(() {
          isDarkModeOn = val;
        });
      });

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(Constants.appName),
        centerTitle: true,
        actions: [showThemeToggleButton(isDarkModeOn)],
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Boxes.getTransactions().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<Transaction>();

          return buildContent(transactions, isDarkModeOn);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => TransactionDialog(
            onClickedDone: addTransaction,
          ),
        ),
      ),
    );
  }

  Widget buildContent(List<Transaction> transactions, bool isDarkModeOn) {
    if (transactions.isEmpty) {
      return Column(children: <Widget>[
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            Constants.appLogo,
            height: 150,
            width: 100,
          ),
        ),
        Image.asset('assets/images/no_data.png'),
        const Center(
            child: Text('You have no expenses as yet',
                style: TextStyle(fontSize: 19))),
      ]);
    } else {
      final netExpenseCurrencySymbol =
          transactions.fold<String>('', (previousValue, transaction) {
        return transaction.amountCurrencySymbol;
      });

      final netExpense =
          transactions.fold<double>(0, (previousValue, transaction) {
        if (transaction.isExpense) {
          return previousValue - transaction.amount;
        } else {
          return previousValue + transaction.amount;
        }
      });

      debugPrint(
          'Net Expense:  $netExpenseCurrencySymbol${netExpense.toStringAsFixed(2)}');
      // final newExpenseString =
      //     '$currencySymbol${netExpense.toStringAsFixed(2)}';

      final newExpenseString =
          '$netExpenseCurrencySymbol${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              Constants.appLogo,
              height: 150,
              width: 100,
            ),
          ),
          Text(
            'Net Expense: $newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return buildTransaction(context, isDarkModeOn, transaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(
    BuildContext context,
    bool isDarkModeOn,
    Transaction transaction,
  ) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(transaction.createdDate);
    final amount = transaction.amountCurrencySymbol +
        transaction.amount.toStringAsFixed(2);
    // final amount = transaction.amount.toStringAsFixed(2);

    return Card(
      color: isDarkModeOn ? Colors.black : Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          transaction.name,
          maxLines: 2,
          style: TextStyle(
              color: isDarkModeOn ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        subtitle: Text(date,
            style: TextStyle(
              color: isDarkModeOn ? Colors.white : Colors.black,
            )),
        trailing: Text(
          amount,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, isDarkModeOn, transaction),
        ],
      ),
    );
  }

  Widget buildButtons(
          BuildContext context, bool isDarkModeOn, Transaction transaction) =>
      Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit',
                  style: TextStyle(
                      color: isDarkModeOn
                          ? Colors.white
                          : Theme.of(context).primaryColor)),
              icon: Icon(Icons.edit,
                  color: isDarkModeOn
                      ? Colors.white
                      : Theme.of(context).primaryColor),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TransactionDialog(
                    transaction: transaction,
                    onClickedDone:
                        (name, amount, amountCurrencySymbol, isExpense) =>
                            editTransaction(transaction, name, amount,
                                amountCurrencySymbol, isExpense),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete',
                  style: TextStyle(
                      color: isDarkModeOn
                          ? Colors.white
                          : Theme.of(context).primaryColor)),
              icon: Icon(Icons.delete,
                  color: isDarkModeOn
                      ? Colors.white
                      : Theme.of(context).primaryColor),
              onPressed: () => deleteTransaction(transaction),
            ),
          )
        ],
      );

  Future addTransaction(String name, double amount, String amountCurrencySymbol,
      bool isExpense) async {
    final transaction = Transaction()
      ..name = name
      ..createdDate = DateTime.now()
      ..amount = amount
      ..amountCurrencySymbol = amountCurrencySymbol
      ..isExpense = isExpense;

    final box = Boxes.getTransactions();
    box.add(transaction);
    //box.put('mykey', transaction);

    // final mybox  Boxes.getTransactions();
    // final myTransaction  mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editTransaction(
    Transaction transaction,
    String name,
    double amount,
    String amountCurrencySymbol,
    bool isExpense,
  ) {
    transaction.name = name;
    transaction.amount = amount;
    transaction.amountCurrencySymbol = amountCurrencySymbol;
    transaction.isExpense = isExpense;

    // final box  Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    transaction.save();
  }

  void deleteTransaction(Transaction transaction) {
    // final box  Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() > transactions.remove(transaction));
  }
}
