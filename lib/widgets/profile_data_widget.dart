import 'package:flutter/material.dart';

class ProfileDateWidget extends StatelessWidget {
  const ProfileDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text(
              'Data de Nascimento:',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            )
          ],
        ),
        Row(
          children: [Text('30/04/1981', style: TextStyle(fontSize: 20))],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
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
              child: Text('São Paulo (SP)', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
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
                'Senado Federal Anexo 2 11º Pavimento ',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
