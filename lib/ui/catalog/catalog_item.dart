import 'package:flutter/material.dart';

class CatalogItem extends StatelessWidget {
  final String price;
  final String item;

  const CatalogItem({Key key, @required this.item, @required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: Image.network("http://placehold.it/50/50")),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$item",
                  style: TextStyle(fontSize: 25.0, color: Colors.black54),
                ),
                Text(
                  "Rp.$price",
                  style: TextStyle(fontSize: 20.0, color: Colors.black38),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}
