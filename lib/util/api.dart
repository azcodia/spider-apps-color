import 'dart:io';
import 'package:dio/dio.dart';

class Api {
  // static const CORE_URL = "http://abcpainting-api.cranium.co.id";
  // static const BASE_URL = CORE_URL + "/api/v1";

  static const CORE_URL = "http://abca-indonesia.com";
  static const BASE_URL = CORE_URL + "/api/api/v1";

  static Dio init() {
    return new Dio(new Options(
        baseUrl: BASE_URL,
        connectTimeout: 15000,
        receiveTimeout: 10000,
        headers: {"Content-Type": "application/json"},
        contentType: ContentType.json));
  }
}
