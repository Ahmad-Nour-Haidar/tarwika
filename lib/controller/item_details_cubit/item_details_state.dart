import 'package:tarwika/core/class/parent_state.dart';

abstract class ItemDetailsState {
  final ParentState state;

  ItemDetailsState(this.state);
}

class ItemDetailsInitialState extends ItemDetailsState {
  ItemDetailsInitialState(super.state);
}

class ItemDetailsLoadingState extends ItemDetailsState {
  ItemDetailsLoadingState() : super(NoneState(''));
}

class ItemDetailsLoadingDataState extends ItemDetailsState {
  ItemDetailsLoadingDataState(super.state);
}

class ItemDetailsSuccessState extends ItemDetailsState {
  ItemDetailsSuccessState(super.state);
}

class ItemDetailsStoreSuccessState extends ItemDetailsState {
  ItemDetailsStoreSuccessState(super.state);
}

class ItemDetailsFailureState extends ItemDetailsState {
  ItemDetailsFailureState(super.state);
}

class ItemDetailsChangeState extends ItemDetailsState {
  ItemDetailsChangeState(super.state);
}
