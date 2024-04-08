import 'package:deputados/widgets/list_frentes_widget.dart';
import 'package:flutter/material.dart';
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
  int _page = 1;

  int get page => _page;
  bool get isPagination => _page > 1;
  void nextPage() {
    setState(() {
      _page++;
    });
  }

  void previousPage() {
    if (_page == 1) return;
    setState(() {
      _page--;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final frentesStore = Provider.of<FrentesStore>(context);
    void navigateToDeputadoPage(int index) {
      Navigator.pushNamed(
        context,
        '/deputadoDetalhes',
        arguments: index,
      );
    }

    void onClickNextPage() {
      setState(() {
        nextPage();
      });
      frentesStore.getFrentes(pagina: page);
    }

    void onClickPreviousPage() {
      if (isPagination == false) return;
      setState(() {
        previousPage();
      });
      frentesStore.getFrentes(pagina: page);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Frentes Parlamentares'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (frentesStore.errorMessage.isNotEmpty || frentesStore.isLoading)
              const SizedBox(height: 10),
            frentesStore.errorMessage.isNotEmpty
                ? Text(frentesStore.errorMessage)
                : const SizedBox(),
            if (frentesStore.isLoading && frentesStore.frentes.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              Flexible(
                child: ListFrentesWidget(
                  frentes: frentesStore.frentes,
                  onMemberClick: (index) {
                    navigateToDeputadoPage(index);
                  },
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: isPagination ? onClickPreviousPage : null,
                    icon: const Icon(Icons.arrow_back)),
                Text('$page'),
                IconButton(
                    onPressed: frentesStore.frentes.isNotEmpty
                        ? onClickNextPage
                        : null,
                    icon: const Icon(Icons.arrow_forward)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
