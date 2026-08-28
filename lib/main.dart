import "package:flutter/material.dart";
import "screens/home_dashboard.dart";

void main() {
  runApp(const OmniBotApp());
}

class OmniBotApp extends StatelessWidget {
  const OmniBotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OmniBot",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeDashboard(),
    );
  }
}
