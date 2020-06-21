class ResponseHttp<T> {
  DateTime timestamp;
  int status;
  String error;
  String trace;
  String message;
  String path;
  T data;

  ResponseHttp({
    this.timestamp,
    this.status,
    this.error,
    this.trace,
    this.message,
    this.path,
    this.data,
  });

  bool isOk() {
    return status == 200;
  }

  factory ResponseHttp.fromJson(Map<String, dynamic> json) {
    return ResponseHttp(
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
      error: json['error'],
      trace: json['trace'],
      message: json['message'],
      path: json['path'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "timestamp": timestamp,
      "status": status,
      "error": error,
      "trace": trace,
      "message": message,
      "path": path,
      "data" : data,
    };
  }

}
