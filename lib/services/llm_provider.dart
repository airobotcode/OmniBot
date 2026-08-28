import "dart:async";

abstract class LLMProvider {
  String get name;
  Future<String> sendMessage({
    required String apiKey,
    required String model,
    required List<Map<String, String>> messages,
  });
}

class ClaudeProvider implements LLMProvider {
  @override
  String get name => "Claude";

  @override
  Future<String> sendMessage({
    required String apiKey,
    required String model,
    required List<Map<String, String>> messages,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return "[Claude 响应] 接收到消息，模型 $model 正常响应。";
  }
}

class GeminiProvider implements LLMProvider {
  @override
  String get name => "Gemini";

  @override
  Future<String> sendMessage({
    required String apiKey,
    required String model,
    required List<Map<String, String>> messages,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return "[Gemini 响应] 接收到消息，模型 $model 正常响应。";
  }
}

class OpenAIProvider implements LLMProvider {
  @override
  String get name => "OpenAI";

  @override
  Future<String> sendMessage({
    required String apiKey,
    required String model,
    required List<Map<String, String>> messages,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return "[OpenAI 响应] 接收到消息，模型 $model 正常响应。";
  }
}
