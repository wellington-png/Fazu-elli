import 'package:flutter/material.dart';
import 'package:deputados/widgets/list_widget.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/stores/deputado_store.dart';
import 'package:provider/provider.dart';

class DropdownMenu<T> extends StatefulWidget {
  final T? initialSelection;
  final List<T> items;
  final void Function(T?) onSelected;

  const DropdownMenu({
    Key? key,
    required this.initialSelection,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<DropdownMenu<T>> {
  late T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: _selectedItem,
      onChanged: (newValue) {
        setState(() {
          _selectedItem = newValue;
        });
        widget.onSelected(newValue);
      },
      items: widget.items.map<DropdownMenuItem<T>>((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
    );
  }
}

class ListDeputados extends StatefulWidget {
  const ListDeputados({Key? key}) : super(key: key);

  @override
  State<ListDeputados> createState() => _ListDeputadosState();
}

class _ListDeputadosState extends State<ListDeputados>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController textController;
  String dropdownValue = 'Nome'; // Inicializar dropdownValue com 'Nome'

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
  String hintText = 'ex: João da Silva';
  String labelText = 'Digite o nome do deputado';

  void updateTextFieldContent(String dropdownValue) {
    setState(() {
      hintText = inputMap[dropdownValue]![1];
      labelText = inputMap[dropdownValue]![0];
    });
  }

  void searchDeputados(
      DeputadoStore deputadoStore, String dropdownValue, String? searchTerm) {
    if (searchTerm != null && searchTerm.isNotEmpty) {
      deputadoStore.getDeputadosByParams(
        nome: dropdownValue == 'Nome' ? searchTerm : null,
        partido: dropdownValue == 'Partido' ? searchTerm : null,
        estado: dropdownValue == 'Estado' ? searchTerm : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deputadoStore = Provider.of<DeputadoStore>(context);
    final List<Deputados> listaDeputados = deputadoStore.deputados;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        title: const Text('Deputados'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: hintText,
                          labelText: labelText,
                          border: const OutlineInputBorder(),
                        ),
                        controller: textController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchDeputados(
                          deputadoStore, dropdownValue, textController.text);
                    },
                  ),
                  const SizedBox(width: 10),
                  DropdownMenu<String>(
                    initialSelection: list.first,
                    onSelected: (String? value) {
                      if (value != null) {
                        setState(() {
                          dropdownValue = value; // Atualizar o dropdownValue
                          updateTextFieldContent(dropdownValue);
                        });
                      }
                    },
                    items: list,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10),
              deputadoStore.errorMessage.isNotEmpty
                  ? Text(deputadoStore.errorMessage)
                  : const SizedBox(),
              deputadoStore.isLoading // Verifica se está carregando
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Exibe o indicador de progresso
                  : listaDeputados.isNotEmpty
                      ? Flexible(
                          child: ListDepsWidget(
                            listaDeputados: listaDeputados,
                          ),
                        )
                      : const Center(
                          child: Text('Nenhum deputado encontrado'),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
