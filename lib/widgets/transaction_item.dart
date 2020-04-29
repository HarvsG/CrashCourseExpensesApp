import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteHandler;

  @override
  Widget build(BuildContext context) {
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
                        Text('£${transaction.amount}'))),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(DateFormat.yMMMd()
              .format(transaction.date)),
          trailing: MediaQuery.of(context).size.width > 400
              ? FlatButton.icon(
                  onPressed: () =>
                      deleteHandler(transaction.id),
                  icon: const Icon(Icons.delete),
                  textColor: Theme.of(context).errorColor,
                  label: const Text('Delete'))
              : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () =>
                      deleteHandler(transaction.id),
                ),
        ));
  }
}