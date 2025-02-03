import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/models/shopping_item.dart';
import 'package:shopping_list_app/providers/shopping_list_provider.dart';
import 'package:uuid/uuid.dart';

class AddItemDialog extends StatefulWidget {
  final ShoppingItem? existingItem;

  const AddItemDialog({Key? key, this.existingItem}) : super(key: key);

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.existingItem?.name ?? '');
    _priceController = TextEditingController(
        text: widget.existingItem?.price.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingItem == null
          ? 'Ajouter un article'
          : 'Modifier l\'article'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nom de l\'article',
            ),
          ),
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Prix (optionnel)',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              final newItem = ShoppingItem(
                id: widget.existingItem?.id ?? const Uuid().v4(),
                name: _nameController.text,
                price: double.tryParse(_priceController.text) ?? 0.0,
                isPurchased: widget.existingItem?.isPurchased ?? false,
              );

              final provider =
                  Provider.of<ShoppingListProvider>(context, listen: false);

              if (widget.existingItem == null) {
                provider.addItem(newItem);
              } else {
                provider.updateItem(newItem);
              }

              Navigator.of(context).pop();
            }
          },
          child: Text(widget.existingItem == null ? 'Ajouter' : 'Modifier'),
        ),
      ],
    );
  }
}
