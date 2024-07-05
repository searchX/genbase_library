import 'package:meta/meta.dart';

@immutable
@internal
abstract class HeadersBuilder {
  /// {@template headers_builder_api_key}
  /// This is used to store the API key if it is set.
  /// {@endtemplate}
  static String? _apiKey;

  /// This represents additional hezders to be added in all requests made by the package/
  static Map<String, dynamic> _additionalHeadersToRequests = {};

  /// {@macro headers_builder_api_key}
  @internal
  static String? get apiKey => _apiKey;

  @internal
  static set apiKey(String? apiKey) {
    _apiKey = apiKey;
  }

  @internal
  static Map<String, String> build() {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    assert(
      apiKey != null,
      """
      You must set the API key before making building any headers for a request.""",
    );
    headers = {
      ...headers,
      ..._additionalHeadersToRequests,
      "Authorization": "Bearer $apiKey",
    };

    return headers;
  }

  /// Will save the given [headers] to the [_additionalHeadersToRequests] map. so it will be used in all requests.
  @internal
  static void includeHeaders(Map<String, dynamic> headers) {
    _additionalHeadersToRequests = {
      ..._additionalHeadersToRequests,
      ...headers,
    };
  }
}
