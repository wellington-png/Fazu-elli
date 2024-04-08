import 'package:flutter/material.dart';
import 'package:deputados/domain/models/deputado.dart';

class ProfileDateWidget extends StatelessWidget {
  final Deputado deputado;

  const ProfileDateWidget({Key? key, required this.deputado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Apelido:', deputado.nickname ?? 'Não disponível'),
            _buildInfoRow('Nome Civil:', deputado.civilName ?? 'Não disponível'),
            _buildInfoRow('Situação:', deputado.situation ?? 'Não disponível'),
            _buildInfoRow('Condição Eleitoral:', deputado.condition ?? 'Não disponível'),
            _buildInfoRow('CPF:', deputado.cpf ?? 'Não disponível'),
            _buildInfoRow('Sexo:', deputado.sex ?? 'Não disponível'),
            _buildInfoRow('Data de Nascimento:', deputado.birthDate ?? 'Não disponível'),
            _buildInfoRow('Cidade de Nascimento:', deputado.birthCity ?? 'Não disponível'),
            _buildInfoRow('Escolaridade:', deputado.education ?? 'Não disponível'),
            _buildInfoRow(
              'Gabinete:',
              deputado.office != null
                  ? 'Nome ${deputado.office!['nome']}, Prédio ${deputado.office!['predio']}, Sala ${deputado.office!['sala']}, Telefone ${deputado.office!['telefone']}, Email ${deputado.office!['email']}'
                  : 'Gabinete não disponível',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
