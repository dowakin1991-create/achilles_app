import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Контролери для введення чисел
  final TextEditingController _weightController = TextEditingController(text: '85');
  final TextEditingController _heightController = TextEditingController(text: '182');
  final TextEditingController _ageController = TextEditingController(text: '28');

  // Змінні для випадаючих списків
  String _selectedGender = 'Чоловік';
  String _selectedActivity = 'Помірна активність';
  String _selectedGoal = 'Помірне схуднення';

  final List<String> _genders = ['Чоловік', 'Жінка'];
  final List<String> _activities = ['Сидячий спосіб', 'Легка активність', 'Помірна активність', 'Висока активність'];
  final List<String> _goals = ['Агресивне схуднення', 'Помірне схуднення', 'Підтримка ваги', 'Чистий набір маси'];

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
          'Мій профіль',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Наш фірмовий фон
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('ФІЗИЧНІ ДАНІ', isDark),
                  const SizedBox(height: 12),
                  _buildGlassContainer(
                    isDark: isDark,
                    child: Column(
                      children: [
                        _buildDropdownRow('Стать', _selectedGender, _genders, (val) => setState(() => _selectedGender = val!), isDark),
                        Divider(color: isDark ? Colors.white24 : Colors.black12, height: 1),
                        _buildInputRow('Вік', 'років', _ageController, isDark),
                        Divider(color: isDark ? Colors.white24 : Colors.black12, height: 1),
                        _buildInputRow('Зріст', 'см', _heightController, isDark),
                        Divider(color: isDark ? Colors.white24 : Colors.black12, height: 1),
                        _buildInputRow('Вага', 'кг', _weightController, isDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  
                  _buildSectionTitle('СПОСІБ ЖИТТЯ ТА ЦІЛЬ', isDark),
                  const SizedBox(height: 12),
                  _buildGlassContainer(
                    isDark: isDark,
                    child: Column(
                      children: [
                        _buildDropdownRow('Активність', _selectedActivity, _activities, (val) => setState(() => _selectedActivity = val!), isDark),
                        Divider(color: isDark ? Colors.white24 : Colors.black12, height: 1),
                        _buildDropdownRow('Моя ціль', _selectedGoal, _goals, (val) => setState(() => _selectedGoal = val!), isDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Кнопка збереження
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        // Тут дані будуть відправлятися в розрахунок калорій
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Дані оновлено! Алгоритм перераховує калорії...')),
                        );
                      },
                      child: const Text('Зберегти параметри', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B),
        ),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child, required bool isDark}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5), width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildInputRow(String label, String unit, TextEditingController controller, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                ),
              ),
              const SizedBox(width: 8),
              Text(unit, style: TextStyle(fontSize: 16, color: isDark ? Colors.white54 : Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(String label, String currentValue, List<String> items, Function(String?) onChanged, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  value: currentValue,
                  icon: Icon(Icons.arrow_drop_down, color: isDark ? Colors.white54 : Colors.black54),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
