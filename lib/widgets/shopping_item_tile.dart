import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/models/shopping_item.dart';
import 'package:shopping_list_app/providers/shopping_list_provider.dart';
import 'package:shopping_list_app/widgets/add_item_dialog.dart';

class ShoppingItemTile extends StatelessWidget {
  final ShoppingItem item;

  const ShoppingItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.name,
        style: TextStyle(
            decoration: item.isPurchased
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      subtitle:
          item.price > 0 ? Text('${item.price.toStringAsFixed(2)} €') : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: item.isPurchased,
            onChanged: (value) {
              Provider.of<ShoppingListProvider>(context, listen: false)
                  .togglePurchaseStatus(item.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AddItemDialog(existingItem: item));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<ShoppingListProvider>(context, listen: false)
                  .removeItem(item.id);
            },
          ),
        ],
      ),
    );
  }
}
