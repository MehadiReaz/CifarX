import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BaseEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, createdAt, updatedAt];
}
