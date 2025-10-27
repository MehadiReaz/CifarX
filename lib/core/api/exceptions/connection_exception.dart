import 'package:equatable/equatable.dart';

class ConnectionException extends Equatable implements Exception {
  final String message;

  const ConnectionException(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ConnectionException: $message';
}
