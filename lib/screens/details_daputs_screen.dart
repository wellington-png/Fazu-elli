import 'package:deputados/constants/party_logo.dart';
import 'package:flutter/material.dart';
import 'package:deputados/widgets/expansive_widget.dart';
import 'package:deputados/widgets/profile_data_widget.dart';
import 'package:deputados/widgets/expense_data_widget.dart';
import 'package:deputados/domain/models/deputado.dart';
import 'package:deputados/domain/stores/expense_store.dart';
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
  bool _loadedData = false;

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
      _loadDeputadoData();
      _loadedData = true;
    }
  }

  Future<void> _loadDeputadoData() async {
    final deputadoStore = Provider.of<DeputadoStore>(context, listen: false);
    final expenseStore = Provider.of<ExpenseStore>(context, listen: false);
    final idDeputado = ModalRoute.of(context)!.settings.arguments as int;
    await deputadoStore.getDeputadoById(idDeputado);
    await expenseStore.getExpenses(id: idDeputado);
    await deputadoStore.getOcupacoesByDeputadoId(idDeputado);
    await deputadoStore.getHistoricoByDeputadoId(idDeputado);
  }

  @override
  Widget build(BuildContext context) {
    final deputadoStore = Provider.of<DeputadoStore>(context);
    final Deputado? deputado = deputadoStore.deputado;

    return SafeArea(
      child: Scaffold(
          body: !deputadoStore.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(deputado?.urlFoto ??
                                'https://via.placeholder.com/150'),
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
                                      Navigator.pushNamed(context, '/listDeputados');
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                              color: Colors.black, width: 2),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
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
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Image(
                                          image: NetworkImage(PartyLogo.getLogo(
                                              deputado?.siglaPartido ?? ''))),
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
                                ExpansiveWidget(
                                  title: 'Ocupações',
                                  child: Column(
                                    children: deputadoStore.ocupacoes
                                        .map((ocupacao) => Card(
                                              child: ListTile(
                                                  title: Text(ocupacao.titulo),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'Entidade: ${ocupacao.entidade ?? 'Não informado'}'),
                                                      Text(
                                                          'Ano de início: ${ocupacao.anoInicio ?? 'Não informado'}'),
                                                      Text(
                                                          'Ano de fim: ${ocupacao.anoFim ?? 'Não informado'}'),
                                                    ],
                                                  )),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                ExpansiveWidget(
                                  title: 'Histórico',
                                  child: Column(
                                    children: deputadoStore.historico.isNotEmpty
                                        ? deputadoStore.historico
                                            .map((historico) => Card(
                                                  child: ListTile(
                                                      title:
                                                          Text(historico.nome),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              'Nome Eleitoral: ${historico.nomeEleitoral}'),
                                                          Text(
                                                              'Sigla do Partido: ${historico.siglaPartido}'),
                                                          Text(
                                                              'Sigla do Estado: ${historico.siglaUf}'),
                                                          Text(
                                                              'Data e Hora: ${historico.dataHora}'),
                                                          Text(
                                                              'Situação: ${historico.situacao}'),
                                                          Text(
                                                              'Condição Eleitoral: ${historico.condicaoEleitoral}'),
                                                          Text(
                                                              'Descrição do Status: ${historico.descricaoStatus}'),
                                                        ],
                                                      )),
                                                ))
                                            .toList()
                                        : [
                                            const Text(
                                                'Nenhum histórico encontrado')
                                          ],
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
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
