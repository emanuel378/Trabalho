import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'tts_service.dart'; // funciona em web E mobile

class Quest01AtvPage extends StatefulWidget {
  const Quest01AtvPage({super.key});

  @override
  State<Quest01AtvPage> createState() => _Quest01AtvPageState();
}

class _Quest01AtvPageState extends State<Quest01AtvPage> {
  static const int _respostaCorreta = 0;

  int? _selecionado;
  bool get _respondeu => _selecionado != null;
  bool get _acertou => _selecionado == _respostaCorreta;

  final List<String> _opcoes = ['A) é', 'B) e', 'C) ê'];

  // ── TTS ────────────────────────────────────────────
  final _tts = TtsService();
  bool _ttsAtivo = false;

  @override
  void initState() {
    super.initState();
    _tts.configurar();
  }

  Future<void> _falar(String texto) async {
    if (!_ttsAtivo) return;
    await _tts.falar(texto);
  }

  Future<void> _lerTela() async {
    await _falar(
      'Questão. Complete a frase que aparece no holograma: '
      'O conhecimento, lacuna, a arma mais poderosa. '
      'As opções são: A, é. B, e. C, ê.',
    );
  }

  @override
  void dispose() {
    _tts.parar();
    super.dispose();
  }
  // ───────────────────────────────────────────────────

  void _selecionar(int index) {
    if (_respondeu) return;
    setState(() => _selecionado = index);
    if (_ttsAtivo) {
      final acertou = index == _respostaCorreta;
      _falar(acertou
          ? 'Parabéns! Você acertou! A resposta correta é ${_opcoes[_respostaCorreta]}.'
          : 'Que pena! Você errou. A resposta correta é ${_opcoes[_respostaCorreta]}.');
    }
  }

