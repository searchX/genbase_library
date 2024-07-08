import 'package:http/http.dart' as http;

import '../../../../../dart_openai.dart';

abstract class RetrieveInterface {
  Future<OpenAIModelModel> retrieve(
    String modelId, {
    http.Client? client,
  });
}
