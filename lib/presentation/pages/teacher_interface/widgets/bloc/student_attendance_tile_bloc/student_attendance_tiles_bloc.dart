import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'student_attendance_tiles_event.dart';
part 'student_attendance_tiles_state.dart';

class StudentAttendanceTilesBloc extends Bloc<StudentAttendanceTilesEvent, StudentAttendanceTilesState> {
  StudentAttendanceTilesBloc() : super(StudentAttendanceTilesInitial()) {
    on<ButtonPressedEvent>((event, emit) {
      if(event.isVerified) {
        emit(VerifiedState(event.isVerified));
      }
      else {
        emit(UnverifiedState(event.isVerified));
      }
    });

  }
}
