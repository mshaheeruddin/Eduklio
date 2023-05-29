import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'enroll_event.dart';
part 'enroll_state.dart';

class EnrollBloc extends Bloc<EnrollEvent, EnrollState> {
  EnrollBloc() : super(EnrollInitial()) {
    on<EnrollClickedEvent>((event, emit) {
      if (event.isClicked == true) {
        emit(EnrollDialogueBoxLaunchState());
      }
    });
    on<EnrollSubjectSelectionEvent>((event, emit) {
        if (event.isClicked == true) {
          emit(EnrollSubjectedSelectedState(event.selectedValue));
        }
    });
    on<EnrollTeacherSelectionEvent>((event, emit) {
      if (event.isClicked == true) {
        emit(EnrollTeacherSelectedState(event.selectedValue));
      }
    });
    on<EnrollButtonPressedEvent>((event, emit) {
      if (event.isClicked == true) {
        emit(EnrollButtonPressedState(event.subjectSelected, event.teacherSelected));
      }
    });

  }
}
