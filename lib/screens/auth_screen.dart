import 'dart:ui';
import 'package:flutter/material.dart';

// Надійний короткий шлях
import 'main_menu.dart'; 

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true; 
  bool _isLoading = false; 
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _authenticate() async {
    setState(() => _isLoading = true);
    
    // Імітуємо завантаження
    await Future.delayed(const Duration(seconds: 1));
      
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
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
                  Icon(Icons.shield, size: 80, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                  const SizedBox(height: 16),
                  Text(
                    'ACHILLES',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 3, color: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B)),
                  ),
                  const SizedBox(height: 40),
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5), width: 1.5),
                        ),
                        child: Column(
                          children: [
                            Text(_isLogin ? 'З поверненням!' : 'Почни свій шлях', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87)),
                            const SizedBox(height: 24),
                            
                            _buildTextField('Email', Icons.email_outlined, _emailController, isDark),
                            const SizedBox(height: 16),
                            _buildTextField('Пароль', Icons.lock_outline, _passwordController, isDark, isPassword: true),
                            const SizedBox(height: 24),
                            
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: isDark ? const Color(0xFFFFD700) : const Color(0xFFB8860B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                                onPressed: _isLoading ? null : _authenticate,
                                child: _isLoading 
                                    ? const CircularProgressIndicator(color: Colors.black)
                                    : Text(_isLogin ? 'Увійти' : 'Створити акаунт', style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () => setState(() => _isLogin = !_isLogin),
                              child: Text(_isLogin ? 'Ще не легіонер? Зареєструйся' : 'Вже маєш акаунт? Увійди', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
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
      controller: controller, obscureText: isPassword, style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54), prefixIcon: Icon(icon, color: isDark ? Colors.white54 : Colors.black54), filled: true, fillColor: isDark ? Colors.black26 : Colors.white60, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
    );
  }
}
