part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class GenderShowingState extends SignupState {
  String gender;
  GenderShowingState(this.gender);
}

class SignupInvalidState extends SignupState {
  String error;
  SignupInvalidState(this.error);
}

class SignupValidState extends SignupState {

}