import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory ApiException.fromResponse({
    required int statusCode,
    required String message,
    dynamic data,
  }) {
    return ApiException(
      statusCode: statusCode,
      message: message,
      data: data,
    );
  }

  @override
  List<Object?> get props => [message, statusCode, data];

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
