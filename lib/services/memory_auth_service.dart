class MemoryAuthService {
  static final MemoryAuthService _instance = MemoryAuthService._internal();

  factory MemoryAuthService() => _instance;

  MemoryAuthService._internal();

  static final List<Map<String, dynamic>> _usuarios = [];

  // ── Usuário logado ─────────────────────────────────
  Map<String, dynamic>? _usuarioLogado;

  Map<String, dynamic>? get usuarioLogado => _usuarioLogado;

  void setUsuarioLogado(Map<String, dynamic> usuario) {
    _usuarioLogado = usuario;
  }

  void logout() {
    _usuarioLogado = null;
  }

  // ── Cadastrar ──────────────────────────────────────
  Future<bool> cadastrar({
    required String usuario,
    required String email,
    required String senha,
  }) async {
    final existe = _usuarios.any(
      (u) =>
          u['email'].toString().toLowerCase() == email.toLowerCase() ||
          u['usuario'].toString().toLowerCase() == usuario.toLowerCase(),
    );

    if (existe) return false;

    _usuarios.add({
      'usuario': usuario,
      'email': email,
      'senha': senha,
    });

    return true;
  }

  // ── Login ──────────────────────────────────────────
  Future<Map<String, dynamic>?> login(String email, String senha) async {
    try {
      return _usuarios.firstWhere(
        (u) =>
            u['email'].toLowerCase() == email.toLowerCase() &&
            u['senha'] == senha,
      );
    } catch (_) {
      return null;
    }
  }

  // ── Alterar senha ──────────────────────────────────
  Future<bool> alterarSenha(String email, String novaSenha) async {
    try {
      final usuario = _usuarios.firstWhere(
        (u) => u['email'].toLowerCase() == email.toLowerCase(),
      );
      usuario['senha'] = novaSenha;
      return true;
    } catch (_) {
      return false;
    }
  }

  // ── Email existe ───────────────────────────────────
  Future<bool> emailExiste(String email) async {
    return _usuarios.any(
      (u) => u['email'].toLowerCase() == email.toLowerCase(),
    );
  }

  // ── Deletar conta ──────────────────────────────────
  Future<bool> deletarConta(String email) async {
    final tamanhoAntes = _usuarios.length;
    _usuarios.removeWhere(
      (u) => u['email'].toLowerCase() == email.toLowerCase(),
    );
    _usuarioLogado = null;
    return _usuarios.length < tamanhoAntes;
  }
}