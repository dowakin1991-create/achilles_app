import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth_screen.dart'; // Тепер імпортуємо екран авторизації

void main() async {
  // Гарантуємо, що віджети завантажаться перед підключенням до мережі
  WidgetsFlutterBinding.ensureInitialized();
  
  // Ініціалізуємо хмару з твоїми ключами Achilles
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const AchillesApp());
}

class AchillesApp extends StatelessWidget {
  const AchillesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achilles',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Автоматичне перемикання теми
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      ),
      // Стартова сторінка - завжди екран входу
      home: const AuthScreen(), 
    );
  }
}
