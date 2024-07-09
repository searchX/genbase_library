import 'dart:convert';

import 'package:genbase/src/openai/dart_openai.dart';
import 'package:genbase/src/openai/src/core/builder/headers.dart';
import 'package:genbase/src/openai/src/core/constants/config.dart';
import 'package:genbase/src/openai/src/core/constants/strings.dart';
import 'package:http/http.dart' as http;

export 'src/openai/dart_openai.dart';

class Genbase {
  Genbase._();

  static final OpenAI _openAiInstance = OpenAI.instance;
  static String? _internalProjectKey;
  static String? _token;

  /// The base API url, by default it is set to the OpenAI API url.
  /// You can change it by calling the [Genbase.baseUrl] setter.
  static String get baseUrl => OpenAIConfig.baseUrl;

  static set baseUrl(String baseUrl) {
    OpenAIConfig.baseUrl = baseUrl;
  }

  /// The base API url, by default it is set to the OpenAI API url.
  /// You can change it by calling the [Genbase.proxyUrl] setter.
  static String get proxyUrl => OpenAIConfig.proxyUrl;

  static set proxyUrl(String proxyUrl) {
    OpenAIConfig.proxyUrl = proxyUrl;
  }

  static set projectKey(String projectKey) {
    _internalProjectKey = projectKey;
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
      Uri.parse(baseUrl + OpenAIStrings.auth),
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
