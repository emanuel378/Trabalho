import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LuaIAPage extends StatefulWidget {
  const LuaIAPage({super.key});

  @override
  State<LuaIAPage> createState() => _LuaIAPageState();
}

class _LuaIAPageState extends State<LuaIAPage> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_Mensagem> _mensagens = [];
  bool _carregando = false;

  // Lê a chave do .env
  static String get _groqApiKey => dotenv.env['GROQ_API_KEY'] ?? '';

  static const String _sistemaPrompt = '''
Você é Lua, uma tutora de IA simpática, paciente e didática do app Astrolume.
Você ajuda estudantes a entender conteúdos escolares de forma clara e amigável.
Use exemplos do dia a dia, seja encorajador e use linguagem simples.
Responda sempre em português brasileiro.
Seja concisa — máximo 3 parágrafos por resposta.
''';

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _enviarMensagem() async {
    final texto = _inputController.text.trim();
    if (texto.isEmpty || _carregando) return;

    setState(() {
      _mensagens.add(_Mensagem(texto: texto, isUsuario: true));
      _carregando = true;
    });
    _inputController.clear();
    _rolarParaBaixo();

    try {
      final historico = _mensagens.map((m) => {
        'role': m.isUsuario ? 'user' : 'assistant',
        'content': m.texto,
      }).toList();

      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_groqApiKey',
        },
        body: jsonEncode({
          'model': 'llama-3.1-8b-instant',
          'messages': [
            {'role': 'system', 'content': _sistemaPrompt},
            ...historico,
          ],
          'max_tokens': 512,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final resposta = data['choices'][0]['message']['content'] as String;
        setState(() {
          _mensagens.add(_Mensagem(texto: resposta.trim(), isUsuario: false));
        });
      } else {
        setState(() {
          _mensagens.add(_Mensagem(
            texto: 'Ops! Tive um problema para responder. Tente novamente.',
            isUsuario: false,
          ));
        });
      }
    } catch (e) {
      setState(() {
        _mensagens.add(_Mensagem(
          texto: 'Sem conexão. Verifique sua internet e tente novamente.',
          isUsuario: false,
        ));
      });
    } finally {
      setState(() => _carregando = false);
      _rolarParaBaixo();
    }
  }

  void _rolarParaBaixo() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0520),
      body: Stack(
        children: [
          const _FundoEspacial(),
          Column(
            children: [
              _AppBarLua(context),
              Expanded(
                child: _mensagens.isEmpty
                    ? const _TelaVazia()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        itemCount: _mensagens.length + (_carregando ? 1 : 0),
                        itemBuilder: (context, i) {
                          if (i == _mensagens.length && _carregando) {
                            return const _BolhaDigitando();
                          }
                          return _BolhaMensagem(mensagem: _mensagens[i]);
                        },
                      ),
              ),
              _InputArea(
                controller: _inputController,
                onEnviar: _enviarMensagem,
                carregando: _carregando,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _AppBarLua(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 18),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Image.asset(
                  'lib/assets/images/lua.png',
                  width: 36,
                  height: 36,
                  errorBuilder: (_, __, ___) => Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2D1B69),
                    ),
                    child: const Icon(Icons.face, color: Colors.white70, size: 22),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Lua IA',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// MODELO MENSAGEM
// ══════════════════════════════════════════
class _Mensagem {
  final String texto;
  final bool isUsuario;
  _Mensagem({required this.texto, required this.isUsuario});
}

// ══════════════════════════════════════════
// TELA VAZIA
// ══════════════════════════════════════════
class _TelaVazia extends StatelessWidget {
  const _TelaVazia();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/lua.png',
            width: 80,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.face,
              color: Colors.white38,
              size: 64,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Olá! Sou a Lua 🌙\nPergunta o que quiser!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.white54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// BOLHA DE MENSAGEM
// ══════════════════════════════════════════
class _BolhaMensagem extends StatelessWidget {
  final _Mensagem mensagem;
  const _BolhaMensagem({required this.mensagem});

  @override
  Widget build(BuildContext context) {
    final isUsuario = mensagem.isUsuario;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment:
            isUsuario ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: isUsuario ? 0 : 52,
              right: isUsuario ? 52 : 0,
              bottom: 6,
            ),
            child: Text(
              isUsuario ? 'Você' : 'Lua',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Row(
            mainAxisAlignment:
                isUsuario ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUsuario) ...[
                Image.asset(
                  'lib/assets/images/lua.png',
                  width: 40,
                  height: 40,
                  errorBuilder: (_, __, ___) => Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2D1B69),
                    ),
                    child: const Icon(Icons.face, color: Colors.white70, size: 24),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUsuario
                        ? const Color(0xFF2D1B69)
                        : const Color(0xFF1A1040),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isUsuario ? 18 : 4),
                      bottomRight: Radius.circular(isUsuario ? 4 : 18),
                    ),
                  ),
                  child: Text(
                    mensagem.texto,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              if (isUsuario) ...[
                const SizedBox(width: 8),
                Image.asset(
                  'lib/assets/images/orionAcenando.png',
                  width: 40,
                  height: 40,
                  errorBuilder: (_, __, ___) => Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A3A6E),
                    ),
                    child: const Icon(Icons.person, color: Colors.white70, size: 24),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// BOLHA DIGITANDO
// ══════════════════════════════════════════
class _BolhaDigitando extends StatelessWidget {
  const _BolhaDigitando();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            'lib/assets/images/lua.png',
            width: 40,
            height: 40,
            errorBuilder: (_, __, ___) => Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2D1B69),
              ),
              child: const Icon(Icons.face, color: Colors.white70, size: 24),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1040),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _PontoAnimado(delay: i * 200)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PontoAnimado extends StatefulWidget {
  final int delay;
  const _PontoAnimado({required this.delay});

  @override
  State<_PontoAnimado> createState() => _PontoAnimadoState();
}

class _PontoAnimadoState extends State<_PontoAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
    _anim = Tween(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(_anim.value),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// INPUT
// ══════════════════════════════════════════
class _InputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onEnviar;
  final bool carregando;

  const _InputArea({
    required this.controller,
    required this.onEnviar,
    required this.carregando,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Escreva aqui...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: const Color(0xFF1A1040),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => onEnviar(),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: carregando ? null : onEnviar,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: carregando
                      ? [Colors.grey, Colors.grey]
                      : [const Color(0xFF00E5FF), const Color(0xFF1A8DE5)],
                ),
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 22),
            ),
          ),
        ],
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
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: _EstrelasPainter(),
        ),
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
                    color: Colors.purple.withOpacity(0.4), blurRadius: 160),
              ],
            ),
          ),
        ),
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
                    color: Colors.purple.withOpacity(0.3), blurRadius: 140),
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
    final rng = math.Random(33);
    final paint = Paint();
    for (int i = 0; i < 100; i++) {
      paint.color = Colors.white.withOpacity(rng.nextDouble() * 0.5 + 0.1);
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width,
            rng.nextDouble() * size.height),
        rng.nextDouble() * 1.5 + 0.3,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EstrelasPainter old) => false;
}