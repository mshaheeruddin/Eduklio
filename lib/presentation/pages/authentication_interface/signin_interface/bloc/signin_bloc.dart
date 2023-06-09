import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigninEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<EmptySignInFieldEvent>((event, emit) {
      if (event.email == "" || event.password == "") {
        emit(SigninInvalidState("Please fill all fields!"));
      }
      else {
        emit(SigninValidState());
      }
    });
  }
}
