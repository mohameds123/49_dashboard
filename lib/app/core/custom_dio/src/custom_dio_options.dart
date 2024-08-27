import 'package:dio/dio.dart';

class CustomDioOptions {
  Map<String, String>? headers;

  bool followRedirects;
  bool isProductionMode;

  final String baseUrl;
  final String? errorPath;

  HttpClientAdapter? adapter;
  late Duration sendTimeout;
  late List<Interceptor> interceptorsList;

  late Duration receiveTimeout;

  late Duration connectTimeout;

  late bool logAllData;

  bool get isHasAuthToken => headers!['authorization'] != "NO TOKEN";

  CustomDioOptions({
    this.headers,
    this.isProductionMode = true,
    this.followRedirects = true,
    this.errorPath,
    required this.baseUrl,
    this.adapter,
    this.interceptorsList = const [],
    this.sendTimeout = const Duration(seconds: 20),
    this.receiveTimeout = const Duration(seconds: 20),
    this.connectTimeout = const Duration(seconds: 20),
    this.logAllData = false,
  });

  CustomDioOptions copyWith({
    Map<String, String>? headers,
    bool? followRedirects,
    bool? isProductionMode,
    String? baseUrl,
    String? errorPath,
    HttpClientAdapter? adapter,
    Duration? sendTimeout,
    List<Interceptor>? interceptorsList,
    Duration? receiveTimeout,
    Duration? connectTimeout,
    bool? logAllData,
  }) {
    return CustomDioOptions(
      headers: headers ?? this.headers,
      followRedirects: followRedirects ?? this.followRedirects,
      isProductionMode: isProductionMode ?? this.isProductionMode,
      baseUrl: baseUrl ?? this.baseUrl,
      errorPath: errorPath ?? this.errorPath,
      adapter: adapter ?? this.adapter,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      interceptorsList: interceptorsList ?? this.interceptorsList,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      logAllData: logAllData ?? this.logAllData,
    );
  }

  @override
  String toString() {
    return 'CustomDioOptions{headers: $headers, followRedirects: $followRedirects, isProductionMode: $isProductionMode, baseUrl: $baseUrl, errorPath: $errorPath, adapter: $adapter, sendTimeout: $sendTimeout, interceptorsList: $interceptorsList, receiveTimeout: $receiveTimeout, connectTimeout: $connectTimeout, logAllData: $logAllData}';
  }
}
