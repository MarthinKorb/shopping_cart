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
            CREATE TABLE product (
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

// CREATE TABLE order (
//     id INTEGER PRIMARY KEY,
//     total NUMBER,
//     date TEXT,
// );
// CREATE TABLE product_order (
//     id INTEGER PRIMARY KEY,
//     id_product INTEGER,
//     id_order INTEGER,
//      FOREIGN KEY (id_product)
//       REFERENCES Product (id)
//         ON UPDATE SET CASCADE
//         ON DELETE SET CASCADE
//      FOREIGN KEY (id_order)
//       REFERENCES oder (id)
//         ON UPDATE SET CASCADE
//         ON DELETE SET CASCADE
// );
