part of 'add_attendance_bloc.dart';

@immutable
abstract class AddAttendanceEvent {}

class DateSelectedEvent extends AddAttendanceEvent {
  String selectedDate;
  DateSelectedEvent(this.selectedDate);
}

class EmptyFieldEvent extends AddAttendanceEvent {
  String subjectName;
  String studentName;
  String dateField;
  EmptyFieldEvent(this.subjectName, this.studentName, this.dateField);
}
