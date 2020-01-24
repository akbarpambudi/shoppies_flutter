import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppies/bloc/auth/bloc.dart';
import 'package:shoppies/ui/catalog/catalog_item.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.of(context).pushNamed("/");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(new SignedOut());
              },
            )
          ],
        ),
        body: _buildCatalogBody(theme, context),
      ),
    );
  }

  Container _buildCatalogBody(ThemeData theme, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: theme.primaryColor),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Center(
              child: Text(
                "Product Catalog",
                style: theme.textTheme.display1
                    .copyWith(color: theme.primaryColorLight),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: <Widget>[
                        _buildCatalogItem(context, "HHM-Cloth", "32.000,00"),
                        _buildCatalogItem(context, "Baju Anak", "14.000,00"),
                        _buildCatalogItem(context, "Baju Ibu", "15.000,00"),
                        _buildCatalogItem(context, "Baju ku", "15.000,00")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildCatalogItem(BuildContext context, String item, String price) {
    return CatalogItem(
      item: item,
      price: price,
    );
  }
}
