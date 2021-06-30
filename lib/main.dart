import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/splash_screen.dart';

import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
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
      systemNavigationBarColor: Color(0xffFFF7EE),
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
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (context) => ProductsProvider(null, null, []),
          update: (context, auth, previousProducts) => ProductsProvider(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(null, null, []),
          update: (context, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MeShop",
          theme: ThemeData(
            primaryColor: const Color(0xff1E4E5F),
            accentColor: const Color(0xffFFB156),
            canvasColor: const Color(0xffFFF7EE),
            fontFamily: "Lato",
            appBarTheme: const AppBarTheme(
              brightness: Brightness.dark,
              backgroundColor: const Color(0xff1E4E5F),
              elevation: 0,
            ),
            cardTheme: const CardTheme(color: const Color(0xffFFFAF4)),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitinBuilder(),
                TargetPlatform.iOS: CustomPageTransitinBuilder(),
              },
            ),
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
