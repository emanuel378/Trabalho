import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../services/memory_auth_service.dart';

class EsqueciSenhaPage extends StatefulWidget {
  const EsqueciSenhaPage({super.key});

  @override
  State<EsqueciSenhaPage> createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {
  final _emailController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _novaSenhaVisivel = false;
  bool _confirmarSenhaVisivel = false;

  @override
  void dispose() {
    _emailController.dispose();
    _novaSenhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B1E),
      body: Stack(
        children: [
          // Fundo estrelado
          const _StarField(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Card topo: mascote + texto
                  _GradientBorderCard(
                    child: Row(
                      children: [
                        // Mascote
                        Image.asset(
                          'lib/assets/images/orioninterrogacao.png',
                          width: 80,
                          height: 80,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: const Icon(
                              Icons.smart_toy_outlined,
                              size: 40,
                              color: Color(0xFF00E5FF),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Texto
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Ei explorador,\n',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: 'esqueceu sua senha?',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF00E5FF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Card formulário
                  _GradientBorderCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        _Campo(
                          label: 'E-mail',
                          hint: 'Seu@email.com',
                          controller: _emailController,
                          teclado: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        _Campo(
                          label: 'Nova senha:',
                          hint: 'Insira sua senha',
                          controller: _novaSenhaController,
                          obscure: !_novaSenhaVisivel,
                          sufixo: IconButton(
                            icon: Icon(
                              _novaSenhaVisivel
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white38,
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _novaSenhaVisivel = !_novaSenhaVisivel,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        _Campo(
                          label: 'Confirmar senha:',
                          hint: 'Insira sua senha',
                          controller: _confirmarSenhaController,
                          obscure: !_confirmarSenhaVisivel,
                          sufixo: IconButton(
                            icon: Icon(
                              _confirmarSenhaVisivel
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white38,
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _confirmarSenhaVisivel =
                                  !_confirmarSenhaVisivel,
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Botão Confirmar senha
                        SizedBox(
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
                              onPressed: () async {
                                if (_emailController.text.isEmpty ||
                                    _novaSenhaController.text.isEmpty ||
                                    _confirmarSenhaController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Preencha todos os campos'),
                                      backgroundColor: Color(0xFF1A8DE5),
                                    ),
                                  );
                                  return;
                                }
                                if (_novaSenhaController.text !=
                                    _confirmarSenhaController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('As senhas não coincidem'),
                                      backgroundColor: Color(0xFF1A8DE5),
                                    ),
                                  );
                                  return;
                                }

                                final auth = MemoryAuthService();

                                final sucesso = await auth.alterarSenha(
                                  _emailController.text.trim(),
                                  _novaSenhaController.text,
                                );

                                if (!sucesso) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('E-mail não encontrado'),
                                      backgroundColor: Color(0xFF1A8DE5),
                                    ),
                                  );
                                  return;
                                }

                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Senha alterada com sucesso!',
                                    ),
                                    backgroundColor: Color(0xFF1A8DE5),
                                  ),
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Confirmar senha',
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

                        const SizedBox(height: 8),
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

// Card com borda gradiente
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
        decoration: BoxDecoration(
          color: const Color(0xFF0D1230),
          borderRadius: BorderRadius.circular(19),
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}

// Campo de texto
class _Campo extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType teclado;
  final Widget? sufixo;

  const _Campo({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.teclado = TextInputType.text,
    this.sufixo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: teclado,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white.withOpacity(0.25),
              fontSize: 14,
            ),
            suffixIcon: sufixo,
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF00E5FF),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Fundo estrelado
class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      painter: _StarPainter(),
    );
  }
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint();
    for (int i = 0; i < 120; i++) {
      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.6 + 0.1);
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        random.nextDouble() * 1.8 + 0.4,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
