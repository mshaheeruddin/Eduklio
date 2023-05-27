part of 'text_field_announce_bloc.dart';

@immutable
abstract class TextFieldAnnounceEvent {}

class TextFieldChangedEvent extends TextFieldAnnounceEvent {
  late final String announceStatement;

  TextFieldChangedEvent(this.announceStatement);

}