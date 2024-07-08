import 'package:http/http.dart' as http;

import '../../../models/file/file.dart';

abstract class ListInterface {
  Future<List<OpenAIFileModel>> list({
    http.Client? client,
  });
}
