import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

// Classe utilitária para interação com banco de dados
class DbUtils {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'banco.db'),
      version: 1,
      // Função chamada na atualização do banco
      onUpgrade: (db, oldVersion, newVersion) {},
      // Função chamada na criação do banco
      onCreate: (db, version) {
        return db.execute('''
            CREATE TABLE Product (
                id INTEGER PRIMARY KEY,
                title TEXT,
                description TEXT,
                category TEXT,
                price NUMBER,
                image TEXT,
                isFavorite NUMBER
            )''');
      },
    );
  }
}
