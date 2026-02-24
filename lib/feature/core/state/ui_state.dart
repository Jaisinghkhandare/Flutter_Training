abstract class UiState<T> {
  String get message => "ini";
}

class Initial<T> extends UiState<T> {}

class Loading<T> extends UiState<T> {}
class Success<T> extends UiState<T> {
  final T data;
  Success(this.data);
}

class Error<T> extends UiState<T> {
  final String message;
  Error(this.message);
}
