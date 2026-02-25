import 'dart:ui';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // Демо-дані для кілець активності
  final int _targetCalories = 2500;
  final int _currentCalories = 1850;
  
  final int _targetSteps = 10000;
  final int _currentSteps = 7430;

  final double _targetSleep = 8.0;
  final double _currentSleep = 6.5;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Моя Активність',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Фірмовий фон
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark 
                    ? [const Color(0xFF121212), const Color(0xFF1A1A00)] 
                    : [const Color(0xFFF5F5F7), const Color(0xFFFFF9E6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Головний блок: Кільця прогресу
                  _buildGlassContainer(
                    isDark: isDark,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text('ПРОГРЕС ЗА СЬОГОДНІ', style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                          const SizedBox(height: 30),
                          
                          // Велике центральне кільце для калорій
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: CircularProgressIndicator(
                                  value: _currentCalories / _targetCalories,
                                  strokeWidth: 16,
                                  backgroundColor: isDark ? Colors.white12 : Colors.black12,
                                  color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B), // Золотий
                                ),
                              ),
                              // Внутрішнє кільце для кроків
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: CircularProgressIndicator(
                                  value: _currentSteps / _targetSteps,
                                  strokeWidth: 12,
                                  backgroundColor: isDark ? Colors.white12 : Colors.black12,
                                  color: const Color(0xFF4CAF50), // Зелений
                                ),
                              ),
                              // Текст по центру
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_fire_department, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                                  Text(
                                    '$_currentCalories',
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
                                  ),
                                  Text('ккал', style: TextStyle(fontSize: 14, color: isDark ? Colors.white54 : Colors.black54)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Детальна статистика по блоках
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('Кроки', '$_currentSteps', 'з $_targetSteps', Icons.directions_walk, const Color(0xFF4CAF50), isDark)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildStatCard('Сон', '$_currentSleep год', 'з $_targetSleep год', Icons.nights_stay, const Color(0xFF5C6BC0), isDark)),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Кнопка синхронізації
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.watch, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                      label: Text('Синхронізувати з годинником', style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 16)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Шукаю Apple Health / Google Fit...')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Скляний контейнер
  Widget _buildGlassContainer({required Widget child, required bool isDark}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5), width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }

  // Картка для окремої статистики (Кроки / Сон)
  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color iconColor, bool isDark) {
    return _buildGlassContainer(
      isDark: isDark,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 12),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            Text(subtitle, style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : Colors.black54)),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87)),
          ],
        ),
      ),
    );
  }
}
