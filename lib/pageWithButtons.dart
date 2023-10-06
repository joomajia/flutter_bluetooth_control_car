import 'package:faker/faker.dart';
import 'package:flut_labs/pageWithList.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(220, 124, 72, 1.000),
        textTheme: const TextTheme(
            displaySmall: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        // primarySwatch: Color.fromARGB(255, 155, 131, 57),
      ),
      routes: {
        '/': (context) => const NewWidgetLay(),
        '/pageWithList': (context) => const PageWithList(),
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // appbar custom
  final Widget child;
  final double height;

  const CustomAppBar({
    super.key,
    required this.child,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: preferredSize.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color.fromRGBO(252, 204, 140, 1.000),
        ),
        child: child);
  }
}

// class AppBars extends AppBar {
//   AppBars({super.key})
//       : super(
//           iconTheme: const IconThemeData(
//             color: Colors.black, //change your color here
//           ),
//           backgroundColor: Colors.white,
//           title: const Text(
//             "this is app bar",
//             style: TextStyle(color: Color(0xFFDEE9F9)),
//           ),
//           elevation: 0.0,
//           automaticallyImplyLeading: false,
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.notifications),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(Icons.person),
//               onPressed: () {},
//             ),
//           ],
//         );
// }

class CustomElevatedButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomElevatedButton(
      {super.key, required this.label, required this.onPressed});

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(180, 40),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          backgroundColor: Color.fromRGBO(94, 147, 156, 1.000),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      onPressed: widget.onPressed,
      child: Text(widget.label),
    );
  }
}

class NewWidgetLay extends StatefulWidget {
  const NewWidgetLay({super.key});

  @override
  State<NewWidgetLay> createState() => _NewWidgetLayState();
}

class _NewWidgetLayState extends State<NewWidgetLay> {
  double _textSize = 16.0; // Начальный размер текста
  String _displayText = 'Пример текста'; // Начальный текст

  void _increaseTextSize() {
    setState(() {
      _textSize += 2.0;
    });
  }

  void _decreaseTextSize() {
    setState(() {
      _textSize -= 2.0; // Уменьшаем размер текста на 2.0 пункта
    });
  }

  void _resetTextSize() {
    setState(() {
      _textSize = 16.0; // Сбрасываем размер текста до начального значения
    });
  }

  void _generateRandomText() {
    final faker = Faker();
    setState(() {
      _displayText = faker.lorem.sentence(); // Генерируем случайный текст
    });
  }

  void _nullText() {
    setState(() {
      _displayText = ""; // Генерируем случайный текст
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(
            milliseconds: 400), // Длительность отображения подсказки
      ),
    );
  }

  final ScrollController _mycontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            const FlutterLogo(size: 56),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(43, 90, 92, 1.000),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const PageWithList())),
                      splashColor: Colors.yellowAccent,
                      splashRadius: 50,
                      highlightColor: Colors.black,
                      icon: Icon(Icons.code),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const PageWithList())),
                      splashColor: Colors.yellowAccent,
                      splashRadius: 50,
                      highlightColor: Colors.black,
                      icon: Icon(Icons.code),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView(
                children: <Widget>[
                  SingleChildScrollView(
                    controller: _mycontroller,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Text(
                            _displayText,
                            style: TextStyle(
                                fontSize: _textSize,
                                color: const Color.fromRGBO(43, 90, 92, 1.000)),
                          ),
                        ),

                        CustomElevatedButton(
                          onPressed: () {
                            if (_textSize < 10) {
                              _showSnackBar(context, 'Минимальный размер');
                            } else {
                              _decreaseTextSize();
                              _showSnackBar(context, 'Текст уменьшен');
                            }
                          },
                          label: 'Уменьшить текст',
                        ),
                        const SizedBox(width: 20.0),
                        CustomElevatedButton(
                            label: 'Сбросить размер',
                            onPressed: () {
                              _resetTextSize();
                              _showSnackBar(context, 'Размер сброшен');
                            }),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     _resetTextSize();
                        //     _showSnackBar(context, 'Размер сброшен');
                        //   },
                        //   child: const Text('Сбросить размер'),
                        // ),

                        const SizedBox(width: 20.0),
                        CustomElevatedButton(
                            label: 'Увеличить текст',
                            onPressed: () {
                              if (_textSize > 24) {
                                _showSnackBar(context, 'Максимальный размер');
                              } else {
                                _increaseTextSize();
                                _showSnackBar(context, 'Текст увеличен');
                              }
                            }),

                        const SizedBox(width: 20.0),
                        CustomElevatedButton(
                            label: 'Случайный текст',
                            onPressed: () {
                              _generateRandomText();
                              _showSnackBar(
                                  context, 'Сгенерирован случайный текст');
                            }),

                        const SizedBox(width: 20.0),
                        CustomElevatedButton(
                            label: 'Сбросить текст',
                            onPressed: () {
                              _nullText();
                              _showSnackBar(context, 'Текст сброшен');
                            }),
                      ],
                    ),
                  ),
                ],
              )),
          // Container(
          //   height: 100,
          //   width: 100,
          //   color: Colors.black,
          //   child: Text(
          //     _displayText,
          //     style: TextStyle(fontSize: _textSize, color: Colors.amber),
          //   ),
          // )
        ],
      ),
    );
  }
}
