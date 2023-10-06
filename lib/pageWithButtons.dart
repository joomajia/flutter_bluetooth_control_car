import 'package:faker/faker.dart' show Faker;
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDEE9F9),
        textTheme: const TextTheme(
            displaySmall: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => const NewWidgetLay(),
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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
          color: Colors.red,
        ),
        child: child);
  }
}

class AppBars extends AppBar {
  AppBars({super.key})
      : super(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "this is app bar",
            style: TextStyle(color: Color(0xFFDEE9F9)),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        );
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
      _textSize += 2.0; // Увеличиваем размер текста на 2.0 пункта
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
      appBar: const CustomAppBar(
        height: 200,
        child: Column(
          children: [
            FlutterLogo(size: 56),
            SizedBox(
              height: 100,
              width: 100,
              child: Row(
                children: [
                  Icon(Icons.abc_sharp),
                  SizedBox(
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
              height: 100,
              child: ListView(
                children: <Widget>[
                  SingleChildScrollView(
                    controller: _mycontroller,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        Text(
                          _displayText,
                          style: TextStyle(
                              fontSize: _textSize, color: Colors.amber),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _decreaseTextSize();
                            _showSnackBar(context, 'Текст уменьшен');
                          },
                          child: const Text('Уменьшить текст'),
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _resetTextSize();
                            _showSnackBar(context, 'Размер сброшен');
                          },
                          child: const Text('Сбросить размер'),
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _increaseTextSize();
                            _showSnackBar(context, 'Текст увеличен');
                          },
                          child: const Text('Увеличить текст'),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _generateRandomText();
                            _showSnackBar(
                                context, 'Сгенерирован случайный текст');
                          },
                          child: const Text('Случайный текст'),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _nullText();
                            _showSnackBar(context, 'Текст сброшен');
                          },
                          child: const Text('Сбросить текст'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                ],
              )),
          Container(
            height: 100,
            width: 100,
            color: Colors.black,
            child: Text(
              _displayText,
              style: TextStyle(fontSize: _textSize, color: Colors.amber),
            ),
          )
        ],
      ),
    );
  }
}
