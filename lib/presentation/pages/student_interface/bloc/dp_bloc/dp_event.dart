part of 'dp_bloc.dart';

@immutable
abstract class DpEvent {}

class DpUpdatedEvent extends DpEvent {

}
class DpSelectedEvent extends DpEvent {
bool isSelected;
String imageUrl;

DpSelectedEvent(this.isSelected, this.imageUrl);
}

class DpUploadingEvent extends DpEvent {
  bool isSelected;
  String imageUrl;
  DpUploadingEvent(this.isSelected, this.imageUrl);

}

class DpUploadedEvent extends DpEvent {

}

