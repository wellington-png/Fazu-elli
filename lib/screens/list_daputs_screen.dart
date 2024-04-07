import 'package:flutter/material.dart';
import 'package:deputados/widgets/list_widget.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/stores/deputado_store.dart';
import 'package:provider/provider.dart';

class ListDeputados extends StatefulWidget {
  const ListDeputados({Key? key}) : super(key: key);

  @override
  State<ListDeputados> createState() => _ListDeputadosState();
}

class _ListDeputadosState extends State<ListDeputados>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, List<String>> inputMap = {
    'Nome': ['Digite o nome do deputado', 'ex: João da Silva'],
    'Partido': ['Digite o partido do deputado', 'ex: PT'],
    'Estado': ['Digite o estado do deputado', 'ex: SP'],
  };

  final List<String> list = <String>['Nome', 'Partido', 'Estado'];
  String hintText = '';
  String labelText = '';

  void updateTextFieldContent(String dropdownValue) {
    setState(() {
      hintText = inputMap[dropdownValue]![1];
      labelText = inputMap[dropdownValue]![0];
    });
  }

  void searchDeputados(
      DeputadoStore deputadoStore, String dropdownValue, String? searchTerm) {
    switch (dropdownValue) {
      case 'Nome':
        deputadoStore.getDeputadosByParams(nome: searchTerm);
        break;
      case 'Partido':
        deputadoStore.getDeputadosByParams(partido: searchTerm);
        break;
      case 'Estado':
        deputadoStore.getDeputadosByParams(estado: searchTerm);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deputadoStore = Provider.of<DeputadoStore>(context);
    final List<Deputados> listaDeputados = deputadoStore.deputados;
    String dropdownValue = list.first;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: hintText,
                        labelText: labelText,
                        border: const OutlineInputBorder(),
                      ),
                      controller: textController,
                      onChanged: (value) =>
                          updateTextFieldContent(dropdownValue),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownMenu<String>(
                    initialSelection: list.first,
                    onSelected: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                      updateTextFieldContent(dropdownValue);
                      searchDeputados(
                          deputadoStore, dropdownValue, textController.text);
                    },
                    dropdownMenuEntries:
                        list.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10),
              listaDeputados.isNotEmpty
                  ? Flexible(
                      child: ListDepsWidget(
                        listaDeputados: listaDeputados,
                      ),
                    )
                  : FutureBuilder(
                      future: deputadoStore.getDeputados(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                'Erro ao carregar deputados: ${snapshot.error}'),
                          );
                        } else {
                          return const Center(
                            child: Text('Nenhum deputado encontrado'),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
  
}
