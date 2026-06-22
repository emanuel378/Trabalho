import 'dart:math' as math;
import 'package:flutter/material.dart';

class Quest01ExplicacaoPage extends StatelessWidget {
  const Quest01ExplicacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B1E),
      body: Stack(
        children: [
          const _FundoEspacial(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ── Título ──────────────────────────────────────
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
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'verbo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF00E5FF),
                          ),
                        ),
                        TextSpan(
                          text: '?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Mascote hero com glow ────────────────────────
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow atrás do mascote
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withOpacity(0.25),
                            blurRadius: 80,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'lib/assets/images/orionAcenando.png',
                      width: 140,
                      height: 140,
                      errorBuilder: (_, __, ___) => Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.04),
                          border: Border.all(
                            color: const Color(0xFF00E5FF).withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.smart_toy_outlined,
                          color: Color(0xFF00E5FF),
                          size: 64,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Card 1: definição com borda gradiente ────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _GradientBorderCard(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.7,
                        ),
                        children: [
                          TextSpan(text: 'Um '),
                          TextSpan(
                            text: 'verbo',
                            style: TextStyle(
                              color: Color(0xFF00E5FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ' é uma palavra que usamos\npara mostrar uma '),
                          TextSpan(
                            text: 'ação',
                            style: TextStyle(
                              color: Color(0xFF00E5FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ', um '),
                          TextSpan(
                            text: 'estado',
                            style: TextStyle(
                              color: Color(0xFF00E5FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: '\nou um '),
                          TextSpan(
                            text: 'acontecimento',
                            style: TextStyle(
                              color: Color(0xFF00E5FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Card 2: exemplo ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _CardExemplo(
                    child: Row(
                      children: [
                        // Ícone de citação decorativo
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E5FF).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.format_quote_rounded,
                            color: Color(0xFF00E5FF),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.6,
                              ),
                              children: [
                                TextSpan(
                                  text: '"O sol nasce às 6h"\n',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white70,
                                  ),
                                ),
                                TextSpan(text: 'O verbo é "'),
                                TextSpan(
                                  text: 'nasce',
                                  style: TextStyle(
                                    color: Color(0xFF00E5FF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: '" — indica um acontecimento.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // ── Botão Continuar ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00E5FF), Color(0xFF1A8DE5)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/quest01-atv');
                        },
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
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Botão Voltar ─────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white24, width: 1.5),
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

                const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// CARD COM BORDA GRADIENTE (padrão Astro Lume)
// ══════════════════════════════════════════
class _GradientBorderCard extends StatelessWidget {
  final Widget child;
  const _GradientBorderCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF00E5FF), Color(0xFF1A8DE5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1230),
          borderRadius: BorderRadius.circular(19),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        child: child,
      ),
    );
  }
}

// ══════════════════════════════════════════
// CARD DE EXEMPLO (fundo sutil, sem borda gradiente)
// ══════════════════════════════════════════
class _CardExemplo extends StatelessWidget {
  final Widget child;
  const _CardExemplo({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00E5FF).withOpacity(0.2),
          width: 1,
        ),
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
          top: -80,
          right: -80,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 180,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: -80,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1A8DE5).withOpacity(0.2),
                  blurRadius: 160,
                ),
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
    final rng = math.Random(42);
    final paint = Paint();
    for (int i = 0; i < 120; i++) {
      paint.color = Colors.white.withOpacity(rng.nextDouble() * 0.6 + 0.1);
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
        rng.nextDouble() * 1.8 + 0.3,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EstrelasPainter old) => false;
}