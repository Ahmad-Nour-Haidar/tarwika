import '../../core/class/parent_state.dart';

abstract class OrderDetailsState {
  final ParentState state;

  OrderDetailsState(this.state);
}

class OrderDetailsInitialState extends OrderDetailsState {
  OrderDetailsInitialState() : super(NoneState(''));
}

class OrderDetailsLoadingState extends OrderDetailsState {
  OrderDetailsLoadingState() : super(NoneState(''));
}

class OrderDetailsSuccessState extends OrderDetailsState {
  OrderDetailsSuccessState() : super(NoneState(''));
}

class OrderDetailsChangeState extends OrderDetailsState {
  OrderDetailsChangeState() : super(NoneState(''));
}

class OrderDetailsFailureState extends OrderDetailsState {
  OrderDetailsFailureState(super.state);
}
