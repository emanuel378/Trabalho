import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance =
      DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static Database? _database;

  static void init() {}

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();

    return _database!;
  }

  Future<Database> _open() async {
    final path = join(
      await getDatabasesPath(),
      'astrolume.db',
    );

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
CREATE TABLE usuarios(
id INTEGER PRIMARY KEY AUTOINCREMENT,
usuario TEXT UNIQUE,
email TEXT UNIQUE,
senha TEXT
)
""");
      },
    );
  }

  Future<int> inserirUsuario({
    required String usuario,
    required String email,
    required String senha,
  }) async {
    final db = await database;

    return db.insert(
      'usuarios',
      {
        'usuario': usuario,
        'email': email,
        'senha': senha,
      },
    );
  }

  Future<Map<String, dynamic>?> buscarUsuarioPorEmail(
      String email) async {
    final db = await database;

    final r = await db.query(
      'usuarios',
      where: 'email=?',
      whereArgs: [email],
      limit: 1,
    );

    return r.isEmpty ? null : r.first;
  }

  Future<bool> verificarUsuarioExiste(
      String usuario) async {
    final db = await database;

    final r = await db.query(
      'usuarios',
      where: 'usuario=?',
      whereArgs: [usuario],
    );

    return r.isNotEmpty;
  }

  Future<bool> verificarEmailExiste(
      String email) async {
    return (await buscarUsuarioPorEmail(
          email,
        )) !=
        null;
  }

  Future<bool> atualizarSenha(
      String email,
      String senha) async {
    final db = await database;

    final rows = await db.update(
      'usuarios',
      {'senha': senha},
      where: 'email=?',
      whereArgs: [email],
    );

    return rows > 0;
  }
}