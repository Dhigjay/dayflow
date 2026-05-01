import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/start_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const DayFlowApp());
}

class DayFlowApp extends StatelessWidget {
  const DayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DayFlow',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans-serif',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAB47BC)),
      ),
      home: const StartPage(),
    );
  }
}