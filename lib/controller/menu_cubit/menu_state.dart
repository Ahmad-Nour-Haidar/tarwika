import 'package:tarwika/core/class/parent_state.dart';

import '../../model/item_model.dart';

abstract class MenuState {}

class MenuInitialState extends MenuState {}

class MenuLoadingState extends MenuState {}

class MenuSuccessState extends MenuState {}

class MenuFailureState extends MenuState {
  final ParentState state;

  MenuFailureState(this.state);
}

class MenuChangeState extends MenuState {}

// category
class MenuLoadingCategoryState extends MenuState {}

class MenuSuccessCategoryState extends MenuState {}

class MenuFailureCategoryState extends MenuState {}

// item
class MenuLoadingItemState extends MenuState {}

class MenuSuccessItemState extends MenuState {}

class MenuFailureItemState extends MenuState {}

// search
abstract class SearchState extends MenuState {}

class OpenSearchState extends SearchState {}

class CloseSearchState extends SearchState {}

class LoadingSearchState extends SearchState {}

class SuccessSearchState extends SearchState {
  final List<ItemModel> data;
  final String value;

  SuccessSearchState(this.data, this.value);
}

class FailureSearchState extends MenuState {
  final ParentState state;

  FailureSearchState(this.state);
}
