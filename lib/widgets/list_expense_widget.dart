import 'package:deputados/domain/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListExpenseWidget extends StatelessWidget {
  final List<Expense> expenses;
  const ListExpenseWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    showViewExpenseDialog(Expense expense) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(expense.expenseType),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tipo de despesa: ${expense.expenseType}'),
                  Text(
                      'Valor: ${NumberFormat.currency(locale: 'pt_BR').format(expense.documentValue)}'),
                  Text('Data: ${expense.documentDate}'),
                  Text('Número do documento: ${expense.documentNumber}'),
                  Text(
                      'Número do ressarcimento: ${expense.reimbursementNumber}'),
                  Text('Parcela: ${expense.installment}'),
                  Text('Tipo de documento: ${expense.documentType}'),
                  Text(
                      'Valor da glosa: ${NumberFormat.currency(locale: 'pt_BR').format(expense.glossValue)}'),
                  Text(
                      'Valor líquido: ${NumberFormat.currency(locale: 'pt_BR').format(expense.netValue)}'),
                ]),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        },
      );
    }

    return ListView.builder(
      itemCount: expenses.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(expenses[index].expenseType),
          subtitle: Text(expenses[index].netValue.toString()),
          trailing: Text(expenses[index].documentDate.toString()),
          onTap: () {
            showViewExpenseDialog(expenses[index]);
          },
        ),
      ),
    );
  }
}
