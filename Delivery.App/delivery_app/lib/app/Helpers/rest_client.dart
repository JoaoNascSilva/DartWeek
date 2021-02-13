import 'package:get/get.dart';

class RestClient extends GetConnect {
  String baseURL = 'http://192.168.0.28:8080';

  RestClient() {
    httpClient.baseUrl = this.baseURL;
  }
}

class RestClientException implements Exception {
  final int code;
  final String message;

  RestClientException(this.message, {this.code});

  @override
  String toString() => 'RestClientException(code: $code, message: $message)';
}
