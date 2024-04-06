import 'package:flutter/material.dart';
import 'package:deputados/widgets/expansive_widget.dart';
import 'package:deputados/widgets/profile_data_widget.dart';
import 'package:deputados/widgets/expense_data_widget.dart';
import 'package:deputados/domain/models/deputado.dart';
import 'package:deputados/domain/stores/deputado_store.dart';
import 'package:provider/provider.dart';

class DeputadoPage extends StatefulWidget {
  const DeputadoPage({Key? key}) : super(key: key);

  @override
  State<DeputadoPage> createState() => _DeputadoPageState();
}

class _DeputadoPageState extends State<DeputadoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _loadedData =
      false; // Flag para controlar se os dados já foram carregados

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isVisibleProfile = true;

  void onToggleProfile() {
    setState(() {
      isVisibleProfile = !isVisibleProfile;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedData) {
      // Verifica se os dados já foram carregados
      _loadDeputadoData();
      _loadedData = true; // Marca os dados como carregados
    }
  }

  Future<void> _loadDeputadoData() async {
    final deputadoStore = Provider.of<DeputadoStore>(context, listen: false);
    final idDeputado = ModalRoute.of(context)!.settings.arguments as int;
    await deputadoStore.getDeputadoById(idDeputado);
  }

  @override
  Widget build(BuildContext context) {
    final deputadoStore = Provider.of<DeputadoStore>(context);
    final Deputado? deputado = deputadoStore.deputado;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        deputado?.urlFoto ?? 'https://via.placeholder.com/150'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(
                                      color: Colors.black, width: 2),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            deputado?.nickname ?? 'Nome do Deputado',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              deputado?.siglaPartido ?? 'Partido',
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        ExpansiveWidget(
                          title: 'Perfil',
                          child: ProfileDateWidget(
                            deputado: deputado!,
                          ),
                        ),
                        const ExpansiveWidget(
                          title: 'Despesas',
                          child: ExpenseDataWidget(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
