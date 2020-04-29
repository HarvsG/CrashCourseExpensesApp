import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;

  const TransactionList({this.transactions, this.deleteHandler});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.1,
                    child: Text('Waiting for the first transaction',
                        style: Theme.of(context).textTheme.title),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
                    child: Image.asset('assets/images/giphy.gif',
                        fit: BoxFit.cover),
                    height: constraints.maxHeight * 0.6,
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionItem(transaction: transactions[index], deleteHandler: deleteHandler);
                },
                itemCount: transactions.length,
              ),
      );
    });
  }
}


