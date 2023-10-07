import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Image.network(
            'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/1502591/cabbage-clipart-md.png',
            height: 100,
          ),
          const Align(
            child: Text(
              "Cabbages",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: 4,
          ),
          const Row(
            children: [
              Text("\$5.5",
                  style: TextStyle(fontSize: 12, color: Colors.amber)),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  "per piece",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: Colors.amber),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PageWithList extends StatelessWidget {
  const PageWithList({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = [
      'bike',
      'boat',
      'bus',
      'car',
      'railway',
      'run',
      'subway',
      'transit',
      'car',
      'railway',
      'run',
      'subway',
      'transit',
      'walk'
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 144, 146, 144),
        title: const Text('New Screen'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ItemCard(
          
        ),
        itemCount: titles.length,
        scrollDirection: Axis.horizontal,
      ),
      // ListView.builder(
      //     itemCount: titles.length,
      //     itemBuilder: (context, index) {
      //       return Card(
      //         elevation: 4,
      //         margin: EdgeInsets.all(10),
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10)),
      //         child: Container(
      //           margin: EdgeInsets.all(40),
      //           height: 100,
      //           decoration: BoxDecoration(
      //             borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      //             image: DecorationImage(
      //               image: NetworkImage(
      //                   'https://avatars.mds.yandex.net/i?id=249e36178b607ffd447f43b052d573280e59ce0b-10355097-images-thumbs&n=13'),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //           child: ListTile(
      //             leading: Image.network(
      //                 'https://avatars.mds.yandex.net/i?id=249e36178b607ffd447f43b052d573280e59ce0b-10355097-images-thumbs&n=13'),
      //             title: Text('Title', style: TextStyle(fontSize: 20)),
      //             subtitle: Text('Subtitle', style: TextStyle(fontSize: 16)),
      //             trailing: Icon(Icons.arrow_forward),
      //             contentPadding:
      //                 EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //             dense: true,
      //           ),
      //         ),
      //       );
      //     }),
    );
  }
}

// return Card(
//   child: ListTile(
//     title: Text(titles[index]),
//     leading: const Icon(Icons.access_alarm),
//   ),
// );

// class ItemList extends StatelessWidget {
//   final List<ProductItem> items;

//   const ItemList(this.items, {required Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 156,
//       child: ListView.builder(
//         itemBuilder: (context, index) => ItemCard(
//           item: items[index],
//         ),
//         itemCount: items.length,
//         scrollDirection: Axis.horizontal,
//       ),
//     );
//   }
// }
