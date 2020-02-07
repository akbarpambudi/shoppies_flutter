import 'package:equatable/equatable.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  List<Object> get props => [];
}

class LoadCatalogStarted extends CatalogEvent {}
