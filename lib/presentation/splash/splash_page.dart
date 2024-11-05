import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medicament_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _showTextAnimation = false;

  @override
  void initState() {
    super.initState();

    // Controlador para a animação de Lottie
    _controller = AnimationController(vsync: this);

    // Iniciar a animação de texto após um pequeno atraso
    Future.delayed(const Duration(seconds: 1), () {
      // Atraso maior para iniciar a animação do texto
      setState(() {
        _showTextAnimation = true;
      });
    });

    // Navega para a próxima página após 5 segundos
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.selectedMedications);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Lottie.asset(
              'assets/animation.json', // Coloque sua animação Lottie aqui
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = const Duration(
                      seconds: 5) // Duração aumentada para 5 segundos
                  ..forward();
              },
            ),

            // Animated Text for app name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  "CompatMed Analyzer".split("").asMap().entries.map((entry) {
                int idx = entry.key;
                String letter = entry.value;
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 800 + idx * 300),
                  opacity: _showTextAnimation ? 1 : 0,
                  child: AnimatedPadding(
                    padding:
                        EdgeInsets.only(bottom: _showTextAnimation ? 0 : 20),
                    duration: Duration(milliseconds: 600 + idx * 300),
                    curve: Curves.easeOut,
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
