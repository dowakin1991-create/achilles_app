import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Хмара розблокована
import 'screens/main_menu.dart';

void main() async {
  // Цей рядок обов'язковий, він гарантує, що графіка завантажиться 
  // лише після того, як хмара буде готова
  WidgetsFlutterBinding.ensureInitialized();
  
  // Ініціалізуємо Firebase (згодом сюди додадуться ключі безпеки)
  // await Firebase.initializeApp(); // Поки що закоментовано для безпеки на GitHub
  
  runApp(const AchillesApp());
}

class AchillesApp extends StatelessWidget {
  const AchillesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achilles',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, 
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
