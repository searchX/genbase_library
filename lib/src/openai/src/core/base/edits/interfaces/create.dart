import 'package:http/http.dart' as http;

import '../../../models/edit/edit.dart';

abstract class CreateInterface {
  Future<OpenAIEditModel> create({
    required String model,
    String? input,
    required String? instruction,
    int? n,
    double? temperature,
    double? topP,
    http.Client? client,
  });
}
