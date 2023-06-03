part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupScreenStartEvent extends SignupEvent{
}

class GenderSelectedEvent extends SignupEvent {
String gender;
GenderSelectedEvent(this.gender);
}

class EmptyFieldEvent extends SignupEvent {
   String firstName;
   String lastName;
   String email;
   String password;
   String confirmPassword;
   String schoolName;
   String gender;
   String yearsOfTeachingExp;
   String qualification;
   EmptyFieldEvent(this.firstName,this.lastName,this.email,this.password,this.confirmPassword,this.schoolName, this.gender, this.yearsOfTeachingExp,this.qualification);
}