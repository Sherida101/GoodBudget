import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:good_budget/models/transaction.dart';

class TransactionDialog extends StatefulWidget {
  final Transaction? transaction;
  final Function(String name, double amount, String amountCurrencySymbol,
      bool isExpense) onClickedDone;

  const TransactionDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  bool isExpense = true;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      nameController.text = transaction.name;
      amountController.text = transaction.amount.toString();
      currencyController.text = transaction.amountCurrencySymbol;
      isExpense = transaction.isExpense;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    currencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? chooseCurrencyColorButton =
        Theme.of(context).primaryColor; //Colors.teal;
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

    return AlertDialog(
      scrollable: true,
      title: Center(child: Text(title)),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildName(),
              const SizedBox(height: 8),
              buildCurrency(chooseCurrencyColorButton),
              const SizedBox(height: 8),
              buildAmount(),
              const SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, chooseCurrencyColorButton,
            isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildCurrency(chooseCurrencyColorButton) =>
      currencyController.text.isEmpty
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: chooseCurrencyColorButton,
                  onPrimary: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              onPressed: () {
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  onSelect: (currency) {
                    debugPrint(
                        'Select currency: ${currency.name}\t${currency.symbol}');
                    setState(() {
                      currencyController =
                          TextEditingController(text: currency.symbol);
                    });
                  },
                );
              },
              child: const Text('Choose currency'))
          : TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () => showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          onSelect: (currency) {
                            debugPrint(
                                'Select currency: ${currency.name}\t${currency.symbol}');
                            setState(() {
                              currencyController =
                                  TextEditingController(text: currency.symbol);
                            });
                          },
                        ),
                    child: const Icon(Icons.change_circle)),
                border: const OutlineInputBorder(),
                hintText: currencyController.text,
              ),
              validator: (currency) =>
                  currency == null ? 'Choose a currency!' : null,
              controller: currencyController,
            );

  Widget buildAmount() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Amount',
        ),
        keyboardType: TextInputType.number,
        validator: (amount) => amount != null && double.tryParse(amount) == null
            ? 'Enter a valid number'
            : null,
        controller: amountController,
      );

  Widget buildRadioButtons() => Column(
        children: [
          const Text(
            'Transaction Type',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          RadioListTile<bool>(
            title: const Text('Expense'),
            value: true,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
          ),
          RadioListTile<bool>(
            title: const Text('Income'),
            value: false,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
          ),
        ],
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(
              color: Colors.white,
            )),
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, chooseCurrencyColorButton,
      {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: const TextStyle(
            color: Colors.white,
          )),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (currencyController.text.isEmpty) {
          setState(() {
            chooseCurrencyColorButton = Colors.red[900];
          });
        }

        if (isValid && currencyController.text.isNotEmpty) {
          final name = nameController.text;
          final amount = double.tryParse(amountController.text) ?? 0.0;
          final amountCurrencySymbol = currencyController.text;

          widget.onClickedDone(name, amount, amountCurrencySymbol, isExpense);

          setState(() {
            chooseCurrencyColorButton = Theme.of(context).primaryColor;
          });

          Navigator.of(context).pop();
        }
      },
    );
  }
}
