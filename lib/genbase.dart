import 'dart:convert';

import 'package:genbase/src/openai/dart_openai.dart';
import 'package:genbase/src/openai/src/core/constants/config.dart';
import 'package:genbase/src/temp/networking/header.dart';
import 'package:http/http.dart' as http;

export 'src/openai/dart_openai.dart';

class Genbase {
  Genbase._();

  static final OpenAI _openAiInstance = OpenAI.instance;
  static String? _internalProjectKey;
  static String? _token;

  static set projectKey(String projectKey) {
    _internalProjectKey = projectKey;
    OpenAIConfig.baseUrl = "http://172.20.10.6:8000";
  }

  static Future<void> initialize() async {
    if (_internalProjectKey == null) {
      throw Exception("Project key must be set before initialization.");
    }
    final tokenResponse = await _getToken(_internalProjectKey!);
    if (tokenResponse.statusCode == 200) {
      _token = jsonDecode(tokenResponse.body)["access_token"];
      HeadersBuilder.apiKey = _token;
    } else {
      throw Exception(
          "Failed to retrieve token with provided project key. Status code: ${tokenResponse.statusCode}");
    }
  }

  static Future<http.Response> _getToken(String projectKey) async {
    return await http.post(
      Uri.parse('http://172.20.10.6:8000/project/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "project_key": projectKey,
      }),
    );
  }

  static OpenAI get openai {
    if (_token == null) {
      throw Exception("Genbase not initialized. Call initialize() first.");
    }
    return _openAiInstance;
  }
}
