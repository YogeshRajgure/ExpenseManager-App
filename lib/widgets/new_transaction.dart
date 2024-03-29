import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'adaptive_TextButton.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  // String? titleInput;
  // String? amountInput;

  NewTransaction(this.addTx) {
    print('Constructor new transaction widget');
  }

  @override
  State<NewTransaction> createState() {
    print('createState newTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState() {
    print('constructor Newtransaction state');
  }

  @override
  void initState() {
    super.initState();
    print('init state');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('did update widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);

    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(_enteredTitle, _enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Theme.of(context).primaryColorLight,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   amountInput = val;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}'),
                    ),
                    Adaptive_TextButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: TextButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).textTheme.labelLarge?.color,
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
