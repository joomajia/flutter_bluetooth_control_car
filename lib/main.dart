// ignore_for_file: library_private_types_in_public_api

import 'package:flut_labs/pageWithButtons.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

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
