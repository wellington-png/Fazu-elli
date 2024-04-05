import 'package:flutter/material.dart';

import '../domain/models/deputados.dart';
import 'package:deputados/screens/details_daputs_screen.dart';

class ListDepsWidget extends StatelessWidget {
  final List<Deputados> listaDeputados;

  const ListDepsWidget({super.key, required this.listaDeputados});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 5,
                  blurStyle: BlurStyle.outer,
                ),
              ]),
          clipBehavior: Clip.hardEdge,
          height: 130,
          child: Row(
            children: [
              Image.network(
                listaDeputados[index].urlFoto,
                fit: BoxFit.cover,
                width: 110,
                height: 130,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    listaDeputados[index].nome,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeputadoPage(),
                      ),
                    );
                  },
                  subtitle: Row(
                    children: [
                      Text(
                        listaDeputados[index].siglaPartido,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: listaDeputados.length,
    );
  }
}
