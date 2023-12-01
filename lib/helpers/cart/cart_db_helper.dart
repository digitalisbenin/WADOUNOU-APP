import 'package:digitalis_restaurant_app/core/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class CartDBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, description TEXT, image TEXT)');
  }

  Future<CartModel> insert(CartModel cart) async {
    print(cart.toMap());
    var dbClient = await db;
    // Vérifiez d'abord si le produit existe dans le panier
    final existingProduct =
        await getProductByProductId(cart.productId.toString());
    if (existingProduct != null) {
      // Le produit existe déjà dans le panier, affichez un message Snackbar
      throw Exception('Le produit existe déjà dans le panier'); // Ou vous pouvez lancer une exception ici si vous le souhaitez
    }
    try {
      // Le produit n'existe pas dans le panier, insérez-le
      await dbClient!.insert(
        'cart',
        cart.toMap(),
      );
    } catch (e) {
      print('Erreur lors de l\'insertion : $e');
      throw Exception('Erreur lors de l\'insertion : $e');
    }
    return cart;
  }

  Future<CartModel?> getProductByProductId(String productId) async {
    var dbClient = await db;
    if (dbClient == null) {
      // Gérer le cas où la base de données n'a pas été initialisée
      return null;
    }
    final List<Map<String, Object?>> queryResult = await dbClient.query(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );

    if (queryResult.isNotEmpty) {
      // Si un produit avec le même productId est trouvé, renvoyez-le
      return CartModel.fromMap(queryResult.first);
    }

    return null; // Si le produit n'est pas trouvé, renvoyez null
  }

  Future<List<CartModel>> getCartList() async {
    var dbClient = await db;
    if (dbClient == null) {
      // Gérer le cas où la base de données n'a pas pu être initialisée
      return [];
    }
    final List<Map<String, Object?>> queryResult = await dbClient.query('cart');
    return queryResult.map((e) => CartModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  
  Future<int> updateQuantity(CartModel cart) async {
    var dbClient = await db;
    return await dbClient!
        .update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
  }
}