import 'package:tarwika/core/class/parent_state.dart';

abstract class FavoriteScreenState {}

class FavoriteScreenInitialState extends FavoriteScreenState {}

class FavoriteScreenLoadingState extends FavoriteScreenState {}

class FavoriteScreenSuccessState extends FavoriteScreenState {}

class FavoriteScreenFailureState extends FavoriteScreenState {
  final ParentState state;

  FavoriteScreenFailureState(this.state);
}
