import "package:flutter/material.dart";
import "chat_screen.dart";

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final List<Map<String, dynamic>> features = [
    {
      "title": "多模型对话",
      "subtitle": "支持 Claude / Gemini / OpenAI 自由切换",
      "icon": Icons.chat_bubble_outline,
      "color": Colors.blue,
      "action": "chat",
    },
    {
      "title": "模型竞技场",
      "subtitle": "同时发送对比多个模型的回答结果",
      "icon": Icons.compare_arrows,
      "color": Colors.purple,
      "action": "arena",
    },
    {
      "title": "多模态工作流",
      "subtitle": "图片分析、语音交互与文件处理",
      "icon": Icons.extension_outlined,
      "color": Colors.orange,
      "action": "multimodal",
    },
    {
      "title": "Agent 智能体库",
      "subtitle": "自定义 Prompt 设定与角色社区",
      "icon": Icons.smart_toy_outlined,
      "color": Colors.green,
      "action": "agent",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OmniBot 综合平台"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            const Text(
              "多元功能中心",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final item = features[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (item["action"] == "chat") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: item["color"].withOpacity(0.1),
                              child: Icon(item["icon"], color: item["color"]),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item["title"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["subtitle"],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
