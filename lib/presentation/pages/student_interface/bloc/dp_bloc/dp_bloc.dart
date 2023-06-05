import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/enroll_bloc/enroll_bloc.dart';
import 'package:meta/meta.dart';

part 'dp_event.dart';
part 'dp_state.dart';

class DpBloc extends Bloc<DpEvent, DpState> {
  DpBloc() : super(DpInitial()) {
    on<DpSelectedEvent>((event, emit) {
      emit(DpShowState(event.imageUrl));
    });

    on<DpUploadingEvent>((event, emit) {
      log("EVENT SAYING: ${event.imageUrl}");
      emit(DpUploadingState(event.imageUrl));
    });

  }
}
