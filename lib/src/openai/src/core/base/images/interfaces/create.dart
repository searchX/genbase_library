import 'package:http/http.dart' as http;

import '../../../enum.dart';
import '../../../models/image/image/image.dart';

abstract class CreateInterface {
  Future<OpenAIImageModel> create({
    required String prompt,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
    http.Client? client,
  });
}
