import 'package:equatable/equatable.dart';

/// A normalized, presentable error.
///
/// Repositories/use cases convert exceptions (Dio errors, parse errors,
/// platform exceptions) into a [Failure] so the presentation layer never
/// has to know about transport-level types. Pair with `Result<T, Failure>`
/// from the `multiple_result` package.
class Failure extends Equatable implements Exception {
  /// Human-readable message safe to surface in the UI.
  final String message;

  /// HTTP status code when the failure originated from a response.
  final int? statusCode;

  /// Machine-readable error identifier emitted by the backend
  /// (e.g. `INVALID_CREDENTIALS`). Branch on this instead of matching
  /// [message] strings.
  final String? code;

  /// True when caused by connectivity / timeout rather than a server error.
  final bool isNetworkError;

  final StackTrace? stackTrace;

  const Failure({
    this.message = 'Something went wrong. Please try again.',
    this.statusCode,
    this.code,
    this.isNetworkError = false,
    this.stackTrace,
  });

  /// A connectivity failure with a friendly default message.
  const Failure.network([String? message])
      : message = message ?? 'No internet connection.',
        statusCode = null,
        code = null,
        isNetworkError = true,
        stackTrace = null;

  String messageOr(String fallback) => message.isEmpty ? fallback : message;

  @override
  List<Object?> get props =>
      [message, statusCode, code, isNetworkError];

  @override
  String toString() => 'Failure(code: $code, status: $statusCode, "$message")';
}
