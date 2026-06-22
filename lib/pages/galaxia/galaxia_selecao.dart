import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class GalaxiaSelecaoPage extends StatefulWidget {
  const GalaxiaSelecaoPage({super.key});

  @override
  State<GalaxiaSelecaoPage> createState() => _GalaxiaSelecaoPageState();
}

class _GalaxiaSelecaoPageState extends State<GalaxiaSelecaoPage> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _paginaAtual = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _mostrarAviso());
  }

  void _mostrarAviso() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      builder: (_) => const _AvisoDialog(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<_GalaxiaData> _galaxias = const [
    _GalaxiaData(
      nome: 'Techtron',
      imagemMascote: 'lib/assets/images/orionTectron.png',
      tituloDescricao: 'O Futuro nas\nSuas Mãos',
      descricao: 'Para quem sonha com tecnologia e IA, onde cada planeta simboliza uma habilidade-chave para o futuro.',
      corPrimaria: Color(0xFF00E5FF),
      corSecundaria: Color(0xFF3E8BFF),
      corBotao: [Color(0xFF00E5FF), Color(0xFF2D7CFF)],
      rota: '/galaxia-techtron',
    ),
    _GalaxiaData(
      nome: 'Vita',
      imagemMascote: 'lib/assets/images/vita.png',
      tituloDescricao: 'Cuidando da\nVida',
      descricao: 'Saúde e bem-estar, com mundos que vão dos segredos do corpo humano aos avanços da biotecnologia.',
      corPrimaria: Color(0xFF00E676),
      corSecundaria: Color(0xFF1B9E3E),
      corBotao: [Color(0xFF00C853), Color(0xFF1B7A2F)],
      rota: '/galaxia-vita',
    ),
    _GalaxiaData(
      nome: 'Commercium',
      imagemMascote: 'lib/assets/images/commercium.png',
      tituloDescricao: 'O Império dos\nNegócios',
      descricao: 'Mentes empreendedoras e inovadoras que desejam criar negócios, gerir recursos e desenvolver soluções para o mercado.',
      corPrimaria: Color(0xFFCE93D8),
      corSecundaria: Color(0xFF9C27B0),
      corBotao: [Color(0xFFAB47BC), Color(0xFF6A1B9A)],
      rota: '/galaxia-commercium',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final galaxia = _galaxias[_paginaAtual];

    return Scaffold(
      backgroundColor: const Color(0xFF09051E),
      body: Stack(
        children: [
          _BackgroundGlow(cor: galaxia.corPrimaria),
          const _StarField(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Header
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
                    colors: [galaxia.corPrimaria, galaxia.corSecundaria],
                  ).createShader(bounds),
                  child: Text(
                    galaxia.nome,
                    style: const TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontFamily: 'Gugi',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _galaxias.length,
                    onPageChanged: (i) => setState(() => _paginaAtual = i),
                    itemBuilder: (context, index) {
                      final g = _galaxias[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _GlassCard(
                          borderColor: g.corPrimaria,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Mascote maior, sem ícones embaixo
                              Image.asset(
                                g.imagemMascote,
                                height: 220, // aumentado
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.smart_toy_outlined,
                                  size: 140,
                                  color: g.corPrimaria,
                                ),
                              ),

                              const SizedBox(height: 32),

                              // Botão Escolher
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: g.corBotao),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: g.corPrimaria.withOpacity(0.5),
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pushNamed(context, g.rota),
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
                      );
                    },
                  ),
                ),

                // Indicadores de página
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_galaxias.length, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _paginaAtual == i ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _paginaAtual == i
                              ? galaxia.corPrimaria
                              : Colors.white24,
                        ),
                      );
                    }),
                  ),
                ),

                // Card descrição
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: _GlassCard(
                    borderColor: galaxia.corPrimaria,
                    child: Column(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [galaxia.corPrimaria, galaxia.corSecundaria],
                          ).createShader(bounds),
                          child: Text(
                            galaxia.tituloDescricao,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          galaxia.descricao,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GalaxiaData {
  final String nome;
  final String imagemMascote;
  final String tituloDescricao;
  final String descricao;
  final Color corPrimaria;
  final Color corSecundaria;
  final List<Color> corBotao;
  final String rota;

  const _GalaxiaData({
    required this.nome,
    required this.imagemMascote,
    required this.tituloDescricao,
    required this.descricao,
    required this.corPrimaria,
    required this.corSecundaria,
    required this.corBotao,
    required this.rota,
  });
}

class _AvisoDialog extends StatelessWidget {
  const _AvisoDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF00E5FF), Color(0xFF1A8DE5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF131B40),
            borderRadius: BorderRadius.circular(19),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.smart_toy_outlined, size: 48, color: Color(0xFF00E5FF)),
                  const SizedBox(width: 12),
                  const Text(
                    '⚠️ Atenção',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                  children: [
                    TextSpan(text: 'Você pode escolher apenas uma trilha ('),
                    TextSpan(
                      text: 'galáxia',
                      style: TextStyle(color: Color(0xFF00E5FF)),
                    ),
                    TextSpan(
                      text: ') para explorar gratuitamente.\nLiberte todo o seu potencial e tenha acesso a todas as trilhas assinando o ',
                    ),
                    TextSpan(
                      text: 'Plano Pro',
                      style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 140,
                height: 46,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Ok',
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
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  const _GlassCard({required this.child, this.borderColor = const Color(0xFF00E5FF)});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: borderColor.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(color: borderColor.withOpacity(0.1), blurRadius: 30),
            ],
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
    return Stack(
      children: [
        Positioned(top: -80, right: -50, child: _glow(250, Colors.purple)),
        Positioned(bottom: 80, left: -60, child: _glow(220, cor)),
      ],
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 180)],
      ),
    );
  }
}

class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _StarPainter(),
    );
  }
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