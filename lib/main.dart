import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // setting system ui overlay style
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      // statusBarColor is used to set Status bar color in Android devices.
      statusBarColor: Colors.transparent,
      // To make Status bar icons color white in Android devices.
      statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness is used to set Status bar icon color in iOS.
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  // setting preffered orientations for the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MeShop());
}

class MeShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Build() - MeShop");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MeShop",
        theme: ThemeData(
          primaryColor: Color(0xff1E4E5F),
          accentColor: Color(0xffFFB156),
          canvasColor: Color(0xffFFF7EE),
          fontFamily: "Lato",
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            backgroundColor: Color(0xff1E4E5F),
            elevation: 0,
          ),
          cardTheme: CardTheme(
            color: Color(0xffFFFAF4),
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
