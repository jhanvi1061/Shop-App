import 'package:flutter/material.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red T-Shirt',
      description: 'A red tshirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/06/04/06/23/mockup-5257444__340.jpg',
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
      title: 'Shoes',
      description: 'Comfy shoes.',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2013/07/12/18/20/shoes-153310_960_720.png',
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
      id: 'p5',
      title: "Men's Watch",
      description: 'Perfect watch to get a royal look in  hand.',
      price: 29.99,
      // imageUrl:
      //     'https://cdn.pixabay.com/photo/2014/07/31/23/00/wristwatch-407096_960_720.jpg',
      imageUrl:
          'https://raw.githubusercontent.com/jhanvi1061/Shop-App/master/web%20assests/wristwatch-407096_960_720.webp',
    ),
    Product(
      id: 'p6',
      title: 'Reading Glasses',
      description: 'Get a funky look wearing this.',
      price: 59.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/03/09/15/21/glasses-1246611_960_720.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Jeans',
      description: 'Funky Jeans.',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/05/21/14/54/feet-349687_960_720.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Macbook Air',
      description: 'Enhance your workplace with the new MacBook Air Model.',
      price: 49.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/05/02/21/50/laptop-336378_960_720.jpg',
    ),
    Product(
      id: 'p9',
      title: 'Winter Jacket',
      description: 'Save yourself from winter cold.',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/03/26/09/54/person-690547_960_720.jpg',
    ),
    Product(
      id: 'p10',
      title: 'Makeup Accessories',
      description: 'Perfect set of brushes to add to your makeup wardrobe.',
      price: 59.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/02/19/11/35/makeup-1209798_960_720.jpg',
    ),
    Product(
      id: 'p11',
      title: 'Night Lamp',
      description: 'Light your night.',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/08/18/20/05/light-bulbs-1603766_960_720.jpg',
    ),
    Product(
      id: 'p12',
      title: 'Bluetooth Speaker',
      description: 'Perfect to listen music at high volume.',
      price: 49.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2019/04/07/09/41/speakers-4109274_960_720.jpg',
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
