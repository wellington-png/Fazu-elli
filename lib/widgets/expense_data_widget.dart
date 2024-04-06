import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseDataWidget extends StatefulWidget {
  const ExpenseDataWidget({super.key});

  @override
  State<ExpenseDataWidget> createState() => _ExpenseDataWidgetState();
}

class _ExpenseDataWidgetState extends State<ExpenseDataWidget> {
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selected == null)
          const Text('No month year selected.')
        else
          Text(DateFormat().add_yM().format(_selected!)),
        TextButton(
          child: const Text('Selecionar mês e ano'),
          onPressed: () => null,
        )
      ],
    );
  }
}
