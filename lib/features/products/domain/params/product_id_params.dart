import 'package:equatable/equatable.dart';

class ProductIdParams extends Equatable {
  final int id;

  const ProductIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}
