import 'dart:ui';
import 'package:flutter/material.dart';

// Допоміжний клас для продуктів
class FoodItem {
  final String name;
  final int calories;
  final double protein;
  final double fat;
  final double carbs;

  FoodItem({required this.name, required this.calories, required this.protein, required this.fat, required this.carbs});
}

class FoodDiaryScreen extends StatefulWidget {
  const FoodDiaryScreen({super.key});

  @override
  State<FoodDiaryScreen> createState() => _FoodDiaryScreenState();
}

class _FoodDiaryScreenState extends State<FoodDiaryScreen> {
  // Наша локальна міні-база для тестування (потім замінимо на API)
  final List<FoodItem> _allFoods = [
    FoodItem(name: 'Гречка варена', calories: 109, protein: 4.0, fat: 1.0, carbs: 21.0),
    FoodItem(name: 'Гречка сира', calories: 330, protein: 12.6, fat: 3.3, carbs: 62.1),
    FoodItem(name: 'Куряча грудка (філе)', calories: 113, protein: 23.6, fat: 1.9, carbs: 0.4),
    FoodItem(name: 'Яйце куряче (варене)', calories: 155, protein: 13.0, fat: 11.0, carbs: 1.1),
    FoodItem(name: 'Вівсянка', calories: 389, protein: 16.9, fat: 6.9, carbs: 66.3),
    FoodItem(name: 'Авокадо', calories: 160, protein: 2.0, fat: 14.7, carbs: 8.5),
  ];

  List<FoodItem> _foundFoods = [];
  String _selectedMeal = 'Сніданок';
  final List<String> _meals = ['Сніданок', 'Обід', 'Вечеря', 'Перекус'];

  @override
  void initState() {
    super.initState();
    _foundFoods = _allFoods; // Спочатку показуємо все
  }

  // Функція пошуку (фільтрації)
  void _runFilter(String enteredKeyword) {
    List<FoodItem> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allFoods;
    } else {
      results = _allFoods
          .where((food) => food.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundFoods = results;
    });
  }

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
          'Щоденник',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Фон
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
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Вибір прийому їжі (горизонтальний список)
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _meals.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedMeal == _meals[index];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMeal = _meals[index]),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? (isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B))
                                : (isDark ? Colors.white12 : Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              _meals[index],
                              style: TextStyle(
                                color: isSelected ? Colors.black : (isDark ? Colors.white : Colors.black87),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Скляний рядок пошуку
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) => _runFilter(value),
                          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Пошук продуктів (напр. "гре")...',
                            hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Список знайдених продуктів
                Expanded(
                  child: _foundFoods.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: _foundFoods.length,
                          itemBuilder: (context, index) => _buildFoodCard(_foundFoods[index], isDark),
                        )
                      : Center(
                          child: Text(
                            'Нічого не знайдено 😔',
                            style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 18),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Віджет для відображення картки продукту
  Widget _buildFoodCard(FoodItem food, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5), width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food.name, style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      // КБЖВ
                      Text(
                        '🔥 ${food.calories} ккал | Б: ${food.protein}г | Ж: ${food.fat}г | В: ${food.carbs}г',
                        style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B), size: 32),
                  onPressed: () {
                    // Тут буде логіка додавання в базу даних
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${food.name} додано до $_selectedMeal!'), duration: const Duration(seconds: 1)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
