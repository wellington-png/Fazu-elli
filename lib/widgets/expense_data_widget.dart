import 'package:deputados/domain/models/expense.dart';
import 'package:deputados/domain/stores/expense_store.dart';
import 'package:deputados/widgets/list_expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:deputados/constants/months.dart';
import 'package:deputados/constants/years.dart';
import 'package:provider/provider.dart';

class ExpenseDataWidget extends StatefulWidget {
  const ExpenseDataWidget({super.key});

  @override
  State<ExpenseDataWidget> createState() => _ExpenseDataWidgetState();
}

class _ExpenseDataWidgetState extends State<ExpenseDataWidget> {
  List<int>? _monthSelected;
  List<int>? _yearSelected;
  bool _loadedData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedData) {
      _loadExpenses();
      _loadedData = true;
    }
  }

  Future<void> _loadExpenses() async {
    final expenseStore = Provider.of<ExpenseStore>(context, listen: false);
    final idDeputado = ModalRoute.of(context)!.settings.arguments as int;
    await expenseStore.getExpenses(
        id: idDeputado, year: _yearSelected, month: _monthSelected);
  }

  final _itemsMoth = MonthData.months
      .map(
          (month) => MultiSelectItem<int>(month.keys.first, month.values.first))
      .toList();
  final _itemsYear = YearData.years
      .map((year) => MultiSelectItem<int>(year.keys.first, year.values.first))
      .toList();

  bool _isOpened = false;
  void toogleDialogExoense() {
    setState(() {
      _isOpened = !_isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    final expensesStore = Provider.of<ExpenseStore>(context);
    List<Expense> expenses = expensesStore.expenses;

    return Column(
      children: [
        MultiSelectDialogField(
          items: _itemsMoth,
          title: const Text('Selecione o mês e ano'),
          selectedColor: Colors.blue,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          buttonIcon: const Icon(Icons.arrow_drop_down),
          buttonText: const Text('Selecione o mês e ano'),
          onConfirm: (results) {
            setState(() {
              _monthSelected = results;
              _loadExpenses(); // Atualiza os dados ao confirmar a seleção do mês
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        MultiSelectDialogField(
          items: _itemsYear,
          title: const Text('Selecione o ano'),
          selectedColor: Colors.blue,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          buttonIcon: const Icon(Icons.arrow_drop_down),
          buttonText: const Text('Selecione o ano'),
          onConfirm: (results) {
            setState(() {
              _yearSelected = results;
              _loadExpenses(); // Atualiza os dados ao confirmar a seleção do ano
            });
          },
        ),
        Column(
          children: [
            Text('Total de despesas: ${expenses.length}'),
            Text(
                'Valor total: ${expenses.fold(0.0, (total, expense) => total + expense.netValue!).toStringAsFixed(2)}'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(height: 300, child: ListExpenseWidget(expenses: expenses)),
          ],
        ),
      ],
    );
  }

  showViewExpenseDialog(Expense expense) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(expense.supplierName!),
          content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Tipo de despesa: ${expense.expenseType}'),
                Text(
                    'Valor: ${NumberFormat.currency(locale: 'pt_BR').format(expense.documentValue)}'),
                Text('Data: ${expense.documentDate}'),
                Text('Número do documento: ${expense.documentNumber}'),
                Text('Número do ressarcimento: ${expense.reimbursementNumber}'),
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
}
