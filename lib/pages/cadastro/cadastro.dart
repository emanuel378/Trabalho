import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../services/memory_auth_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _senhaVisivel = false;

  // ── Validação de email ─────────────────────────────
  bool _emailValido(String email) {
    return RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$').hasMatch(email.trim());
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _cadastrar() async {
    final usuario = _usuarioController.text.trim();
    final email = _emailController.text.trim();
    final senha = _senhaController.text;

    if (usuario.isEmpty || email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos'), backgroundColor: Color(0xFF1A8DE5)),
      );
      return;
    }

    // ── Validação de formato de email ──
    if (!_emailValido(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um e-mail válido'), backgroundColor: Color(0xFF1A8DE5)),
      );
      return;
    }

    final auth = MemoryAuthService();
    final sucesso = await auth.cadastrar(usuario: usuario, email: email, senha: senha);

    if (!mounted) return;

    if (!sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou e-mail já cadastrado'), backgroundColor: Color(0xFF1A8DE5)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro realizado com sucesso!'), backgroundColor: Color(0xFF1A8DE5)),
    );
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B1E),
      body: Stack(
        children: [
          const _StarField(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  const Text(
                    'Bem vindo ao',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF00E5FF), Color(0xFF1A8DE5)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: const Text(
                      'Astro Lume',
                      style: TextStyle(fontFamily: 'Gugi', fontSize: 38, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _GradientBorderCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _Tab(label: 'Cria conta', selected: true, onTap: () {}),
                            _Tab(
                              label: 'Entrar',
                              selected: false,
                              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        _Campo(label: 'Usuário', hint: 'Digite seu nome', controller: _usuarioController),
                        const SizedBox(height: 20),
                        _Campo(
                          label: 'E-mail',
                          hint: 'Seu@email.com',
                          controller: _emailController,
                          teclado: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        _Campo(
                          label: 'Senha',
                          hint: 'Digite sua senha',
                          controller: _senhaController,
                          obscure: !_senhaVisivel,
                          sufixo: IconButton(
                            icon: Icon(
                              _senhaVisivel ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.white38,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                          ),
                        ),
                        const SizedBox(height: 24),
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
                              onPressed: _cadastrar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              child: const Text(
                                'Cadastrar',
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.white.withOpacity(0.15), thickness: 1)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text('ou', style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: Colors.white.withOpacity(0.4))),
                            ),
                            Expanded(child: Divider(color: Colors.white.withOpacity(0.15), thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: _SocialBtn(label: 'Google', icon: Icons.g_mobiledata, onTap: () {})),
                            const SizedBox(width: 12),
                            Expanded(child: _SocialBtn(label: 'Facebook', icon: Icons.facebook, onTap: () {})),
                          ],
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
        decoration: BoxDecoration(color: const Color(0xFF0D1230), borderRadius: BorderRadius.circular(19)),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: child,
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Tab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? const Color(0xFF00E5FF) : Colors.white38,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: selected ? const LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF1A8DE5)]) : null,
                color: selected ? null : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: teclado,
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.white.withOpacity(0.25), fontSize: 14),
            suffixIcon: sufixo,
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _SocialBtn({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
          color: Colors.white.withOpacity(0.04),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white70, size: 22),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _StarField extends StatelessWidget {
  const _StarField();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
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
        Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        random.nextDouble() * 1.8 + 0.4,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}