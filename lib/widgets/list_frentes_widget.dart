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
    await frentesStore.getFrenteById(frente.id);
    frente = frentesStore.frente!;
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
    required this.onMemberClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    frente.titulo,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  _buildFrenteInfo(),
                  _buildCoordenadorInfo(),
                  const SizedBox(height: 20),
                  _buildMembersList(context),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildCloseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFrenteInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informações da Frente'),
        _buildInfoItem('ID', frente.id.toString()),
        _buildInfoItem('Telefone', frente.telefone ?? '-'),
        _buildInfoItem('E-mail', frente.email ?? '-'),
        _buildInfoItem('URL do Website', frente.urlWebsite ?? '-'),
        _buildInfoItem('URL do Documento', frente.urlDocumento ?? '-'),
      ],
    );
  }

  Widget _buildCoordenadorInfo() {
    return frente.coordenador != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildSectionTitle('Coordenador'),
              _buildInfoItem('Nome', frente.coordenador!['nome'] ?? '-'),
              _buildInfoItem(
                  'Partido', frente.coordenador!['siglaPartido'] ?? '-'),
              _buildInfoItem('UF', frente.coordenador!['siglaUf'] ?? '-'),
              _buildInfoItem('E-mail', frente.coordenador!['email'] ?? '-'),
              if (frente.coordenador!['urlFoto'] != null)
                _buildAvatar(frente.coordenador!['urlFoto']!),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
    );
  }

  Widget _buildMembersList(BuildContext context) {
    return membros.isEmpty
        ? const Text('Nenhum membro encontrado')
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Lista de Membros'),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
            ],
          );
  }

  Widget _buildCloseButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Fechar'),
    );
  }
}
