import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

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
          onPressed: () => _onPressed(context: context),
        )
      ],
    );
  }

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: localeObj,
    );
    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: _selected ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );
    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }
}
