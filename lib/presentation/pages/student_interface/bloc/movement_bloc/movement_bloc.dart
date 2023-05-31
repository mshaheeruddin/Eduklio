import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'movement_event.dart';
part 'movement_state.dart';

class MovementBloc extends Bloc<MovementEvent, MovementState> {
  MovementBloc() : super(MovementInitial()) {
    on<ClickedOnEnrollEvent>((event, emit) {
      log(event.isClicked.toString());
      if(event.isClicked) {
        log(event.isClicked.toString());
        //final newPosition = event.position == 0 ? 100.0 : 0.0;

         double newPosition = event.position + 100;

        emit(GoDownState(newPosition));
      }
    });
  }
}
