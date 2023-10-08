// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primaryColor: Colors.green),
//       home: const MultipleImageSelector(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }



// // ignore_for_file: library_private_types_in_public_api

// // import 'package:flut_labs/pageWithButtons.dart';
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Product {
//   final String name;
//   final double cost;

//   Product({required this.name, required this.cost});
// }

// class Cart with ChangeNotifier {
//   List<Product> products = [];

//   double get total {
//     return products.fold(0.0, (double currentTotal, Product nextProduct) {
//       return currentTotal + nextProduct.cost;
//     });
//   }

//   void addToCart(Product product) => products.add(product);
//   void removeFromCart(Product product) {
//     products.remove(product);
//     notifyListeners();
//   }
// }

// class User {
//   final String name;

//   User({required this.name});
// }

// class Store {
//   StreamController<List<Product>> _streamController =
//       StreamController<List<Product>>();
//   Stream<List<Product>> get allProductsForSale => _streamController.stream;

//   Store() {
//     _streamController.add(<Product>[]);
//     _initialize();
//   }

//   void _initialize() {
//     MockDatabase().getProductsBatched().listen((List<Product> products) {
//       _streamController.add(products);
//     });
//   }

//   void dispose() {
//     _streamController.close();
//   }
// }

// class MockDatabase {
//   static final MockDatabase _instance = MockDatabase._internal();

//   factory MockDatabase() {
//     return _instance;
//   }

//   MockDatabase._internal();

//   Future<User> login() async {
//     return await Future.delayed(Duration(seconds: 1), () {
//       return User(name: 'Igor');
//     });
//   }

//   Stream<List<Product>> getProductsBatched() async* {
//     List<Product> allProducts = [];

//     var i = 0;
//     while (i < 10) {
//       await Future.delayed(Duration(seconds: 1), () {
//         allProducts.add(_productsInDatabase[i]);
//       });
//       i++;
//       yield allProducts;
//     }
//   }

//   List<Product> _productsInDatabase = [
//     Product(name: 'Carrot', cost: 1.0),
//     Product(name: 'Potatoes', cost: 1.0),
//     Product(name: 'Tomato', cost: 0.5),
//     Product(name: 'Cheese', cost: 1.5),
//     Product(name: 'Beans', cost: 1.5),
//     Product(name: 'Lettuce', cost: 1.5),
//     Product(name: 'Flour', cost: 1.5),
//     Product(name: 'Honey', cost: 1.5),
//     Product(name: 'Chocolate', cost: 1.5),
//     Product(name: 'Asparagus', cost: 1.5),
//     Product(name: 'Bread', cost: 1.5),
//   ];
// }

// void main() async {
//   final user = await MockDatabase().login();

//   runApp(
//     MultiProvider(
//       providers: [
//         Provider<User>.value(value: user),
//         Provider<Store>(create: (_) => Store()),
//         ChangeNotifierProvider<Cart>(create: (_) => Cart()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProductsPage(),
//     );
//   }
// }

// class ProductsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Grocery Store"),
//         actions: <Widget>[
//           Stack(
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.shopping_cart),
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (BuildContext context) {
//                         return CartPage();
//                       },
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 top: 10.0,
//                 left: 10.0,
//                 child: Container(
//                   height: 10.0,
//                   width: 10.0,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: StreamProvider<List<Product>>(
//         initialData: [],
//         create: (_) => Provider.of<Store>(context).allProductsForSale,
//         catchError: (BuildContext context, error) => <Product>[],
//         updateShouldNotify: (List<Product> last, List<Product> next) =>
//             last.length == next.length,
//         builder: (BuildContext context, Widget? child) {
//           final items = context.watch<List<Product>>();
//           return ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (BuildContext context, int index) {
//               if (items.isEmpty) {
//                 return const Text('no products for sale, check back later');
//               }
//               final item = items[index];
//               return ListTile(
//                   leading: const Icon(Icons.add

//                   ),
//                   title: const Text(
//                     'GFG title',
//                     textScaleFactor: 1.5,
//                   ),
//                   trailing: const Icon(Icons.done),
//                   subtitle: const Text('This is subtitle'),
//                   selected: true,
//                   onTap: () {});

//               // ListTile(
//               //   leading: Image.network(
//               //       'https://avatars.mds.yandex.net/i?id=249e36178b607ffd447f43b052d573280e59ce0b-10355097-images-thumbs&n=13'),
//               //   title: Text(item.name),
//               //   subtitle: Text('cost: ${item.cost.toString()}'),
//               //   trailing: const Text('Add to Cart'),

//               //   onTap: () {
//               //     context.read<Cart>().addToCart(item);
//               //   },
//               // );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(context.watch<User>().name + 's Cart'),
//       ),
//       body: Consumer<Cart>(
//         builder: (BuildContext context, Cart cart, Widget? child) {
//           return Column(
//             children: <Widget>[
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: cart.products.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     if (cart.products.isEmpty) {
//                       return Text('no products in cart');
//                     }
//                     final item = cart.products[index];
//                     return ListTile(
//                       leading: Image.network(
//                           'https://avatars.mds.yandex.net/i?id=249e36178b607ffd447f43b052d573280e59ce0b-10355097-images-thumbs&n=13'),
//                       title: Text(item.name),
//                       subtitle: Text('cost: ${item.cost.toString()}'),
//                       trailing: Text('tap to remove from cart'),
//                       onTap: () {
//                         context.read<Cart>().removeFromCart(item);
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Divider(),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   'TOTAL: ${context.select((Cart c) => c.total)}',
//                   style: Theme.of(context).textTheme.displaySmall,
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class MyApps extends StatefulWidget {
//   const MyApps({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApps> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Test App",
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Switch Orientation Mode")),
//         body: OrientationBuilder(builder: (context, orientation) {
//           return Center(
//             child: Builder(
//               builder: (context) {
//                 return SizedBox(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                       image: NetworkImage('https://i.imgur.com/tRqTIdl.gif'),
//                       fit: BoxFit.cover,
//                     )),
//                     child: ListView(
//                       padding: const EdgeInsets.all(8),
//                       scrollDirection: Axis.vertical,
//                       children: <Widget>[
//                         const SizedBox(height: 20.0),
//                         ElevatedButton(
//                           child: const Text("Switch Orientation"),
//                           onPressed: () {
//                             if (MediaQuery.of(context).orientation ==
//                                 Orientation.portrait) {
//                               //if Orientation is portrait then set to landscape mode
//                               SystemChrome.setPreferredOrientations([
//                                 DeviceOrientation.landscapeLeft,
//                                 DeviceOrientation.landscapeRight,
//                               ]);
//                             } else {
//                               //if Orientation is landscape then set to portrait
//                               SystemChrome.setPreferredOrientations([
//                                 DeviceOrientation.portraitDown,
//                                 DeviceOrientation.portraitUp,
//                               ]);
//                             }
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }


// Future<void> _addImageFromGallery([int? index]) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Добавьте выбранное изображение в список продуктов
//       //final imageFile = File(pickedFile.path);
//       //final product = Product(name: 'New Product', cost: 0.0, image: imageFile);

//       _showSnackBar('Изображение добавлено');
//     } else {
//       _showSnackBar('Изображение не выбрано');
//     }
//   }