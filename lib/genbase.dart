import 'package:flutter/foundation.dart';
import 'package:genbase/src/instances/chat/chat.dart';
import 'package:genbase/src/networking/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
export './src/openai/chat/export.dart';

class Genbase {
  late String _internalApiKey;

  String get apiKey => _internalApiKey;
  String _baseUrl = 'http://172.20.10.6:8000';

  String get baseUrl => _baseUrl;

  set baseUrl(String value) {
    _baseUrl = value;
  }

  set apiKey(String value) {
    HeadersBuilder.apiKey = value;
    _internalApiKey = value;
  }

  Genbase([String apiKey = '']) {
    this.apiKey = apiKey;
  }

  Future<http.Response> instance() {
    if (kDebugMode) {
      print("Genbase is Initialized with id: $_internalApiKey");
    }
    return http.post(Uri.parse('$baseUrl/library/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"project_key": _internalApiKey}));
  }

  Future<http.Response> checkConnection() {
    return http.get(Uri.parse(_baseUrl));
  }

  OpenAiChat get chat => OpenAiChat();

//
// Future<http.Response> request() {
//   OpenAiChat openAiChat = OpenAiChat(model: 'gpt-3.5-turbo', content: [
//   ]);
//   print(openAiChat.toMap());
//   return http.post(
//     Uri.parse('http://192.168.1.15:8000/openai/chat/completion'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(openAiChat.toMap()),
//   );
// }
}
