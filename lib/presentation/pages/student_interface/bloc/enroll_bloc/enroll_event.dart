part of 'enroll_bloc.dart';

@immutable
abstract class EnrollEvent {}

class EnrollClickedEvent extends EnrollEvent{
  bool isClicked = false;
  EnrollClickedEvent(this.isClicked);
}
class EnrollSubjectSelectionEvent extends EnrollEvent{
  String selectedValue;
  EnrollSubjectSelectionEvent(this.selectedValue);
}

class SubmittingEvent extends EnrollEvent {
  String selectedValue;
  SubmittingEvent(this.selectedValue);
}

class EnrollTeacherSelectionEvent extends EnrollEvent{
  String selectedValue;
  EnrollTeacherSelectionEvent(this.selectedValue);
}


class EnrollButtonPressedEvent extends EnrollEvent{
  bool isClicked = false;
  String subjectSelected;
  String teacherSelected;
  EnrollButtonPressedEvent(this.isClicked, this.subjectSelected, this.teacherSelected);
}