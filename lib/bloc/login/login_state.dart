// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final AuthResponseModel model;
  LoginLoaded({
    required this.model,
  });
}

class LoginError extends LoginState {}
