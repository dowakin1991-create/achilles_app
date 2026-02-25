import 'dart:ui';
import 'package:flutter/material.dart';

// Клас для опису вправи
class Exercise {
  final String title;
  final String category; // Набір, Схуднення, Підтримка
  final String description;
  final IconData icon;

  Exercise({required this.title, required this.category, required this.description, required this.icon});
}

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  // Наша база вправ
  final List<Exercise> _exercises = [
    Exercise(
      title: 'Класичні присідання (Сквот)',
      category: 'Набір маси / Підтримка',
      description: '1. Станьте прямо, ноги на ширині плечей.\n2. Спина пряма, погляд вперед.\n3. Повільно опускайте таз назад і вниз, ніби сідаєте на невидимий стілець.\n4. Коліна не повинні виходити за лінію носків.\n5. Опускайтеся до паралелі стегон з підлогою, потім потужно підніміться вгору.',
      icon: Icons.fitness_center,
    ),
    Exercise(
      title: 'Берпі (Burpee)',
      category: 'Агресивне схуднення',
      description: '1. Почніть з положення стоячи.\n2. Швидко присядьте і покладіть долоні на підлогу.\n3. Стрибком перейдіть у планку.\n4. Зробіть одне віджимання.\n5. Стрибком поверніться в присяд і вистрибніть максимально високо вгору з оплеском над головою.',
      icon: Icons.local_fire_department,
    ),
    Exercise(
      title: 'Планка на ліктях',
      category: 'Підтримка / Кор',
      description: '1. Прийміть упор лежачи на ліктях.\n2. Тіло має утворювати ідеальну пряму лінію від верхівки до п\'ят.\n3. Напружте прес і сідниці.\n4. Не прогинайте поперек! Тримайте позицію від 30 до 60 секунд.',
      icon: Icons.accessibility_new,
    ),
  ];

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
          'База вправ',
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
            child: ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                return _buildExerciseCard(exercise, isDark, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise, bool isDark, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5), width: 1.5),
            ),
            child: ExpansionTile(
              iconColor: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B),
              collapsedIconColor: isDark ? Colors.white54 : Colors.black54,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black26 : Colors.white54,
                  shape: BoxShape.circle,
                ),
                child: Icon(exercise.icon, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
              ),
              title: Text(
                exercise.title,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                exercise.category,
                style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 13),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    exercise.description,
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black87, height: 1.5),
                  ),
                ),
                // Місце для майбутньої ілюстрації
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, color: isDark ? Colors.white24 : Colors.black26),
                      const SizedBox(width: 8),
                      Text('Ілюстрація вправи', style: TextStyle(color: isDark ? Colors.white24 : Colors.black26)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
