part of 'text_field_announce_bloc.dart';

@immutable
abstract class TextFieldAnnounceState {}

class TextFieldAnnounceInitial extends TextFieldAnnounceState {}
class TextFieldAnnounceEmpty extends TextFieldAnnounceState {
  late final String errorMessage;
  TextFieldAnnounceEmpty(this.errorMessage);
}
