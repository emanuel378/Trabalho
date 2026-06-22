import 'dart:math' as math;
import 'package:flutter/material.dart';

class MapaGalaxiaPage extends StatelessWidget {
  const MapaGalaxiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060022),
      body: Stack(
        children: [
          // Fundo espacial
          const _FundoEspacial(),

          SafeArea(
            child: Column(
              children: [
                // Header com título
                const _Header(),

                // Mapa scrollável
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: _MapaCompleto(),
                    ),
                  ),
                ),

                // Barra de progresso
                const _BarraProgresso(),
              ],
            ),
          ),

          // Bottom nav fixo
          const Align(
            alignment: Alignment.bottomCenter,
            child: _BottomNav(),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// HEADER
// ══════════════════════════════════════════
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F6E).withOpacity(0.85),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF32D9FF).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            const Text(
              'A Ascensão de Orion',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'O ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  TextSpan(
                    text: 'Herói Tecnomante',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF32D9FF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// MAPA COMPLETO
// ══════════════════════════════════════════
class _MapaCompleto extends StatelessWidget {
  _MapaCompleto();

  // Tamanhos dos nós
  static const double nodeW = 64;
  static const double nodeH = 56;
  static const double hGap = 32; // espaço horizontal entre nós
  static const double vGap = 54; // espaço vertical entre linhas
  static const double connW = 10; // espessura das conexões

  // Largura total da grade (3 colunas)
  static const double totalW = nodeW * 3 + hGap * 2; // 64*3 + 32*2 = 256

  // Posições X das 3 colunas (centro de cada nó)
  static const double col1cx = nodeW / 2;
  static const double col2cx = nodeW + hGap + nodeW / 2;
  static const double col3cx = nodeW * 2 + hGap * 2 + nodeW / 2;

  // Posições Y das 4 linhas (centro de cada nó)
  static const double row1cy = nodeH / 2;
  static const double row2cy = nodeH + vGap + nodeH / 2;
  static const double row3cy = nodeH * 2 + vGap * 2 + nodeH / 2;
  static const double row4cy = nodeH * 3 + vGap * 3 + nodeH / 2;

  // Altura total do mapa de nós (4 linhas)
  static const double mapaH = nodeH * 4 + vGap * 3;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final offsetX = (screenW - totalW) / 2;

    // MAPA PARTE 1: questões 1-7 (topo com nave) + NAVE acima
    // MAPA PARTE 2: questões 8-10 + planeta
    // Vou montar tudo em um Stack grande

    // Altura total: nave(100) + gap(16) + mapa_1-7 + gap + mapa_8-10 + planeta
    // Linha 1: 1, 2
    // Linha 2: 5, 4, 3
    // Linha 3: ★, 6, 7
    // Linha 4: 10, 9, 8
    // Planeta embaixo

    const naveH = 100.0;
    const naveGap = 16.0;
    const planetaH = 160.0;
    const planetaGap = 32.0;
    const totalHeight = naveH + naveGap + mapaH + planetaGap + planetaH;

    return SizedBox(
      width: screenW,
      height: totalHeight,
      child: Stack(
        children: [
          // ── NAVE (topo, centralizada) ──
          Positioned(
            top: 0,
            left: (screenW - 90) / 2,
            child: Image.asset(
              'lib/assets/images/NAVE.png',
              width: 90,
              height: naveH,
              errorBuilder: (_, __, ___) => const _NavePlaceholder(),
            ),
          ),

          // ── CONEXÕES (CustomPainter) ──
          Positioned(
            top: naveH + naveGap,
            left: offsetX,
            child: CustomPaint(
              size: const Size(totalW, mapaH),
              painter: _ConexoesPainter(
                col1cx: col1cx, col2cx: col2cx, col3cx: col3cx,
                row1cy: row1cy, row2cy: row2cy, row3cy: row3cy, row4cy: row4cy,
                nodeW: nodeW, nodeH: nodeH,
              ),
            ),
          ),

          // ══ LINHA 1: questões 1, 2 ══
          // questão 1 → col2, row1
          Positioned(
            top: naveH + naveGap + row1cy - nodeH / 2,
            left: offsetX + col2cx - nodeW / 2,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/quest01-exp'),
              child: _No(numero: 1),
            ),
          ),
          // questão 2 → col3, row1
          Positioned(
            top: naveH + naveGap + row1cy - nodeH / 2,
            left: offsetX + col3cx - nodeW / 2,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/quest01-atv'),
              child: _No(numero: 2),
            ),
          ),

          // ══ LINHA 2: questões 5, 4, 3 ══
          // questão 5 → col1, row2
          Positioned(
            top: naveH + naveGap + row2cy - nodeH / 2,
            left: offsetX + col1cx - nodeW / 2,
            child: _No(numero: 5),
          ),
          // questão 4 → col2, row2
          Positioned(
            top: naveH + naveGap + row2cy - nodeH / 2,
            left: offsetX + col2cx - nodeW / 2,
            child: _No(numero: 4),
          ),
          // questão 3 → col3, row2
          Positioned(
            top: naveH + naveGap + row2cy - nodeH / 2,
            left: offsetX + col3cx - nodeW / 2,
            child: _No(numero: 3),
          ),

          // ══ LINHA 3: ★, 6, 7 ══
          // estrela → col1, row3
          Positioned(
            top: naveH + naveGap + row3cy - nodeH / 2,
            left: offsetX + col1cx - nodeW / 2,
            child: const _NoEstrela(),
          ),
          // questão 6 → col2, row3
          Positioned(
            top: naveH + naveGap + row3cy - nodeH / 2,
            left: offsetX + col2cx - nodeW / 2,
            child: _No(numero: 6),
          ),
          // questão 7 → col3, row3
          Positioned(
            top: naveH + naveGap + row3cy - nodeH / 2,
            left: offsetX + col3cx - nodeW / 2,
            child: _No(numero: 7),
          ),

          // ══ LINHA 4: 10, 9, 8 ══
          // questão 10 → col1, row4
          Positioned(
            top: naveH + naveGap + row4cy - nodeH / 2,
            left: offsetX + col1cx - nodeW / 2,
            child: _No(numero: 10),
          ),
          // questão 9 → col2, row4
          Positioned(
            top: naveH + naveGap + row4cy - nodeH / 2,
            left: offsetX + col2cx - nodeW / 2,
            child: _No(numero: 9),
          ),
          // questão 8 → col3, row4
          Positioned(
            top: naveH + naveGap + row4cy - nodeH / 2,
            left: offsetX + col3cx - nodeW / 2,
            child: _No(numero: 8),
          ),

          // ── MASCOTE (orion maior, ao lado do nó 1, clicável) ──
          Positioned(
            top: naveH + naveGap + row1cy - 50,
            left: offsetX + col2cx - nodeW / 2 - 88,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/historia'),
              child: Image.asset(
                'lib/assets/images/orionAcenando.png',
                width: 80,
                height: 80,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.smart_toy,
                  color: Color(0xFF32D9FF),
                  size: 60,
                ),
              ),
            ),
          ),

          // ── PLANETA + astronauta no fim ──
          Positioned(
            top: naveH + naveGap + mapaH + planetaGap,
            left: (screenW - 140) / 2,
            child: const _Planeta(),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// CUSTOM PAINTER DAS CONEXÕES
// ══════════════════════════════════════════
class _ConexoesPainter extends CustomPainter {
  final double col1cx, col2cx, col3cx;
  final double row1cy, row2cy, row3cy, row4cy;
  final double nodeW, nodeH;

  const _ConexoesPainter({
    required this.col1cx, required this.col2cx, required this.col3cx,
    required this.row1cy, required this.row2cy, required this.row3cy, required this.row4cy,
    required this.nodeW, required this.nodeH,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final shader = const LinearGradient(
      colors: [Color(0xFF32D9FF), Color(0xFF6CA7FF)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    paint.shader = shader;

    // nó esquerda de nó = cx - nodeW/2
    // nó direita de nó = cx + nodeW/2
    // nó topo = cy - nodeH/2
    // nó base = cy + nodeH/2

    // ── HORIZONTAL: 1 → 2 (col2 → col3, row1) ──
    _hLine(canvas, paint, col2cx + nodeW / 2, col3cx - nodeW / 2, row1cy);

    // ── HORIZONTAL: 5 → 4 (col1 → col2, row2) ──
    _hLine(canvas, paint, col1cx + nodeW / 2, col2cx - nodeW / 2, row2cy);

    // ── HORIZONTAL: 4 → 3 (col2 → col3, row2) ──
    _hLine(canvas, paint, col2cx + nodeW / 2, col3cx - nodeW / 2, row2cy);

    // ── VERTICAL: 2 ↓ 3 (col3, row1 → row2) ──
    _vLine(canvas, paint, col3cx, row1cy + nodeH / 2, row2cy - nodeH / 2);

    // ── VERTICAL: 5 ↓ ★ (col1, row2 → row3) ──
    _vLine(canvas, paint, col1cx, row2cy + nodeH / 2, row3cy - nodeH / 2);

    // ── HORIZONTAL: ★ → 6 (col1 → col2, row3) ──
    _hLine(canvas, paint, col1cx + nodeW / 2, col2cx - nodeW / 2, row3cy);

    // ── HORIZONTAL: 6 → 7 (col2 → col3, row3) ──
    _hLine(canvas, paint, col2cx + nodeW / 2, col3cx - nodeW / 2, row3cy);

    // ── VERTICAL: 7 ↓ 8 (col3, row3 → row4) ──
    _vLine(canvas, paint, col3cx, row3cy + nodeH / 2, row4cy - nodeH / 2);

    // ── HORIZONTAL: 10 → 9 (col1 → col2, row4) ──
    _hLine(canvas, paint, col1cx + nodeW / 2, col2cx - nodeW / 2, row4cy);

    // ── HORIZONTAL: 9 → 8 (col2 → col3, row4) ──
    _hLine(canvas, paint, col2cx + nodeW / 2, col3cx - nodeW / 2, row4cy);

    // ── VERTICAL: ★ ↓ 10 (col1, row3 → row4) ──
    _vLine(canvas, paint, col1cx, row3cy + nodeH / 2, row4cy - nodeH / 2);
  }

  void _hLine(Canvas canvas, Paint paint, double x1, double x2, double cy) {
    canvas.drawLine(Offset(x1, cy), Offset(x2, cy), paint);
  }

  void _vLine(Canvas canvas, Paint paint, double cx, double y1, double y2) {
    canvas.drawLine(Offset(cx, y1), Offset(cx, y2), paint);
  }

  @override
  bool shouldRepaint(_ConexoesPainter old) => false;
}

// ══════════════════════════════════════════
// NÓ QUESTÃO
// ══════════════════════════════════════════
class _No extends StatelessWidget {
  final int numero;
  const _No({required this.numero});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF2D33A8),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF151560),
            offset: Offset(0, 6),
            blurRadius: 0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '$numero',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// NÓ ESTRELA
// ══════════════════════════════════════════
class _NoEstrela extends StatelessWidget {
  const _NoEstrela();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF2D33A8),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF151560),
            offset: Offset(0, 6),
            blurRadius: 0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFD43B),
              blurRadius: 12,
            ),
          ],
        ),
        child: const Icon(
          Icons.star,
          color: Color(0xFFFFD43B),
          size: 30,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// PLANETA
// ══════════════════════════════════════════
class _Planeta extends StatelessWidget {
  const _Planeta();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Planeta
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF35B7E6),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF32D9FF).withOpacity(0.4),
                  blurRadius: 24,
                ),
              ],
            ),
            child: CustomPaint(painter: _PlanetaPainter()),
          ),

          // Astronauta (mascote pequeno)
          Positioned(
            top: 0,
            child: Image.asset(
              'lib/assets/images/orionAcenando.png',
              width: 50,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),

          // Bandeira vermelha
          Positioned(
            top: 8,
            right: 16,
            child: CustomPaint(
              size: const Size(28, 32),
              painter: _BandeiraPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanetaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final manchaPaint = Paint()..color = const Color(0xFF257FC5);
    // Manchas do planeta
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.35, size.height * 0.45), width: 36, height: 22),
      manchaPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.65, size.height * 0.6), width: 24, height: 14),
      manchaPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.72), width: 18, height: 10),
      manchaPaint,
    );
  }

  @override
  bool shouldRepaint(_PlanetaPainter old) => false;
}

