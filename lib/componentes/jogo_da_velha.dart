import 'dart:math';

import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _tabuleiro = List.filled(9, '');
  String _jogador = 'X';
  String _mensagem = '';
  bool _contraMaquina = false;
  final Random _randomico = Random();
  bool _pensando = false;

  void _iniciarjogo() {
    setState(() {
      _tabuleiro = List.filled(9, '');
      _jogador = 'X';
      _mensagem = '';
    });
  }

  void _trocaJogador() {
    setState(() {
      _jogador = _jogador == 'X' ? '0' : 'X';
    });
  }

  void _mostreDiaLogoVencedor(String vencedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            vencedor == 'Empate'
                ? 'Empate! 𖦹ᯅ𖦹 '
                : 'O vencedor é $vencedor !!◝(ᵔᵕᵔ)◜',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 77, 158, 228),
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text(
                'ᯓReiniciar Jogo',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 78, 139, 196),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _iniciarjogo();
              },
            ),
          ],
        );
      },
    );
  }

  bool _verificaVendedor(String jogador) {
    const posicoesVencedores = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var posicoes in posicoesVencedores) {
      if (_tabuleiro[posicoes[0]] == jogador &&
          _tabuleiro[posicoes[1]] == jogador &&
          _tabuleiro[posicoes[2]] == jogador) {
        _mostreDiaLogoVencedor(jogador);
        return true;
      }
    }

    if (!_tabuleiro.contains('')) {
      _mostreDiaLogoVencedor('Empate');
      return true;
    }
    return false;
  }

  void _jogadaComputador() {
    setState(() {
      _pensando = true;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        int movimento;
        do {
          movimento = _randomico.nextInt(9);
        } while (_tabuleiro[movimento] != '');
        setState(() {
          _tabuleiro[movimento] = '0';
          if (!_verificaVendedor(_jogador)) {
            _trocaJogador();
          }
          _pensando = false;
        });
      },
    );
  }

  void _jogada(int index) {
    if (_tabuleiro[index] == '' && _mensagem == '') {
      setState(() {
        _tabuleiro[index] = _jogador;
        if (!_verificaVendedor(_jogador)) {
          _trocaJogador();
          if (_contraMaquina && _jogador == '0') {
            _jogadaComputador();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height * 0.5;
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: _contraMaquina,
                  onChanged: (value) {
                    setState(() {
                      _contraMaquina = value;
                      _iniciarjogo();
                    });
                  },
                ),
              ),
              Text(_contraMaquina ? 'Computador' : 'Humano',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 27, 85, 133),
                  )),
              const SizedBox(
                width: 30.0,
              ),
              if (_pensando)
                const SizedBox(
                  height: 15.0,
                  width: 15.0,
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: SizedBox(
            width: altura,
            height: altura,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _jogada(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        _tabuleiro[index],
                        style: TextStyle(
                          fontSize: 40.0,
                          color: _tabuleiro[index] == 'X'
                              ? const Color.fromARGB(255, 64, 121, 235)
                              : const Color.fromARGB(255, 48, 179, 215),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: _iniciarjogo,
            child: const Text('ᯓReiniciar Jogo'),
          ),
        ),
      ],
    );
  }
}
