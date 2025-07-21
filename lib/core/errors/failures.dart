import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
} 