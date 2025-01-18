import 'package:flutter/material.dart';
import 'componentes/jogo_da_velha.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const String titulo = '‧₊˚Jogo da Velha `⎚⩊⎚´';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 136, 206, 247)),
        useMaterial3: true,
      ),
      home: const HomePage(title: titulo),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 27, 85, 133)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              flex: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(255, 115, 210, 245),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(221, 100, 165, 170),
                                blurRadius: 10,
                                offset: Offset(5, 5),
                              ),
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: JogoDaVelha(),
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'bot',
        child: const Icon(Icons.smart_toy),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
