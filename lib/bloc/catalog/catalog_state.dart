import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppies/bloc/catalog/bloc.dart';
import 'package:shoppies/data/model/catalog.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();
  @override
  List<Object> get props => [];
}

class CatalogEmpty extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoadSuccess extends CatalogState {
  final List<Catalog> catalogItems;

  CatalogLoadSuccess({@required this.catalogItems});
  @override
  List<Object> get props => [this.catalogItems];
}

class CatalogLoadFailed extends CatalogState {
  final String errorCode;
  final String errorMessage;
  CatalogLoadFailed({@required this.errorCode, @required this.errorMessage});
  @override
  List<Object> get props => [this.errorCode, this.errorMessage];
}
