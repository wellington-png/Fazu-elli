import 'package:deputados/domain/models/frente.dart';
import 'package:deputados/utils/trucate_text.dart';
import 'package:flutter/material.dart';

class ListFrentesWidget extends StatelessWidget {
  final List<Frente> frentes;
  final void Function(Frente) onPressed;
  const ListFrentesWidget({super.key, required this.frentes, required this.onPressed});

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.builder(
      itemCount: frentes.length,
      shrinkWrap: true,
      
      itemBuilder: (context, index) => Card(
        child: SizedBox(
          height: 100,

          child: Center(
            child: ListTile(
              title: Text(truncateText(frentes[index].titulo, 75)),
              leading: const CircleAvatar(
                child: Icon(Icons.monetization_on_outlined),
              ),
              onTap: () => onPressed(frentes[index]),
            ),
          ),
        ),
      ),
    );

  

  }
}
