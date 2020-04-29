import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTranactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: 6-index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day) {
          totalSum += recentTransactions[i].amount;
        }
      }
      
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTranactionValues.fold(0.0, (sum, i) {
      return sum + i['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTranactionValues.map((data) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'],
                    spendingAmount: data['amount'],
                    spendingPctOfTotal: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
