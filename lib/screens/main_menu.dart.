import 'dart:ui';
import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'food_diary_screen.dart';
import 'profile_screen.dart';
import 'activity_screen.dart';
import 'exercises_screen.dart';
import 'ai_scanner_screen.dart'; // Підключили ШІ Сканер

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          // Фірмовий фон Achilles
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark 
                    ? [Colors.black, const Color(0xFF1A1A00)] 
                    : [Colors.white, const Color(0xFFFFF9E6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'ACHILLES',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Стань легендою.',
                    style: TextStyle(fontSize: 18, color: isDark ? Colors.white70 : Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  
                  // ПОВНИЙ СПИСОК МОДУЛІВ ДОДАТКУ
                  _buildGlassMenuCard(
                    context: context, 
                    icon: Icons.person_outline, 
                    title: 'Мій профіль', 
                    isDark: isDark,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())), 
                  ),
                  const SizedBox(height: 16),
                  
                  // НОВИЙ МОДУЛЬ: ШІ Аналіз
                  _buildGlassMenuCard(
                    context: context, 
                    icon: Icons.document_scanner, 
                    title: 'ШІ Аналіз фігури', 
                    isDark: isDark,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AiScannerScreen())), 
                  ),
                  const SizedBox(height: 16),

                  _buildGlassMenuCard(
                    context: context, 
                    icon: Icons.local_fire_department, 
                    title: 'Моя Активність', 
                    isDark: isDark,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityScreen())), 
                  ),
                  const SizedBox(height: 16),

                  _buildGlassMenuCard(
                    context: context, 
                    icon: Icons.restaurant_menu, 
                    title: 'Щоденник їжі', 
                    isDark: isDark,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodDiaryScreen())), 
                  ),
                  const SizedBox(height: 16),

                  _buildGlassMenuCard(
                    context: context, 
                    icon: Icons.fitness_center, 
                    title: 'База вправ', 
                    isDark: isDark,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExercisesScreen())), 
                  ),
                  const SizedBox(height: 16),

                  _buildGlassMenuCard(
                    context: context, 
                    icon: Icons.settings_outlined, 
                    title: 'Налаштування', 
                    isDark: isDark,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())), 
                  ),
                  const SizedBox(height: 16),

                  _buildGlassMenuCard(
                    context: context, 
                    icon: Icons.info_outline, 
                    title: 'Про Achilles', 
                    isDark: isDark,
                    onTap: () => _showAboutDialog(context, isDark),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Віджет для скляних кнопок меню
  Widget _buildGlassMenuCard({required BuildContext context, required IconData icon, required String title, required bool isDark, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5), width: 1.5),
            ),
            child: Row(
              children: [
                Icon(icon, size: 28, color: isDark ? Colors.white : Colors.black87),
                const SizedBox(width: 20),
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87)),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, size: 18, color: isDark ? Colors.white54 : Colors.black54),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Спливаюче вікно "Про додаток"
  void _showAboutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Icon(Icons.shield, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
              const SizedBox(width: 10),
              Text('Про ACHILLES', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🎯 Місія', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                Text('Стати легендою, а не просто влізти в джинси.', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
                const SizedBox(height: 8),
                Text('🔥 Розрахунок', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                Text('Ми знаємо про ту цукерку "до кави".', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('До бою!', style: TextStyle(color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B))),
            ),
          ],
        );
      },
    );
  }
}
