import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../services/memory_auth_service.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = MemoryAuthService();
    final usuario = auth.usuarioLogado;
    final nomeUsuario = usuario?['usuario'] ?? 'Comandante';

    return Scaffold(
      backgroundColor: const Color(0xFF09051E),
      body: Stack(
        children: [
          const _FundoEspacial(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // ── Header ───────────────────────────────────────
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white70, size: 16),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Perfil',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Avatar ───────────────────────────────────────
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00E5FF), Color(0xFF3E8BFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00E5FF).withOpacity(0.4),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.person_rounded,
                            color: Colors.white, size: 52),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF1A1040),
                            border: Border.all(
                                color: const Color(0xFF00E5FF), width: 2),
                          ),
                          child: const Icon(Icons.camera_alt_rounded,
                              color: Color(0xFF00E5FF), size: 14),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Nome e galáxia ───────────────────────────────
                  Text(
                    nomeUsuario,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF00E5FF).withOpacity(0.4)),
                    ),
                    child: const Text(
                      '🚀 Galáxia Techtron',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00E5FF),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Stats ────────────────────────────────────────
                  _GlassCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _StatItem(valor: '12', label: 'Missões'),
                        _Divisor(),
                        _StatItem(valor: '840', label: 'XP'),
                        _Divisor(),
                        _StatItem(valor: '3', label: 'Conquistas'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Missões ──────────────────────────────────────
                  const _SectionTitle(titulo: 'Missões Recentes'),
                  const SizedBox(height: 12),

                  const _MissaoItem(
                    icone: Icons.bolt_rounded,
                    titulo: 'O Chamado do Chip Ancestral',
                    subtitulo: 'Questão 1 de 5 • Techtron',
                    progresso: 0.2,
                    cor: Color(0xFF00E5FF),
                    concluida: false,
                  ),
                  const SizedBox(height: 10),
                  const _MissaoItem(
                    icone: Icons.check_circle_rounded,
                    titulo: 'Sintaxe das Estrelas',
                    subtitulo: 'Completa • Techtron',
                    progresso: 1.0,
                    cor: Color(0xFF00E676),
                    concluida: true,
                  ),
                  const SizedBox(height: 10),
                  const _MissaoItem(
                    icone: Icons.lock_rounded,
                    titulo: 'Núcleo Binário',
                    subtitulo: 'Bloqueada • Techtron',
                    progresso: 0.0,
                    cor: Colors.white30,
                    concluida: false,
                    bloqueada: true,
                  ),

                  const SizedBox(height: 28),

                  // ── Botão Sair ───────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmarAcao(
                        context,
                        titulo: 'Sair da conta',
                        mensagem: 'Tem certeza que deseja sair?',
                        labelBotao: 'Sair',
                        cor: const Color(0xFF00E5FF),
                        onConfirmar: () {
                          Navigator.of(context).pop();
                          MemoryAuthService().logout();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (_) => false);
                        },
                      ),
                      icon: const Icon(Icons.logout_rounded,
                          color: Color(0xFF00E5FF), size: 18),
                      label: const Text(
                        'Sair da conta',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00E5FF),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF00E5FF), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Botão Deletar ────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmarAcao(
                        context,
                        titulo: 'Deletar conta',
                        mensagem:
                            'Essa ação é permanente e não pode ser desfeita. Deseja continuar?',
                        labelBotao: 'Deletar',
                        cor: Colors.redAccent,
                        onConfirmar: () async {
                          final auth = MemoryAuthService();
                          final email = auth.usuarioLogado?['email'] ?? '';
                          await auth.deletarConta(email);
                          if (!context.mounted) return;
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (_) => false);
                        },
                      ),
                      icon: const Icon(Icons.delete_outline_rounded,
                          color: Colors.redAccent, size: 18),
                      label: const Text(
                        'Deletar conta',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.redAccent, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmarAcao(
    BuildContext context, {
    required String titulo,
    required String mensagem,
    required String labelBotao,
    required Color cor,
    required VoidCallback onConfirmar,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [cor, cor.withOpacity(0.6)],
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
                Icon(
                  labelBotao == 'Deletar'
                      ? Icons.warning_amber_rounded
                      : Icons.logout_rounded,
                  color: cor,
                  size: 44,
                ),
                const SizedBox(height: 12),
                Text(
                  titulo,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.white60,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          side: const BorderSide(color: Colors.white24),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Cancelar',
                            style: TextStyle(fontFamily: 'Poppins')),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: cor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: onConfirmar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(labelBotao,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// MISSÃO ITEM
// ══════════════════════════════════════════
class _MissaoItem extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String subtitulo;
  final double progresso;
  final Color cor;
  final bool concluida;
  final bool bloqueada;

  const _MissaoItem({
    required this.icone,
    required this.titulo,
    required this.subtitulo,
    required this.progresso,
    required this.cor,
    this.concluida = false,
    this.bloqueada = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cor.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icone, color: cor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: bloqueada ? Colors.white38 : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitulo,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                    if (!bloqueada) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progresso,
                          minHeight: 4,
                          backgroundColor: Colors.white12,
                          valueColor: AlwaysStoppedAnimation<Color>(cor),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (concluida)
                const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 20),
              if (bloqueada)
                const Icon(Icons.lock_rounded, color: Colors.white24, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// HELPERS
// ══════════════════════════════════════════
class _SectionTitle extends StatelessWidget {
  final String titulo;
  const _SectionTitle({required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        titulo,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String valor;
  final String label;
  const _StatItem({required this.valor, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          valor,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF00E5FF),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}

class _Divisor extends StatelessWidget {
  const _Divisor();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: Colors.white12);
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: child,
        ),
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
            size: MediaQuery.of(context).size, painter: _EstrelasPainter()),
        Positioned(
          top: -80,
          right: -50,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.purple.withOpacity(0.35), blurRadius: 180)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF00E5FF).withOpacity(0.15),
                    blurRadius: 160)
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
    for (int i = 0; i < 150; i++) {
      paint.color = Colors.white.withOpacity(rng.nextDouble() * 0.5 + 0.1);
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