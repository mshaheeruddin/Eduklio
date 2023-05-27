import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'text_field_announce_event.dart';
part 'text_field_announce_state.dart';

class TextFieldAnnounceBloc extends Bloc<TextFieldAnnounceEvent, TextFieldAnnounceState> {
  TextFieldAnnounceBloc() : super(TextFieldAnnounceInitial()) {
    on<TextFieldChangedEvent>((event, emit) {
      if (event.announceStatement == "") {
        emit(TextFieldAnnounceEmpty("ERROR: No field can be left empty"));
      }
    });
  }
}
