import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Наша хмарна авторизація
import 'main_menu.dart'; // Щоб зайти в головне меню після успіху

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true; // Перемикач: Вхід чи Реєстрація
  bool _isLoading = false; // Індикатор завантаження
  
  // Контролери для зчитування тексту
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Функція для роботи з Firebase
  Future<void> _authenticate() async {
    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        // Логіка входу
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // Логіка реєстрації
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      
      // Якщо все успішно, пускаємо в додаток
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainMenuScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Якщо помилка (наприклад, невірний пароль) - показуємо повідомлення
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Сталася помилка. Боги не пускають.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Наш фірмовий градієнтний фон
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark 
                    ? [const Color(0xFF121212), const Color(0xFF1A1A00)] 
                    : [const Color(0xFFF5F5F7), const Color(0xFFFFF9E6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Іконка шолома (плейсхолдер для логотипу)
                  Icon(Icons.shield, size: 80, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                  const SizedBox(height: 16),
                  Text(
                    'ACHILLES',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Скляна панель
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _isLogin ? 'З поверненням!' : 'Почни свій шлях',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            _buildTextField('Email', Icons.email_outlined, _emailController, isDark),
                            const SizedBox(height: 16),
                            _buildTextField('Пароль', Icons.lock_outline, _passwordController, isDark, isPassword: true),
                            const SizedBox(height: 24),
                            
                            // Головна кнопка (Вхід/Реєстрація)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                onPressed: _isLoading ? null : _authenticate,
                                child: _isLoading 
                                    ? const CircularProgressIndicator(color: Colors.black)
                                    : Text(
                                        _isLogin ? 'Увійти' : 'Створити акаунт', 
                                        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)
                                      ),
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Перемикач між Входом і Реєстрацією
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin ? 'Ще не легіонер? Зареєструйся' : 'Вже маєш акаунт? Увійди',
                                style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, bool isDark, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
        prefixIcon: Icon(icon, color: isDark ? Colors.white54 : Colors.black54),
        filled: true,
        fillColor: isDark ? Colors.black26 : Colors.white60,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
