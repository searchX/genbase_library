import 'package:flutter/cupertino.dart';

import 'content.dart';

enum OpenAiChatCompletionMessageRole { user, assistant, system }

class OpenAiChatCompletionMessage {
  OpenAiChatCompletionMessageRole role;
  List<OpenAIChatCompletionMessageContentItem> content;

  OpenAiChatCompletionMessage(this.role, this.content);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OpenAiChatCompletionMessage &&
          runtimeType == other.runtimeType &&
          role == other.role &&
          content == other.content;

  @override
  int get hashCode => role.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'OpenAiChatCompletionMessage{role: $role, content: $content}';
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role.toString().split('.').last,
      'content': content.map((message) => message.toMap()).toList(),
    };
  }
}
