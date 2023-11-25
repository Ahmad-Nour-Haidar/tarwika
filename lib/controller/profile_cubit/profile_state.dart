import 'package:tarwika/core/class/parent_state.dart';

abstract class ProfileState {
  final ParentState state;

  ProfileState(this.state);
}

class ProfileInitialState extends ProfileState {
  ProfileInitialState() : super(NoneState(''));
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super(NoneState(''));
}

class ProfileSuccessState extends ProfileState {
  ProfileSuccessState(super.state);
}

class ProfileFailureState extends ProfileState {
  ProfileFailureState(super.state);
}

class ProfileChangeState extends ProfileState {
  ProfileChangeState() : super(NoneState(''));
}
