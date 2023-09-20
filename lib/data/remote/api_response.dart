class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  ApiResponse.initial(this.message) : status = Status.initial;
  ApiResponse.loading(this.message) : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;
  ApiResponse.noInternet(this.message) : status = Status.noInternet;
  ApiResponse.unAuthorised(this.message) : status = Status.unAuthorised;
  ApiResponse.timeout(this.message) : status = Status.timeout;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status {
  initial,
  loading,
  completed,
  error,
  noInternet,
  unAuthorised,
  timeout
}
