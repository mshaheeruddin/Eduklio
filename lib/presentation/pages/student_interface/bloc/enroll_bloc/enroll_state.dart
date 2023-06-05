part of 'enroll_bloc.dart';

@immutable
abstract class EnrollState {}

class EnrollInitial extends EnrollState {}

class EnrollDialogueBoxLaunchState extends EnrollState {}


class DialogueBoxOpenState extends EnrollState {
  bool isClicked;
  DialogueBoxOpenState(this.isClicked);
}


class EnrollSubjectedSelectedState extends EnrollState {
  String selectedValue;
  EnrollSubjectedSelectedState(this.selectedValue);
}

class EnrollTeacherSelectedState extends EnrollState {
  String selectedValue;
  EnrollTeacherSelectedState(this.selectedValue);
}

class EnrollButtonPressedState extends EnrollState {
  String subjectSelected;
  String teacherSelected;
  EnrollButtonPressedState(this.subjectSelected, this.teacherSelected);
}