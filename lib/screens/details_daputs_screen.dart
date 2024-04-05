import 'package:flutter/material.dart';
import 'package:deputados/widgets/expansive_widget.dart';
import 'package:deputados/widgets/profile_data_widget.dart';
import 'package:deputados/widgets/expense_data_widget.dart';

class DeputadoPage extends StatefulWidget {
  const DeputadoPage({super.key});

  @override
  State<DeputadoPage> createState() => _DeputadoPageState();
}

class _DeputadoPageState extends State<DeputadoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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

  bool isVisableProfile = true;

  void onToggleProfile() {
    setState(() {
      isVisableProfile = !isVisableProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 350,
                // color: Theme.of(context).colorScheme.primary,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.camara.leg.br/internet/deputado/bandep/204379.jpg'),
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
                              Navigator.pop(context);
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
                )),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Amaral Silva',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text('PSOL')
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      ExpansiveWidget(
                        title: 'Perfil',
                        child: ProfileDateWidget(),
                      ),
                      ExpansiveWidget(
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
      )),
    );
  }
}
