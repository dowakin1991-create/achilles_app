import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';

class AiScannerScreen extends StatefulWidget {
  const AiScannerScreen({super.key});

  @override
  State<AiScannerScreen> createState() => _AiScannerScreenState();
}

class _AiScannerScreenState extends State<AiScannerScreen> {
  bool _isScanning = false;
  bool _scanComplete = false;

  // Демо-результати ШІ
  final double _bodyFat = 15.4;
  final double _muscleMass = 42.1;

  void _startScan() {
    setState(() {
      _isScanning = true;
      _scanComplete = false;
    });

    // Імітація роботи Штучного Інтелекту (3 секунди)
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _scanComplete = true;
        });
      }
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
          'Око Зевса (ШІ Аналіз)',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Зробіть фото у прилеглому одязі на повний зріст. ШІ автоматично визначить ваші пропорції.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 30),

                  // Зона камери / сканування
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: isDark ? const Color(0xFFFFD700).withOpacity(0.5) : const Color(0xFFB8860B).withOpacity(0.5), width: 2),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Плейсхолдер для майбутньої реальної камери
                              Icon(Icons.person_outline, size: 150, color: isDark ? Colors.white12 : Colors.black12),
                              
                              if (_isScanning)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                                    const SizedBox(height: 16),
                                    Text('Алгоритм ML Kit розпізнає контури...', style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Результати
                  if (_scanComplete)
                    _buildGlassContainer(
                      isDark: isDark,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('РЕЗУЛЬТАТИ АНАЛІЗУ', style: TextStyle(color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildResultItem('Жирова маса', '$_bodyFat%', Icons.opacity, Colors.orange, isDark),
                                _buildResultItem('М\'язова маса', '$_muscleMass%', Icons.fitness_center, Colors.green, isDark),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 30),

                  // Кнопка
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.camera_alt, color: _isScanning ? Colors.grey : Colors.black),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _isScanning ? null : _startScan,
                      label: Text(
                        _scanComplete ? 'Повторити сканування' : 'Сканувати фігуру',
                        style: TextStyle(color: _isScanning ? Colors.grey : Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildResultItem(String title, String value, IconData icon, Color iconColor, bool isDark) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 32),
        const SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        Text(title, style: TextStyle(fontSize: 14, color: isDark ? Colors.white54 : Colors.black54)),
      ],
    );
  }
}
