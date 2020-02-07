import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppies/bloc/auth/bloc.dart';
import 'package:shoppies/bloc/catalog/bloc.dart';
import 'package:shoppies/ui/catalog/catalog_empty_list.dart';
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
          Navigator.of(context).pushReplacementNamed("login");
        }
      },
      child: Scaffold(
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
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: Text("Log out"),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(SignedOut());
                  },
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Product Catalog",
                  style: theme.textTheme.display1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: BlocBuilder<CatalogBloc, CatalogState>(
                        builder: (context, state) {
                          if (state is CatalogLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is CatalogLoadSuccess) {
                            return ListView(
                              children: state.catalogItems
                                  .map<Widget>((catalog) => _buildCatalogItem(
                                      context,
                                      catalog.name,
                                      catalog.price.toStringAsPrecision(2)))
                                  .toList(),
                            );
                          }
                          return CatalogEmptyList();
                        },
                      ),
                    ),
                  ],
                ),
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
