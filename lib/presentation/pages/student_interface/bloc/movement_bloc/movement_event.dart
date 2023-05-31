part of 'movement_bloc.dart';

@immutable
abstract class MovementEvent {}

class ClickedOnEnrollEvent extends MovementEvent{
  bool isClicked;
  double position;
  ClickedOnEnrollEvent(this.isClicked, this.position);
}
