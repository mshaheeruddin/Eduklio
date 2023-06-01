part of 'add_attendance_bloc.dart';

@immutable
abstract class AddAttendanceState {}

class AddAttendanceInitial extends AddAttendanceState {}

class DateFieldPopulatedState extends AddAttendanceState {
String dateSelected;

  DateFieldPopulatedState(this.dateSelected);
}

class EmptyTextFieldState extends AddAttendanceState {

}

class TextFieldValidState extends AddAttendanceState {

}