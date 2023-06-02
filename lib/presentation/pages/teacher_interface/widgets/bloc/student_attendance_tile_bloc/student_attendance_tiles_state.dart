part of 'student_attendance_tiles_bloc.dart';

@immutable
abstract class StudentAttendanceTilesState {}

class StudentAttendanceTilesInitial extends StudentAttendanceTilesState {}


class UnverifiedState extends StudentAttendanceTilesState {
    bool isVerified;
    UnverifiedState(this.isVerified);
}

class VerifiedState extends StudentAttendanceTilesState {
  bool isVerified;
  VerifiedState(this.isVerified);
}