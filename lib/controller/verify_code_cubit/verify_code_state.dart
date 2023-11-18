import '../../core/class/parent_state.dart';

abstract class VerifyCodeState {}

class VerifyCodeInitialState extends VerifyCodeState {}

class VerifyCodeLoadingState extends VerifyCodeState {}

class VerifyCodeSuccessState extends VerifyCodeState {}

class VerifyCodeFailureState extends VerifyCodeState {
  final ParentState state;

  VerifyCodeFailureState(this.state);
}
