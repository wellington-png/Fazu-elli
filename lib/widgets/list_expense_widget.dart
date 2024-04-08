import 'package:deputados/domain/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListExpenseWidget extends StatelessWidget {
  final List<Expense> expenses;
  const ListExpenseWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    Widget buildDetailRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120.0, // Largura fixa para o rótulo
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(value),
            ),
          ],
        ),
      );
    }

    showViewExpenseDialog(Expense expense) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Detalhes da Despesa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  buildDetailRow('Tipo de despesa:', expense.expenseType!),
                  buildDetailRow(
                    'Valor:',
                    NumberFormat.currency(locale: 'pt_BR')
                        .format(expense.documentValue),
                  ),
                  buildDetailRow('Data:', expense.documentDate!),
                  buildDetailRow(
                      'Número do documento:', expense.documentNumber!),
                  buildDetailRow(
                      'Número do ressarcimento:', expense.reimbursementNumber!),
                  buildDetailRow('Parcela:', expense.installment.toString()),
                  buildDetailRow('Tipo de documento:', expense.documentType!),
                  buildDetailRow(
                    'Valor da glosa:',
                    NumberFormat.currency(locale: 'pt_BR')
                        .format(expense.glossValue),
                  ),
                  buildDetailRow(
                    'Valor líquido:',
                    NumberFormat.currency(locale: 'pt_BR')
                        .format(expense.netValue),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Altere a cor conforme necessário
                  ),
                ),
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
          title: Text(expenses[index].expenseType!),
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
