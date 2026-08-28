class AppConfig {
  static const String appName = "OmniBot";
  static const String version = "1.5.0";
  static const String tagline = "开源 · 零中转 · 隐私优先的跨平台大模型原生客户端";
  
  // 零中转支持的服务商列表
  static const List<String> supportedProviders = [
    "Gemini (Direct)",
    "Claude (Direct)",
    "OpenAI (Direct)",
    "Ollama (Local IP)",
    "Custom OpenAI-Compatible Endpoint"
  ];
}
