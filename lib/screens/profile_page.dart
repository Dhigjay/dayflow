import 'package:dayflow/screens/add_schedule_page.dart';
import 'package:flutter/material.dart';
import '../app_state.dart';
import 'start_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AppState _state = AppState();

  void _showEditDialog(
    String field,
    String currentValue,
    Function(String) onSave,
  ) {
    final ctrl = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Edit $field',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: ctrl,
          obscureText: field == 'Password',
          decoration: InputDecoration(
            hintText: 'Masukkan $field baru',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFAB47BC), width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAB47BC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              final val = ctrl.text.trim();
              if (val.isNotEmpty) {
                onSave(val);
                Navigator.pop(ctx);
                setState(() {});
              }
            },
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Logout?',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Kamu akan keluar dari akun DayFlow. Yakin ingin logout?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              _state.logout();
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, _) => const StartPage(),
                  transitionsBuilder: (context, anim, _, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 400),
                ),
                (route) => false,
              );
            },
            child: const Text(
              'Ya, Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _state.currentUser;
    final completedCount = _state.completedTasks.length;
    final pendingCount = _state.pendingTasks.length;
    final streak = _state.streakCount;

    return Scaffold(
      backgroundColor: const Color(0xFFAB47BC),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'DayFlow',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // balance
                ],
              ),
            ),

            // ── White Card ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(3, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // ── Avatar ──
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 56,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFAB47BC),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Name
                        Text(
                          user?.username ?? 'User',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Email
                        Text(
                          user?.email ?? 'user@email.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Stats Row ──
                        Row(
                          children: [
                            _statCard(
                              '$completedCount',
                              'TASKS\nDONE',
                              const Color(0xFFE1BEE7),
                            ),
                            const SizedBox(width: 8),
                            _statCard(
                              '$pendingCount',
                              'PENDING',
                              Colors.grey.shade200,
                            ),
                            const SizedBox(width: 8),
                            _statCard(
                              '$streak',
                              'STREAK',
                              const Color(0xFFAB47BC),
                              textColor: Colors.white,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ── Info Items ──
                        _infoItem(
                          icon: Icons.person_outline,
                          label: 'USERNAME',
                          value: user?.username ?? '-',
                          onTap: () => _showEditDialog(
                            'Username',
                            user?.username ?? '',
                            (v) {
                              _state.updateUser(
                                AppUser(
                                  username: v,
                                  email: user?.email ?? '',
                                  password: user?.password ?? '',
                                ),
                              );
                            },
                          ),
                        ),

                        _infoItem(
                          icon: Icons.mail_outline,
                          label: 'EMAIL ADDRESS',
                          value: user?.email ?? '-',
                          onTap: () =>
                              _showEditDialog('Email', user?.email ?? '', (v) {
                                _state.updateUser(
                                  AppUser(
                                    username: user?.username ?? '',
                                    email: v,
                                    password: user?.password ?? '',
                                  ),
                                );
                              }),
                        ),

                        _infoItem(
                          icon: Icons.lock_outline,
                          label: 'PASSWORD',
                          value: '••••••••',
                          onTap: () => _showEditDialog(
                            'Password',
                            user?.password ?? '',
                            (v) {
                              _state.updateUser(
                                AppUser(
                                  username: user?.username ?? '',
                                  email: user?.email ?? '',
                                  password: v,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ── Logout Button ──
                        GestureDetector(
                          onTap: _showLogoutDialog,
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'LOGOUT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom Nav ──
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    String value,
    String label,
    Color bgColor, {
    Color textColor = Colors.black87,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1.5),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(2, 3), blurRadius: 0),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: textColor.withValues(alpha: 0.7),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black, width: 1.5),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(2, 4), blurRadius: 0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Tombol Home
          GestureDetector(
            onTap: () => Navigator.pop(context), // Kembali ke layar utama
            child: const Icon(
              Icons.home_filled,
              color: Colors.black45,
              size: 24,
            ),
          ),

          // Tombol Add Schedule (Diperbarui navigasinya)
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddSchedulePage(),
                ), // Pastikan import AddSchedulePage
              );
            },
            // Di sini ikon "+" tidak dibungkus background ungu karena user sedang tidak di halaman Add Schedule
            child: const Icon(Icons.add, color: Colors.black45, size: 24),
          ),

          // Tombol Profile (Sedang Aktif)
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFAB47BC),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
