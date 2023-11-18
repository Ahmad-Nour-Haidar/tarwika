import '../../core/class/parent_state.dart';

abstract class MyOrderState {}

class MyOrderInitialState extends MyOrderState {}

class MyOrderLoadingState extends MyOrderState {}

class MyOrderSuccessState extends MyOrderState {}

class MyOrderFailureState extends MyOrderState {
  final ParentState state;

  MyOrderFailureState(this.state);
}
