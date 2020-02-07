import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppies/bloc/catalog/bloc.dart';

class CatalogEmptyList extends StatelessWidget {
  const CatalogEmptyList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "no item found :(",
            style: TextStyle(fontSize: 30.0),
          ),
          MaterialButton(
            onPressed: () {
              BlocProvider.of<CatalogBloc>(context).add(LoadCatalogStarted());
            },
            child: Text("Re-load"),
          )
        ],
      ),
    );
  }
}
