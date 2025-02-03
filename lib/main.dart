import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/providers/shopping_list_provider.dart';
import 'package:shopping_list_app/screens/shopping_list_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ShoppingListProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste de Courses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShoppingListScreen(),
    );
  }
}
