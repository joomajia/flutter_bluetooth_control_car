import 'dart:io';
import 'package:flut_labs/EditProductScreen.dart';
import 'package:flut_labs/fileThemes.dart';
import 'package:flutter/material.dart';
import 'package:flut_labs/pageWithButtons.dart';
import 'package:image_picker/image_picker.dart';

class CustomAppBars extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  const CustomAppBars({
    required this.child,
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.height,
    required this.bottomLeftRadius,
    required this.bottomRightRadius,
  });
  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: child,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
          ),
        ));
  }
}

class ButtonForAlertDialog extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const ButtonForAlertDialog(
      {super.key, required this.label, required this.onPressed});

  @override
  State<ButtonForAlertDialog> createState() => _ButtonForAlertDialogState();
}

class _ButtonForAlertDialogState extends State<ButtonForAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColors,
          minimumSize: Size(100, 35),
          shape: LinearBorder(
            side: BorderSide(color: themeColor),
            bottom: LinearBorderEdge(),
          )),
      child: Text(widget.label),
      onPressed: widget.onPressed,
    );
  }
}

class PageWithList extends StatefulWidget {
  const PageWithList({super.key});

  @override
  _PageWithListState createState() => _PageWithListState();
}

class Product {
  String name;
  double cost;
  File? image;

  Product({required this.name, required this.cost, this.image});
}

class _PageWithListState extends State<PageWithList> {
  int? numberForDelete;
  List<Product> _products = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  // final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob'];
  // final List<int> numbersa = <int>[2, 0, 10, 6, 52];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addProductInList() {
    setState(() {
      _products.add(Product(
          name: nameController.text,
          cost: double.parse(numberController.text)));
    });
  }

  void _deleteFromList() {
    setState(() {
      _products.removeAt(numberForDelete!);
      //_products.removeWhere(Product(name: "ss", cost: double.parse(11)));
    });
  }

  void _viewCardContent(Product product, int a) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(product.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (product.image != null)
                Image.file(
                  product.image!,
                  height: 100,
                ),
              SizedBox(height: 16.0),

              Text('Стоимость: ${product.cost.toString()}'),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonForAlertDialog(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProductScreen(product: product),
                        ),
                      )
                          .then((editedProduct) {
                        if (editedProduct != null) {
                          setState(() {
                            _products[_products.indexOf(product)] =
                                editedProduct;
                          });
                          _showSnackBar('Продукт отредактирован');
                        }
                      });
                    },
                    label: 'Редактировать',
                  ),
                  
                  // ),
                  SizedBox(width: 16.0),
                  ButtonForAlertDialog(
                    onPressed: () {
                      numberForDelete = a;
                      _deleteFromList();
                      Navigator.of(context).pop();
                      _showSnackBar('Карточка удалена');
                    },
                    label: 'Удалить',
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: themeColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addImageForProduct(Product product) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        product.image = imageFile;
      });
      _showSnackBar('Изображение добавлено для продукта: ${product.name}');
    } else {
      _showSnackBar('Изображение не выбрано');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(196, 148, 124, 1.000),
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: CustomAppBars(
          title: 'Home',
          backgroundColor: Color(0xff000132),
          textColor: Colors.white,
          height: 200.0,
          bottomLeftRadius: 30,
          bottomRightRadius: 30,
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TextField(
                controller: nameController,
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 156, 155, 155)),
                  hintText: 'Введите имя',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  labelText: 'Имя',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(148, 148, 148, 1), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(255, 255, 255, 1), width: 3),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFieldWidgetInput(numberController: numberController),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CustomElevatedButton(
                onPressed: () {
                  _addProductInList();
                },
                label: 'Добавить',
              ),
            ],
          )),
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = _products[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ListTile(
                        textColor: Color.fromRGBO(207, 180, 162, 1.000),
                        tileColor: Color(0xFFFBFBFB),
                        title: Text(product.name),
                        subtitle: Text('cost: ${product.cost.toString()}'),
                        trailing: GestureDetector(
                            onTap: () {
                              _addImageForProduct(product);
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromRGBO(74, 52, 41, 1.000),
                              radius: 20,
                              backgroundImage: product.image != null
                                  ? FileImage(product.image!)
                                  : null,
                              child: product.image == null
                                  ? Icon(Icons.image)
                                  : null,
                            )),
                        onLongPress: () {
                          _viewCardContent(product, index);
                        },
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}

class TextFieldWidgetInput extends StatelessWidget {
  const TextFieldWidgetInput({
    super.key,
    required this.numberController,
  });

  final TextEditingController numberController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: numberController,
      style:
          const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
            color: Color.fromARGB(255, 156, 155, 155)),
        hintText: 'Введите число',
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255)),
        labelText: 'Число',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: Color.fromRGBO(148, 148, 148, 1), width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: Color.fromRGBO(255, 255, 255, 1), width: 3),
        ),
      ),
    );
  }
}



                        // onLongPress: () {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(10)),
                        //           title: const Text("Подтверждение"),
                        //           content: const Text("Удалить элемент?"),
                        //           actions: <Widget>[
                        //             CustomElevatedButton(
                        //               onPressed: () {
                        //                 numberForDelete = index;
                        //                 _deleteFromList();
                        //                 Navigator.of(context).pop(true);
                        //               },
                        //               label: 'Удалить',
                        //             ),
                        //             CustomElevatedButton(
                        //               onPressed: () {
                        //                 Navigator.of(context).pop(false);
                        //               },
                        //               label: 'Назад',
                        //             ),
                        //           ],
                        //         );
                        //       });
                        // },
  

