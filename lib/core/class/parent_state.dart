abstract class ParentState {
  final String message;

  ParentState({this.message = ''});
}

class OfflineState extends ParentState {
  OfflineState(String message) : super(message: message);
}

class ServerFailureState extends ParentState {
  ServerFailureState(String message) : super(message: message);
}

class FailureState extends ParentState {
  FailureState(String message) : super(message: message);
}

class NoneState extends ParentState {
  NoneState(String message) : super(message: message);
}

class SuccessState extends ParentState {
  SuccessState(String message) : super(message: message);
}
