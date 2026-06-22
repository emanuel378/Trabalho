import 'dart:math' as math;
import 'package:flutter/material.dart';

class Quest01ExplicacaoPage extends StatelessWidget {
  const Quest01ExplicacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0520),
      body: Stack(
        children: [
          const _FundoEspacial(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Título "O que é verbo?"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'O que é ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'verbo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF00E5FF),
                          ),
                        ),
                        TextSpan(
                          text: '?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Card 1: definição
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _CardExplicacao(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white,
                          height: 1.6,
                        ),
                        children: [
                          TextSpan(text: 'Um '),
                          TextSpan(
                            text: 'verbo',
                            style: TextStyle(color: Color(0xFF00E5FF)),
                          ),
                          TextSpan(text: ' é uma palavra\nque usamos para mostrar\numa '),
                          TextSpan(
                            text: 'ação',
                            style: TextStyle(color: Color(0xFF00E5FF)),
                          ),
                          TextSpan(text: ', um '),
                          TextSpan(
                            text: 'estado',
                            style: TextStyle(color: Color(0xFF00E5FF)),
                          ),
                          TextSpan(text: ' ou\num '),
                          TextSpan(
                            text: 'acontecimento',
                            style: TextStyle(color: Color(0xFF00E5FF)),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Card 2: exemplo com mascote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _CardExplicacao(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Mascote
                        Image.asset(
                          'lib/assets/images/orionAcenando.png',
                          width: 64,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.smart_toy_outlined,
                            color: Color(0xFF00E5FF),
                            size: 48,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Texto do exemplo
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.6,
                              ),
                              children: [
                                TextSpan(text: '"O sol nasce às 6h"\nO verbo é "'),
                                TextSpan(
                                  text: 'nasce',
                                  style: TextStyle(color: Color(0xFF00E5FF)),
                                ),
                                TextSpan(text: '", indica\num acontecimento.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Botão Continuar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00E5FF), Color(0xFF1A8DE5)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/mapa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Botão Voltar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white30, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// CARD DE EXPLICAÇÃO
// ══════════════════════════════════════════
class _CardExplicacao extends StatelessWidget {
  final Widget child;
  const _CardExplicacao({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
      child: child,
    );
  }
}

// ══════════════════════════════════════════
// FUNDO ESPACIAL
// ══════════════════════════════════════════
class _FundoEspacial extends StatelessWidget {
  const _FundoEspacial();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: _EstrelasPainter(),
        ),
        Positioned(
          top: -60, right: -60,
          child: Container(
            width: 220, height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.purple.withOpacity(0.35), blurRadius: 160),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100, left: -60,
          child: Container(
            width: 180, height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.25), blurRadius: 140),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EstrelasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(77);
    final paint = Paint();
    for (int i = 0; i < 100; i++) {
      paint.color = Colors.white.withOpacity(rng.nextDouble() * 0.5 + 0.1);
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
        rng.nextDouble() * 1.5 + 0.3,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EstrelasPainter old) => false;
}