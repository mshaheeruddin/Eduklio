import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_attendance_event.dart';
part 'add_attendance_state.dart';

class AddAttendanceBloc extends Bloc<AddAttendanceEvent, AddAttendanceState> {
  AddAttendanceBloc() : super(AddAttendanceInitial()) {
    on<DateSelectedEvent>((event, emit) {
      emit(DateFieldPopulatedState(event.selectedDate));
    });
    on<EmptyFieldEvent>((event, emit) {
      if(event.studentName == "" || event.subjectName == "" || event.dateField == "") {
        emit(EmptyTextFieldState());
      }
      else {
        emit(TextFieldValidState());
      }
    });
  }


}
