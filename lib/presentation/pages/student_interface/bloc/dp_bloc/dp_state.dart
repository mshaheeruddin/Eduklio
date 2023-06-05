part of 'dp_bloc.dart';

@immutable
abstract class DpState {}

class DpInitial extends DpState {}


class DpShowState extends DpState {
   String imageUrl;
   DpShowState(this.imageUrl);
}

class DpUploadingState extends DpState {
   String imageUrl;
   DpUploadingState(this.imageUrl);
}
class SubmittingState extends EnrollState {
   String selectedValue;
   SubmittingState(this.selectedValue);
}