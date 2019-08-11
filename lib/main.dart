import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

import 'login_page.dart';

void main() => runApp(ChangeNotifierProvider(
  builder: (context) => Cart.empty(),
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
