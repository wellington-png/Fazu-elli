import 'package:deputados/domain/models/membro.dart';
import 'package:deputados/widgets/list_frentes_widget.dart';
import 'package:flutter/material.dart';
import 'package:deputados/domain/models/frente.dart';
import 'package:deputados/domain/stores/frentes_store.dart';
import 'package:provider/provider.dart';

class FrentesScreen extends StatefulWidget {
  const FrentesScreen({super.key});

  @override
  State<FrentesScreen> createState() => _FrentesScreenState();
}

class _FrentesScreenState extends State<FrentesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _loadedData = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedData) {
      _loadFrentesData();
      _loadedData = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadFrentesData() async {
    final frentesStore = Provider.of<FrentesStore>(context, listen: false);
    await frentesStore.getFrentes();
  }

  bool _isOpened = false;

  void toogleDialogFrente() {
    setState(() {
      _isOpened = !_isOpened;
    });
  }

  void onPressedFrente(Frente frente) {
    final frentesStore = Provider.of<FrentesStore>(context, listen: false);
    frentesStore.getFrenteById(frente.id);
    // frentesStore.getMembrosByFrenteId(frente.id);
    Frente frenteDetail = frentesStore.frente!;
    showViewFrentesDialog(frenteDetail);
  }

  @override
  Widget build(BuildContext context) {
    final frentesStore = Provider.of<FrentesStore>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (frentesStore.errorMessage.isNotEmpty ||
                  frentesStore.isLoading)
                const SizedBox(height: 10),
              frentesStore.errorMessage.isNotEmpty
                  ? Text(frentesStore.errorMessage)
                  : const SizedBox(),
              if (frentesStore.isLoading)
                Center(child: const CircularProgressIndicator())
              else
                Flexible(
                  child: ListFrentesWidget(
                    frentes: frentesStore.frentes,
                    onPressed: onPressedFrente,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  showViewFrentesDialog(Frente frente) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(frente.titulo),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(frente.email!),
            ],
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
      },
    );
  }
}
