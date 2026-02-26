import 'package:flutter/material.dart';
// Тимчасово вимкнуто для візуального тесту в браузері
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'screens/auth_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Хмара закоментована, щоб емулятор Zapp міг показати дизайн
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
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
      home: const AuthScreen(),
    );
  }
}
