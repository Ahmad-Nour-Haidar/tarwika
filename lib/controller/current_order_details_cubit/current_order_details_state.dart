import '../../core/class/parent_state.dart';

abstract class CurrentOrderDetailsState {
  final ParentState state;

  CurrentOrderDetailsState(this.state);
}

class CurrentOrderDetailsInitialState extends CurrentOrderDetailsState {
  CurrentOrderDetailsInitialState() : super(NoneState(''));
}

class CurrentOrderDetailsLoadingState extends CurrentOrderDetailsState {
  CurrentOrderDetailsLoadingState() : super(NoneState(''));
}

class CurrentOrderDetailsSuccessState extends CurrentOrderDetailsState {
  CurrentOrderDetailsSuccessState(super.state);
}

class CurrentOrderDetailsChangeState extends CurrentOrderDetailsState {
  CurrentOrderDetailsChangeState() : super(NoneState(''));
}

class CurrentOrderDetailsFailureState extends CurrentOrderDetailsState {
  CurrentOrderDetailsFailureState(super.state);
}
