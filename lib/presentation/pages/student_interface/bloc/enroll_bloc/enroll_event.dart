part of 'enroll_bloc.dart';

@immutable
abstract class EnrollEvent {}

class EnrollClickedEvent extends EnrollEvent{
  bool isClicked = false;
  EnrollClickedEvent(this.isClicked);
}
class EnrollSubjectSelectionEvent extends EnrollEvent{
  bool isClicked = false;
  String selectedValue;
  EnrollSubjectSelectionEvent(this.isClicked, this.selectedValue);
}

class EnrollTeacherSelectionEvent extends EnrollEvent{
  bool isClicked = false;
  String selectedValue;
  EnrollTeacherSelectionEvent(this.isClicked, this.selectedValue);
}


class EnrollButtonPressedEvent extends EnrollEvent{
  bool isClicked = false;
  String subjectSelected;
  String teacherSelected;
  EnrollButtonPressedEvent(this.isClicked, this.subjectSelected, this.teacherSelected);
}