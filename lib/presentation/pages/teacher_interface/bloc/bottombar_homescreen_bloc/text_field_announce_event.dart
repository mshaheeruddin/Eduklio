part of 'text_field_announce_bloc.dart';

abstract class TextFieldAnnounceEvent {}

class TextFieldChangedEvent extends TextFieldAnnounceEvent {
  final String announceStatement;
  TextFieldChangedEvent(this.announceStatement);
}

