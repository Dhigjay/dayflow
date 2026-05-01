import 'package:flutter/material.dart';
import '../app_state.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _register() {
    final username = _usernameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Semua field wajib diisi!'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password minimal 6 karakter!'),
          backgroundColor: Colors.orange.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      AppState().login(
        AppUser(username: username, email: email, password: password),
      );
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, _) => const HomePage(),
          transitionsBuilder: (context, anim, _, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFAB47BC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),

              // ── Title ──
              const Text(
                'DauFlow',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 16),

              // Avatar overlapping card
              // ✅ BENAR
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(4, 6),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Title inside card
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Join the flow state.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Full Name
                        _buildLabel('Full Name'),
                        const SizedBox(height: 8),
                        _buildInputField(
                          controller: _usernameCtrl,
                          hint: 'Jane Doe',
                          icon: Icons.person_outline,
                        ),

                        const SizedBox(height: 16),

                        // Email
                        _buildLabel('Email Address'),
                        const SizedBox(height: 8),
                        _buildInputField(
                          controller: _emailCtrl,
                          hint: 'jane@example.com',
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Password
                        _buildLabel('Password'),
                        const SizedBox(height: 8),
                        _buildInputField(
                          controller: _passwordCtrl,
                          hint: '••••••••',
                          icon: Icons.lock_outline,
                          obscure: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Register Button
                        GestureDetector(
                          onTap: _isLoading ? null : _register,
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Center(
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Register',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Login link
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, _) =>
                                    const LoginPage(),
                                transitionsBuilder: (context, anim, _, child) =>
                                    FadeTransition(opacity: anim, child: child),
                                transitionDuration: const Duration(
                                  milliseconds: 300,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Already have an account? Login',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Floating avatar on top of card
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.black, width: 2.5),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Bottom decorative icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDecorIcon(Icons.eco_outlined),
                  const SizedBox(width: 16),
                  _buildDecorIcon(Icons.favorite_border),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorIcon(IconData icon) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Icon(icon, color: Colors.black54, size: 24),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          prefixIcon: Icon(icon, color: Colors.black54, size: 22),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
