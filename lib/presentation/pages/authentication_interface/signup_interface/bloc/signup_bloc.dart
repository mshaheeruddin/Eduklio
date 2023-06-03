import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupScreenStartEvent>((event, emit) {
      emit(SignupInitial());
    });
    on<GenderSelectedEvent>((event, emit) {
      emit(GenderShowingState(event.gender));
    });
    on<EmptyFieldEvent>((event, emit) {
      if (event.firstName == "" || event.lastName == "" || event.email == ""|| event.password == ""|| event.confirmPassword == "" || event.schoolName == ""|| event.gender == "" || event.gender == "Choose gender" || event.yearsOfTeachingExp == "" || event.qualification == "" ) {
           emit(SignupInvalidState("Please fill all fields!"));
      }
      else {
        emit(SignupValidState());
      }
    });
  }
}
