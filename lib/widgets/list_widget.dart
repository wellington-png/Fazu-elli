import 'package:flutter/material.dart';
import '../domain/models/deputados.dart';

class ListDepsWidget extends StatelessWidget {
  final List<Deputados> listaDeputados;

  const ListDepsWidget({Key? key, required this.listaDeputados})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToDeputadoPage(int index) {
      Navigator.pushNamed(
        context,
        '/deputadoDetalhes',
        arguments: index,
      );
    }

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
            ],
          ),
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
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () {
                    navigateToDeputadoPage(listaDeputados[index].id);
                  },
                  subtitle: Row(
                    children: [
                      Text(
                        listaDeputados[index].siglaPartido,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        listaDeputados[index].siglaUf,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
