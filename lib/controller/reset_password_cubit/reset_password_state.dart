import '../../core/class/parent_state.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {}

class ResetPasswordFailureState extends ResetPasswordState {
  final ParentState state;

  ResetPasswordFailureState(this.state);
}

class ResetPasswordChangeShowPasswordState extends ResetPasswordState {}

class ResetPasswordNotVerifyState extends ResetPasswordState {}
