import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Розблокуємо, коли додамо пакети
import 'screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Ініціалізація нашої хмари
  runApp(const AchillesApp());
}

class AchillesApp extends StatelessWidget {
  const AchillesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achilles',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Адаптивна тема за замовчуванням
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      ),
      home: const MainMenuScreen(),
    );
  }
}
