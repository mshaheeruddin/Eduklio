part of 'student_attendance_tiles_bloc.dart';

@immutable
abstract class StudentAttendanceTilesEvent {}


class ButtonPressedEvent extends StudentAttendanceTilesEvent {
  bool isVerified;
  ButtonPressedEvent(this.isVerified);
}

class UnverifiedEvent extends StudentAttendanceTilesEvent {
  bool isVerified;
  UnverifiedEvent(this.isVerified);
}

class VerifiedEvent extends StudentAttendanceTilesEvent {
  bool isVerified;
 VerifiedEvent(this.isVerified);
}