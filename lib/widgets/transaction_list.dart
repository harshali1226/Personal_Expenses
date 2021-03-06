import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty ? 
      LayoutBuilder(
        builder: (ctx, constraints) {
          return  Column(
        children: <Widget> [
          Text('No Transactions added yet!',
          style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('assets/images/waiting.png',
            fit: BoxFit.cover,
            ),
          ),
        ]
      ); 
        }
      )
     
      : ListView.builder(
        itemBuilder: (ctx, index) {
           return Card(
             elevation: 6,
               margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
               child: ListTile(
               leading: CircleAvatar(
                 radius: 30,
                 child: Padding(
                    padding: EdgeInsets.all(10),
                    child: FittedBox(
                     child: Text('\$${transactions[index].amount}')
                     ),
                 ),
                 ),
                 title: Text(
                  transactions[index].title,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold
                  ),
                 ),
                 subtitle: Text(
                   DateFormat.yMMMd().format(transactions[index].date)
                 ),
                 trailing: MediaQuery.of(context).size.width > 460 
                 ? FlatButton.icon(
                   onPressed: () => deleteTx(transactions[index].id),
                   icon: Icon(Icons.delete),
                  label: Text('Delete', 
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  )
                 : IconButton(
                   icon: Icon(Icons.delete),
                   onPressed: () => deleteTx(transactions[index].id)
                   ),
             ),
           );
        },
        itemCount: transactions.length,
        )
    );
  }
}