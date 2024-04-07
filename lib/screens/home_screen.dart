import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fazuélli',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
                Text('Saiba mais sobre os deputados federais.',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          )),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Deputados',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              const Text('Federais'),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/listDeputados');
                                  },
                                  child: const Text('Listar Deputados'))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/deputado.png'),
                                fit: BoxFit.fitHeight),
                          ),
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Comissões',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              const Text('Permanentes'),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/frentes');
                                  },
                                  child: const Text('Listar Frentes'))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/frentes.png'),
                                fit: BoxFit.fitHeight),
                          ),
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// const Text('Home Screen'),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/listDeputados');
//                     },
//                     child: const Text('Listar Deputados'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/frentes');
//                     },
//                     child: const Text('Listar Frentes'),
//                   ),
               