import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/providers/shopping_list_provider.dart';
import 'package:shopping_list_app/widgets/add_item_dialog.dart';
import 'package:shopping_list_app/widgets/shopping_item_tile.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ُEasy Shopping'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ShoppingListProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: (context, index) {
                    return ShoppingItemTile(item: provider.items[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ShoppingListProvider>(
              builder: (context, provider, child) {
                return Text(
                  'Total: ${provider.totalPrice.toStringAsFixed(2)} €',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddItemDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
