class ClientResponse {
  DateTime timestamp;
  int status;
  String error;
  String trace;
  String message;
  String path;

  ClientResponse({
    this.timestamp,
    this.status,
    this.error,
    this.trace,
    this.message,
    this.path,
  });

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      status: json['status'],
      error: json['error'],
      trace: json['trace'],
      message: json['message'],
      path: json['path'],
    );
  }

}
