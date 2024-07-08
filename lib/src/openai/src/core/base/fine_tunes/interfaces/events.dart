import 'package:http/http.dart' as http;

import '../../../../../dart_openai.dart';

abstract class EventsInterface {
  Future<List<OpenAIFineTuneEventModel>> listEvents(
    String fineTuneId, {
    http.Client? client,
  });
}
