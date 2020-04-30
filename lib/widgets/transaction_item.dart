import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availibleColors = [Colors.red, Colors.black, Colors.blue, Colors.purple];
    _bgColor = availibleColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: _bgColor,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: FittedBox(
                    child:
                        Text('£${widget.transaction.amount}'))),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(DateFormat.yMMMd()
              .format(widget.transaction.date)),
          trailing: MediaQuery.of(context).size.width > 400
              ? FlatButton.icon(
                  onPressed: () =>
                      widget.deleteHandler(widget.transaction.id),
                  icon: const Icon(Icons.delete),
                  textColor: Theme.of(context).errorColor,
                  label: const Text('Delete'))
              : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () =>
                      widget.deleteHandler(widget.transaction.id),
                ),
        ));
  }
}