enum ResultStatus { success, error }

class Result<T, E> {
  final E? error;
  final T? value;
  final ResultStatus status;

  Result.succes(this.value)
      : status = ResultStatus.success,
        error = null;

  Result.failure(this.error)
      : status = ResultStatus.error,
        value = null;

  Result(this.status, this.value, this.error);

  get isError => null;

  get isSuccess => null;
}
