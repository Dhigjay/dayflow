import 'package:flutter/material.dart';
import 'login_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin() {
    // Selalu push ke LoginPage — tidak pernah skip
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const LoginPage(),
        transitionsBuilder: (context, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFAB47BC),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Column(
              children: [
                const Spacer(flex: 2),

                // ── Logo ──
                Container(
                  width: size.width * 0.32,
                  height: size.width * 0.32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9C27B0),
                    borderRadius: BorderRadius.circular(size.width * 0.08),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.6),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(4, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.show_chart,
                    color: Colors.white,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 28),

                // ── App Name ──
                const Text(
                  'DayFlow',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),

                const SizedBox(height: 8),

                // ── Tagline ──
                Text(
                  'Find your rhythm.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.75),
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.3,
                  ),
                ),

                const Spacer(flex: 3),

                // ── Start Button ──
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: GestureDetector(
                    onTap: _goToLogin,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
