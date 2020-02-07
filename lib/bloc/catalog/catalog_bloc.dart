import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shoppies/data/model/catalog.dart';
import './bloc.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  @override
  CatalogState get initialState => CatalogEmpty();

  @override
  Stream<CatalogState> mapEventToState(
    CatalogEvent event,
  ) async* {
    if (event is LoadCatalogStarted) {
      yield CatalogLoading();
      List<Catalog> catalogues = [];
      for (var i = 0; i < 100; i++) {
        catalogues.add(Catalog(
            "xx1", "Product $i", "http://placehold.it/50/50", 10000, 10));
      }
      yield CatalogLoadSuccess(catalogItems: catalogues);
    }
  }
}
