part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}
class SigninInvalidState extends SigninState {
  String error;
  SigninInvalidState(this.error);
}

class SigninValidState extends SigninState {

}