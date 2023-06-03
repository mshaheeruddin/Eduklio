part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}
class SignupScreenStartEvent extends SigninEvent{
}


class EmptySignInFieldEvent extends SigninEvent {

  String email;
  String password;

  EmptySignInFieldEvent(this.email,this.password);
}