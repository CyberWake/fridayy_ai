class CallOutcome<T> {
  CallOutcome({this.data, this.exception})
      : assert(
          data != null || exception != null,
          "both data and exception can't be empty",
        );

  T? data;
  Exception? exception;
}
