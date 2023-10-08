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
        scaffoldBackgroundColor: Color.fromARGB(255, 46, 46, 46),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color.fromRGBO(163, 163, 162, 1)),
        textTheme: const TextTheme(
            displaySmall: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        // primarySwatch: Color.fromARGB(255, 155, 131, 57),
      ),
      routes: {
        '/': (context) => const NewWidgetLay(),
        '/pageWithList': (context) => PageWithList(),
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
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(20),
          //   bottomRight: Radius.circular(20),
          // ),
          color: Color.fromRGBO(155, 155, 155, 1),
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
          backgroundColor: Color.fromARGB(255, 129, 133, 134),
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
  double _textSize = 16.0;
  String _displayText = 'Пример текста';

  void _increaseTextSize() {
    setState(() {
      _textSize += 2.0;
    });
  }

  void _decreaseTextSize() {
    setState(() {
      _textSize -= 2.0;
    });
  }

  void _resetTextSize() {
    setState(() {
      _textSize = 16.0;
    });
  }

  void _generateRandomText() {
    final faker = Faker();
    setState(() {
      _displayText = faker.lorem.sentence();
    });
  }

  void _nullText() {
    setState(() {
      _displayText = "";
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  final ScrollController _mycontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(114, 117, 117, 1),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PageWithList())),
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
                              builder: (context) => PageWithList())),
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
                              builder: (context) => PageWithList())),
                      splashColor: Colors.yellowAccent,
                      splashRadius: 50,
                      highlightColor: Colors.black,
                      icon: Icon(Icons.code),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
          //give me back my i9mage
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //       image: NetworkImage('https://i.imgur.com/tRqTIdl.gif'),
          //       fit: BoxFit.cover),
          // ),
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView(
            children: <Widget>[
              SingleChildScrollView(
                controller: _mycontroller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: Text(
                        _displayText,
                        style: TextStyle(
                            fontSize: _textSize,
                            color: Color.fromARGB(255, 230, 230, 230)),
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
                    CustomElevatedButton(
                        label: 'Сбросить размер',
                        onPressed: () {
                          _resetTextSize();
                          _showSnackBar(context, 'Размер сброшен');
                        }),
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
                    CustomElevatedButton(
                        label: 'Случайный текст',
                        onPressed: () {
                          _generateRandomText();
                          _showSnackBar(
                              context, 'Сгенерирован случайный текст');
                        }),
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
    );
  }
}
