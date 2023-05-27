part of 'text_field_announce_bloc.dart';


abstract class TextFieldAnnounceState {}

class TextFieldAnnounceInitial extends TextFieldAnnounceState {}
class TextFieldEmptyState extends TextFieldAnnounceState {
  final String errorMessage;
  TextFieldEmptyState(this.errorMessage);
}
class TextFieldValidState extends TextFieldAnnounceState {
  TextFieldValidState();
}