import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;
  static DatabaseHelper _databaseHelper;

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._internalConstructor();
    print(
      ">>>>>>>>> Iniciando Banco Uma Unica Vez. ${_databaseHelper.hashCode}",
    );
    return _databaseHelper;
  }

  DatabaseHelper._internalConstructor();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "data.db"),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<Null> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS pessoa (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nomelegal VARCHAR(255) NOT NULL,        -- Nome ou razão social
          nomepopular VARCHAR(255) NOT NULL,      -- Sobrenome ou nome fantasia
          registrounico VARCHAR(18) NOT NULL,     -- CPF ou CNPJ
          registrogeral VARCHAR(50) NOT NULL,     -- RG ou IE
          dataorigem DATE NOT NULL,               -- Data de nascimento ou data de abertura
          site VARCHAR(255),                      -- Site da pessoa juridica
          tipo VARCHAR(255) NOT NULL              -- PESSOA_FISICA ou PESSOA_JURIDICA Enum
      );
      ''',
    );
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS produto (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao VARCHAR(255),
          valorunitario DOUBLE, 
          path VARCHAR(255),
          barcode VARCHAR(255)
      );
      ''',
    );
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS pedido (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idpessoa INT NOT NULL,                      -- Id da pessoa
          pessoa_nomelegal VARCHAR(255) NOT NULL,     -- Nome legal da pessoa
          pessoa_nomepopular VARCHAR(255) NOT NULL,   -- Nome poular da pessoa
          desconto DOUBLE NOT NULL,                   -- Desconto do pedido, em cima do valor bruto
          valorbruto DOUBLE NOT NULL,                 -- Valor bruto, sem desconto
          valorliquido DOUBLE NOT NULL,               -- Valor liquido, com deconto
          datahorainc DATETIME NOT NULL,              -- Data hora de criação do pedido
          datahoraalt DATETIME                        -- Data hora de alteração do pedido
      );
      ''',
    );
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS itempedido (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idpedido INT NOT NULL,                      -- Id do pedido
          idproduto INT NOT NULL,                     -- Id do Produto
          produto_descricao VARCHAR(255) NOT NULL,    -- Descrição do produto
          qtde DOUBLE NOT NULL,                       -- Quantidade do item
          desconto DOUBLE NOT NULL,                   -- Desconto do item, em cima do valor bruto
          valorbruto DOUBLE NOT NULL,                 -- Valor bruto, sem desconto
          valorliquido DOUBLE NOT NULL,               -- Valor liquido, com deconto
          valortotalbruto DOUBLE NOT NULL,            -- Valor total bruto, sem deconto, multiplicado pela quantidade
          valortotalliquido DOUBLE NOT NULL,          -- Valor total liquido, com deconto, multiplicado pela quantidade
          datahorainc DATETIME NOT NULL,              -- Data hora de criação do pedido
          datahoraalt DATETIME                        -- Data hora de alteração do pedido
      );
      ''',
    );
  }

}
