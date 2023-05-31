part of 'movement_bloc.dart';

@immutable
abstract class MovementState {}

class MovementInitial extends MovementState {

}

class GoDownState extends MovementState {
  double position;
  GoDownState(this.position);
}