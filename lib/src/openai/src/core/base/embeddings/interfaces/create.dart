import 'package:http/http.dart' as http;

import '../../../models/embedding/embedding.dart';

abstract class CreateInterface {
  Future<OpenAIEmbeddingsModel> create({
    required String model,
    required input,
    String? user,
    http.Client? client,
  });
}
