import 'package:flutter/material.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Blue T-Shirt',
      description: 'A blue tshirt - it is pretty blue!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/06/04/06/23/mockup-5257442__340.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Baby Jacket',
      description: 'Warm and cozy.',
      price: 59.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/05/22/17/53/mockup-5206354__340.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Red Tshirt',
      description: 'A red tshirt - it is pretty red!',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/06/04/06/23/mockup-5257444__340.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Tshirt',
      description: 'Simple tshirt to keep you away from summer heat.',
      price: 49.99,
      imageUrl:
          'https://d3uvb2lhumlp.cloudfront.net/pub/media/catalog/product/cache/f751fae08115cd00f88855057a9f034e/t/h/th9190_fsl_24_1.jpg',
    ),
    Product(
      id: 'p1',
      title: 'Blue T-Shirt',
      description: 'A blue tshirt - it is pretty blue!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/06/04/06/23/mockup-5257442__340.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Baby Jacket',
      description: 'Warm and cozy.',
      price: 59.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/05/22/17/53/mockup-5206354__340.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Red Tshirt',
      description: 'A red tshirt - it is pretty red!',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/06/04/06/23/mockup-5257444__340.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Tshirt',
      description: 'Simple tshirt to keep you away from summer heat.',
      price: 49.99,
      imageUrl:
          'https://d3uvb2lhumlp.cloudfront.net/pub/media/catalog/product/cache/f751fae08115cd00f88855057a9f034e/t/h/th9190_fsl_24_1.jpg',
    ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newproduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newproduct);
    // _items.insert(0,newproduct);  // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
