import 'package:genbase/src/networking/networking.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';

import '../../../genbase.dart';

class OpenAiChat {
  Future<Response> create(
      String model,
      List<OpenAiChatCompletionMessage> content,
      double? temperature,
      int? maxTokens) {
    return NetworkingClient.post('url', {
      'model': model,
      'messages': content.map((message) => message.toMap()).toList(),
      if (temperature != null) 'temperature': temperature,
      if (maxTokens != null) 'maxTokens': maxTokens,
    });
    // .then((Response value) =>  OpenAiChat.fromJson(value.body));
  }
//
// Map<String, dynamic> toMap() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['model'] = model;
//   data['messages'] = content.map((message) => message.toMap()).toList();
//   // data['temperature'] = temperature;
//   // data['maxTokens'] = maxTokens;
//   return data;
// }
//
// factory OpenAiChat.fromJson(Map<String, dynamic> json) {
//   final OpenAiChat openAiChat = OpenAiChat(
//     model: json['model'],
//     content: json['content'],
//     temperature: json['temperature'],
//     maxTokens: json['maxTokens'],
//   );
//   return openAiChat;
// }
}
