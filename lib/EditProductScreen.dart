// Создайте новый экран редактирования продукта (EditProductScreen)
import 'dart:io';

import 'package:flut_labs/pageWithList.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _costController = TextEditingController();
  File? _editedImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _costController.text = widget.product.cost.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final editedName = _nameController.text;
    final editedCost = double.tryParse(_costController.text) ?? 0.0;

    widget.product.name = editedName;
    widget.product.cost = editedCost;
    widget.product.image = _editedImage;

    Navigator.of(context).pop(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование продукта'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Название продукта'),
            ),
            TextFormField(
              controller: _costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Стоимость'),
            ),
            SizedBox(height: 20.0),
            
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _editedImage = File(pickedFile.path);
                  });
                }
              },
              child: Text('Выбрать изображение'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  _saveChanges;
                },
                child: Text('svae')),
                
            // Отобразите выбранное изображение (если оно есть)
            if (_editedImage != null) Image.file(_editedImage!, height: 200.0),
          ],
        ),
      ),
    );
  }
}
