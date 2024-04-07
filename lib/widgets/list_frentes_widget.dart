import 'package:deputados/domain/models/frente.dart';
import 'package:deputados/domain/models/membro.dart';
import 'package:deputados/domain/stores/frentes_store.dart';
import 'package:deputados/utils/trucate_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFrentesWidget extends StatelessWidget {
  final List<Frente> frentes;
  final Function(int) onMemberClick;

  const ListFrentesWidget(
      {Key? key, required this.frentes, required this.onMemberClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: frentes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          FrenteCard(frente: frentes[index], onMemberClick: onMemberClick),
    );
  }
}

class FrenteCard extends StatelessWidget {
  final Frente frente;
  final Function(int) onMemberClick;

  const FrenteCard(
      {Key? key, required this.frente, required this.onMemberClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 120,
        child: Center(
          child: ListTile(
            title: Text(truncateText(frente.titulo, 75)),
            leading: const CircleAvatar(
              child: Icon(Icons.monetization_on_outlined),
            ),
            onTap: () async {
              await _showMembrosDialog(context, frente);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showMembrosDialog(BuildContext context, Frente frente) async {
    final frentesStore = Provider.of<FrentesStore>(context, listen: false);
    await frentesStore.getMembrosByFrenteId(frente.id);
    List<Membro> membros = frentesStore.membros;

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return MembrosDialog(
          frente: frente,
          membros: membros,
          onMemberClick: onMemberClick,
        );
      },
    );
  }
}

class MembrosDialog extends StatelessWidget {
  final Frente frente;
  final List<Membro> membros;
  final Function(int) onMemberClick;

  const MembrosDialog({
    Key? key,
    required this.frente,
    required this.membros,
    required this.onMemberClick, // Adicione este parâmetro ao construtor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        frente.titulo,
        style: const TextStyle(fontSize: 16),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 600, // Defina o tamanho conforme necessário
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (membros.isEmpty) const Text('Nenhum membro encontrado'),
            if (membros.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: membros.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(membros[index].nome!),
                    subtitle: Text(membros[index].siglaPartido!),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(membros[index].urlFoto!),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      onMemberClick(membros[index].id);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
