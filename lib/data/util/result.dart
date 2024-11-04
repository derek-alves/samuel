sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends Result<T> {
  final String message;

  const Error(this.message);
}

extension ResultExtension<T> on Result<T> {
  bool isSuccess() => this is Success<T>;

  T? getValueOrNull() => this is Success<T> ? (this as Success<T>).data : null;

  String? getErrorOrNull() =>
      this is Error<T> ? (this as Error<T>).message : null;
}
