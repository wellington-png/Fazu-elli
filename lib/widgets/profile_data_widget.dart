import 'package:deputados/domain/models/deputado.dart';
import 'package:flutter/material.dart';

class ProfileDateWidget extends StatelessWidget {
  final Deputado deputado;

  const ProfileDateWidget({super.key, required this.deputado});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Data de Nascimento:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            )
          ],
        ),
        Row(
          children: [
            Text(
              deputado.birthDate != null
                  ? deputado.birthDate!
                  : 'Data não disponível',
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          children: [
            Text(
              'Naturalidade:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                deputado.birthCity != null
                    ? '${deputado.birthCity} - ${deputado.birthUf}'
                    : 'Naturalidade não disponível',
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          children: [
            Text(
              'Gabinete:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                deputado.office != null
                    ? 'Nome ${deputado.office?['nome']}, Prédio ${deputado.office?['predio']}, Sala ${deputado.office?['sala']}, Telefone ${deputado.office?['telefone']}, Email s${deputado.office?['email']}'
                    : 'Gabinete não disponível',
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