class _BandeiraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Mastro
    final mastro = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(2, 0), const Offset(2, 32), mastro);

    // Bandeira
    final bandeira = Paint()..color = const Color(0xFFE53935);
    final path = Path()
      ..moveTo(2, 2)
      ..lineTo(28, 8)
      ..lineTo(2, 18)
      ..close();
    canvas.drawPath(path, bandeira);
  }

  @override
  bool shouldRepaint(_BandeiraPainter old) => false;
}

// ══════════════════════════════════════════
// NAVE PLACEHOLDER
// ══════════════════════════════════════════
class _NavePlaceholder extends StatelessWidget {
  const _NavePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF2D33A8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF32D9FF).withOpacity(0.5)),
      ),
      child: const Icon(Icons.rocket_launch, color: Color(0xFF32D9FF), size: 48),
    );
  }
}

// ══════════════════════════════════════════
// BARRA DE PROGRESSO
// ══════════════════════════════════════════
class _BarraProgresso extends StatelessWidget {
  const _BarraProgresso();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0830),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Progresso:',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '0/6 atividades',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '2%',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.02,
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF32D9FF)),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// BOTTOM NAV
// ══════════════════════════════════════════
class _BottomNav extends StatefulWidget {
  const _BottomNav();

  @override
  State<_BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<_BottomNav> {
  int _selected = 0;

  final _icons = const [
    Icons.home_outlined,
    Icons.star_outline,
    Icons.person_outline,
    Icons.chat_bubble_outline,
    Icons.emoji_events_outlined,
  ];

  final _assets = [
    'lib/assets/images/vectoHome.png',
    'lib/assets/images/vectoEstrela.png',
    'lib/assets/images/vectoUser.png',
    'lib/assets/images/vectoMSG.png',
    'lib/assets/images/vectoCoroa.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: 74,
      decoration: BoxDecoration(
        color: const Color(0xFF0B062B),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (i) {
          final selected = _selected == i;
          return GestureDetector(
            onTap: () {
                setState(() => _selected = i);
                if (i == 2) Navigator.pushNamed(context, '/perfil');
                if (i == 3) Navigator.pushNamed(context, '/lua-ia');
              },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              decoration: selected
                  ? BoxDecoration(
                      color: const Color(0xFFFFD43B).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    )
                  : null,
              child: Image.asset(
                _assets[i],
                width: 28,
                height: 28,
                color: selected ? const Color(0xFFFFD43B) : Colors.white54,
                errorBuilder: (_, __, ___) => Icon(
                  _icons[i],
                  color: selected ? const Color(0xFFFFD43B) : Colors.white54,
                  size: 26,
                ),
              ),
            ),
          );
        }),
      ),
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
        // Partículas/estrelas
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: _EstrelasPainter(),
        ),
        // Glow roxo superior direito
        Positioned(
          top: -60,
          right: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.35),
                  blurRadius: 160,
                ),
              ],
            ),
          ),
        ),
        // Glow roxo inferior esquerdo
        Positioned(
          bottom: 100,
          left: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.25),
                  blurRadius: 140,
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
    final rng = math.Random(99);
    final paint = Paint();
    for (int i = 0; i < 120; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final r = rng.nextDouble() * 1.6 + 0.3;
      paint.color = Colors.white.withOpacity(rng.nextDouble() * 0.6 + 0.15);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(_EstrelasPainter old) => false;
}