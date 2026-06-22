import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

// ══════════════════════════════════════════
// GALÁXIA TECHTRON (azul)
// ══════════════════════════════════════════
class GalaxiaTechPage extends StatelessWidget {
  const GalaxiaTechPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _GalaxiaDetalhe(
      nome: 'Techtron',
      imagemMascote: 'lib/assets/images/orionTectron.png',
      tituloDescricao: 'O Futuro nas\nSuas Mãos',
      descricao: 'Para quem sonha com tecnologia e IA, onde cada planeta simboliza uma habilidade-chave para o futuro.',
      corPrimaria: const Color(0xFF00E5FF),
      corSecundaria: const Color(0xFF3E8BFF),
      corBotao: const [Color(0xFF00E5FF), Color(0xFF2D7CFF)],
    );
  }
}

// ══════════════════════════════════════════
// GALÁXIA VITA (verde)
// ══════════════════════════════════════════
class GalaxiaVitaPage extends StatelessWidget {
  const GalaxiaVitaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _GalaxiaDetalhe(
      nome: 'Vita',
      imagemMascote: 'lib/assets/images/vita.png',
      tituloDescricao: 'Cuidando da\nVida',
      descricao: 'Saúde e bem-estar, com mundos que vão dos segredos do corpo humano aos avanços da biotecnologia.',
      corPrimaria: const Color(0xFF00E676),
      corSecundaria: const Color(0xFF1B9E3E),
      corBotao: const [Color(0xFF00C853), Color(0xFF1B7A2F)],
    );
  }
}

// ══════════════════════════════════════════
// GALÁXIA COMMERCIUM (roxo)
// ══════════════════════════════════════════
class GalaxiaCommerciumPage extends StatelessWidget {
  const GalaxiaCommerciumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _GalaxiaDetalhe(
      nome: 'Commercium',
      imagemMascote: 'lib/assets/images/orionTectron.png',
      tituloDescricao: 'O Império dos\nNegócios',
      descricao: 'Mentes empreendedoras e inovadoras que desejam criar negócios, gerir recursos e desenvolver soluções para o mercado.',
      corPrimaria: const Color(0xFFCE93D8),
      corSecundaria: const Color(0xFF9C27B0),
      corBotao: const [Color(0xFFAB47BC), Color(0xFF6A1B9A)],
    );
  }
}

// ══════════════════════════════════════════
// WIDGET REUTILIZÁVEL
// ══════════════════════════════════════════
class _GalaxiaDetalhe extends StatelessWidget {
  final String nome;
  final String imagemMascote;
  final String tituloDescricao;
  final String descricao;
  final Color corPrimaria;
  final Color corSecundaria;
  final List<Color> corBotao;

  const _GalaxiaDetalhe({
    required this.nome,
    required this.imagemMascote,
    required this.tituloDescricao,
    required this.descricao,
    required this.corPrimaria,
    required this.corSecundaria,
    required this.corBotao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09051E),
      body: Stack(
        children: [
          _BackgroundGlow(cor: corPrimaria),
          const _StarField(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Botão voltar
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.08),
                          border: Border.all(color: corPrimaria.withOpacity(0.4)),
                        ),
                        child: Icon(Icons.arrow_back_ios_new, color: corPrimaria, size: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Galáxia',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [corPrimaria, corSecundaria],
                    ).createShader(bounds),
                    child: Text(
                      nome,
                      style: const TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontFamily: 'Gugi',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Card mascote
                  _GlassCard(
                    borderColor: corPrimaria,
                    child: Column(
                      children: [
                        Image.asset(
                          imagemMascote,
                          height: 200,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.smart_toy_outlined,
                            size: 120,
                            color: corPrimaria,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: corBotao),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: corPrimaria.withOpacity(0.5),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/mapa'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Escolher',
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
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Card descrição
                  _GlassCard(
                    borderColor: corPrimaria,
                    child: Column(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [corPrimaria, corSecundaria],
                          ).createShader(bounds),
                          child: Text(
                            tituloDescricao,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          descricao,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  const _GlassCard({required this.child, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: borderColor.withOpacity(0.3)),
            boxShadow: [BoxShadow(color: borderColor.withOpacity(0.1), blurRadius: 30)],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  final Color cor;
  const _BackgroundGlow({required this.cor});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(top: -80, right: -50, child: _glow(250, Colors.purple)),
      Positioned(bottom: 80, left: -60, child: _glow(220, cor)),
    ]);
  }

  Widget _glow(double size, Color color) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 180)],
    ),
  );
}

class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: MediaQuery.of(context).size,
    painter: _StarPainter(),
  );
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint();
    for (int i = 0; i < 150; i++) {
      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.5 + 0.1);
      canvas.drawCircle(
        Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        random.nextDouble() * 1.8 + 0.4,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}