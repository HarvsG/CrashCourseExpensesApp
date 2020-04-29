import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';
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
                  return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: FittedBox(
                                  child:
                                      Text('£${transactions[index].amount}'))),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(DateFormat.yMMMd()
                            .format(transactions[index].date)),
                        trailing: MediaQuery.of(context).size.width > 400
                            ? FlatButton.icon(
                                onPressed: () =>
                                    deleteHandler(transactions[index].id),
                                icon: const Icon(Icons.delete),
                                textColor: Theme.of(context).errorColor,
                                label: const Text('Delete'))
                            : IconButton(
                                icon: const Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () =>
                                    deleteHandler(transactions[index].id),
                              ),
                      ));
                },
                itemCount: transactions.length,
              ),
      );
    });
  }
}