  Color _corBotao(int index) {
    if (!_respondeu) return const Color(0xFF00D4FF);
    if (index == _respostaCorreta) return Colors.green;
    if (index == _selecionado) return Colors.red;
    return const Color(0xFF00D4FF);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0620),
      body: Stack(
        children: [
          const _FundoEspacial(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ── Título + botão TTS ───────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'O Chamado do ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: 'Chip\nAncestral',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF00E5FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Botão de acessibilidade - agora visível ao lado direito
                      Tooltip(
                        message: _ttsAtivo
                            ? 'Desativar leitura de tela'
                            : 'Ativar leitura de tela',
                        child: GestureDetector(
                          onTap: () async {
                            setState(() => _ttsAtivo = !_ttsAtivo);
                            if (_ttsAtivo) {
                              await _tts.falar('Leitura de tela ativada.');
                              await Future.delayed(
                                  const Duration(milliseconds: 800));
                              await _lerTela();
                            } else {
                              await _tts.parar();
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _ttsAtivo
                                  ? const Color(0xFF00E5FF).withOpacity(0.2)
                                  : Colors.white.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _ttsAtivo
                                    ? const Color(0xFF00E5FF)
                                    : Colors.white24,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              _ttsAtivo
                                  ? Icons.volume_up_rounded
                                  : Icons.volume_off_rounded,
                              color: _ttsAtivo
                                  ? const Color(0xFF00E5FF)
                                  : Colors.white38,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Card da pergunta ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Semantics(
                    label: 'Pergunta: Complete a frase que aparece no holograma: '
                        'O conhecimento, lacuna, a arma mais poderosa.',
                    child: GestureDetector(
                      onTap: () => _falar(
                        'Complete a frase que aparece no holograma: '
                        'O conhecimento, lacuna, a arma mais poderosa.',
                      ),
                      child: _CardPergunta(
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
                              TextSpan(text: 'Complete a frase que\naparece no holograma:\n'),
                              TextSpan(
                                text: '"O conhecimento _ a\narma mais poderosa."',
                                style: TextStyle(color: Color(0xFF00E5FF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Opções + Mascote ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _Mascote(respondeu: _respondeu, acertou: _acertou),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: List.generate(_opcoes.length, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Semantics(
                                button: true,
                                label: 'Opção ${_opcoes[i]}',
                                child: _BotaoOpcao(
                                  label: _opcoes[i],
                                  cor: _corBotao(i),
                                  onTap: () => _selecionar(i),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // ── Botão re-ouvir ────────────────────────────────
                if (_ttsAtivo)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, left: 24, right: 24),
                    child: GestureDetector(
                      onTap: _lerTela,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFF00E5FF).withOpacity(0.4)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.replay_rounded,
                                color: Color(0xFF00E5FF), size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Ouvir novamente',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF00E5FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // ── Continuar ─────────────────────────────────────
                if (_respondeu) ...[
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
                            _tts.parar();
                            // próxima questão
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
                ],

                // ── Voltar ────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        _tts.parar();
                        Navigator.pop(context);
                      },
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
// MASCOTE
// ══════════════════════════════════════════
class _Mascote extends StatelessWidget {
  final bool respondeu;
  final bool acertou;
  const _Mascote({required this.respondeu, required this.acertou});

  @override
  Widget build(BuildContext context) {
    String asset;
    if (!respondeu) {
      asset = 'lib/assets/images/orionParado.png';
    } else if (acertou) {
      asset = 'lib/assets/images/orionAcerto.png';
    } else {
      asset = 'lib/assets/images/orionError.png';
    }

    return Row(
     
      children: [
        Image.asset(
          asset, width: 72, height: 72,
          errorBuilder: (_, __, ___) => Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
            ),
            child: Icon(
              respondeu
                  ? (acertou ? Icons.check_circle_outline : Icons.cancel_outlined)
                  : Icons.smart_toy_outlined,
              color: respondeu ? (acertou ? Colors.green : Colors.red) : const Color(0xFF00E5FF),
              size: 36,
            ),
          ),
        ),
        if (respondeu)
          Positioned(
            bottom: -4, right: -4,
            child: Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                color: acertou ? Colors.green : Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0A0620), width: 2),
              ),
              child: Icon(acertou ? Icons.check : Icons.close, color: Colors.white, size: 14),
            ),
          ),
        Positioned(
          bottom: -8, left: 0, right: 0,
          child: Center(
            child: Image.asset(
              'lib/assets/images/vectoEstrela.png', width: 20, height: 20,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.star, color: Color(0xFFFFD700), size: 18),
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════
// BOTÃO DE OPÇÃO
// ══════════════════════════════════════════
class _BotaoOpcao extends StatelessWidget {
  final String label;
  final Color cor;
  final VoidCallback onTap;
  const _BotaoOpcao({required this.label, required this.cor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity, height: 48,
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: cor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Center(
          child: Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// CARD DA PERGUNTA
// ══════════════════════════════════════════
class _CardPergunta extends StatelessWidget {
  final Widget child;
  const _CardPergunta({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        CustomPaint(size: MediaQuery.of(context).size, painter: _EstrelasPainter()),
        CustomPaint(size: MediaQuery.of(context).size, painter: _ListrasPainter()),
        Positioned(
          top: 100, left: -60,
          child: Container(width: 200, height: 200,
            decoration: BoxDecoration(shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.35), blurRadius: 160)])),
        ),
        Positioned(
          bottom: 200, right: -60,
          child: Container(width: 180, height: 180,
            decoration: BoxDecoration(shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.3), blurRadius: 140)])),
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
      paint.color = Colors.white.withOpacity(rng.nextDouble() * 0.5 + 0.1);
      canvas.drawCircle(Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height), rng.nextDouble() * 1.5 + 0.3, paint);
    }
  }
  @override bool shouldRepaint(_EstrelasPainter old) => false;
}

class _ListrasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.03)..strokeWidth = 18;
    for (double x = 0; x < size.width; x += 38) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }
  @override bool shouldRepaint(_ListrasPainter old) => false;
}