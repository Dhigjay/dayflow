import 'package:flutter/material.dart';
import '../app_state.dart';
import 'add_schedule_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final AppState _state = AppState();

  String _todayLabel() {
    const days = [
      'SUNDAY',
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
    ];
    const months = [
      '',
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final now = DateTime.now();
    return '${days[now.weekday % 7]}, ${months[now.month]} ${now.day}';
  }

  Color _priorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return const Color(0xFF7B1FA2);
      case TaskPriority.medium:
        return const Color(0xFFCE93D8);
      case TaskPriority.low:
        return Colors.white;
    }
  }

  Color _priorityTextColor(TaskPriority priority) {
    return priority == TaskPriority.low ? Colors.black87 : Colors.white;
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    final m = time.minute.toString().padLeft(2, '0');
    final suffix = time.hour >= 12 ? 'PM' : 'AM';
    final hour12 = time.hour > 12
        ? time.hour - 12
        : (time.hour == 0 ? 12 : time.hour);
    return '${hour12.toString().padLeft(2, '0')}:$m $suffix';
  }

  // ── BARU: format tanggal ──
  String _formatDate(DateTime date) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  // ── BARU: label kategori ──
  String _categoryLabel(TaskCategory cat) {
    switch (cat) {
      case TaskCategory.work:
        return 'Work';
      case TaskCategory.personal:
        return 'Personal';
      case TaskCategory.health:
        return 'Health';
      case TaskCategory.study:
        return 'Study';
      case TaskCategory.other:
        return 'Other';
    }
  }

  // ── BARU: ikon kategori ──
  IconData _categoryIcon(TaskCategory cat) {
    switch (cat) {
      case TaskCategory.work:
        return Icons.work_outline;
      case TaskCategory.personal:
        return Icons.person_outline;
      case TaskCategory.health:
        return Icons.favorite_border;
      case TaskCategory.study:
        return Icons.school_outlined;
      case TaskCategory.other:
        return Icons.label_outline;
    }
  }

  void _showCompleteDialog(TaskItem task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Tandai Selesai?',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: Text('Apakah "${task.title}" sudah selesai dikerjakan?'),
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
              Navigator.pop(ctx);
              setState(() => _state.completeTask(task.id));
            },
            child: const Text(
              'Ya, Selesai!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showUncompleteDialog(TaskItem task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Batalkan?',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: Text('Kembalikan "${task.title}" ke daftar jadwal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tidak', style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _state.uncompleteTask(task.id));
            },
            child: const Text('Ya', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = _state.currentUser;
    final pending = _state.pendingTasks;
    final completed = _state.completedTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFAB47BC),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'DayFlow',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, _) =>
                                const ProfilePage(),
                            transitionsBuilder: (context, anim, _, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: const Duration(
                              milliseconds: 300,
                            ),
                          ),
                        ).then((_) => setState(() {}));
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: const Icon(Icons.person_outline, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Main Content ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(3, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Greeting + Avatar row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello, ${user?.username ?? 'User'}',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87,
                                        height: 1.1,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _todayLabel(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade500,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade200,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // ── Schedule Section ──
                          Row(
                            children: [
                              const Text(
                                'Schedule',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFAB47BC),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${pending.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          if (pending.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Tidak ada jadwal. Tap + untuk menambah!',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          else
                            ...pending.map(
                              (task) => _buildTaskCard(task, false),
                            ),

                          const SizedBox(height: 20),

                          // ── Complete Section ──
                          Text(
                            'Complete',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                            ),
                          ),

                          const SizedBox(height: 12),

                          if (completed.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Belum ada yang selesai.',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          else
                            ...completed.map(
                              (task) => _buildTaskCard(task, true),
                            ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),

      // ── Bottom Nav ──
      bottomNavigationBar: _buildBottomNav(size),
    );
  }

  Widget _buildTaskCard(TaskItem task, bool isComplete) {
    final bgColor = isComplete
        ? Colors.grey.shade100
        : _priorityColor(task.priority);
    final textColor = isComplete
        ? Colors.grey.shade400
        : _priorityTextColor(task.priority);
    final subTextColor = isComplete
        ? Colors.grey.shade400
        : textColor.withValues(alpha: 0.75);
    final dotColor = isComplete ? Colors.grey.shade400 : textColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 1.5),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(2, 3), blurRadius: 0),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot (sedikit padding atas agar sejajar dengan teks judul)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ── Konten utama ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    decoration: isComplete ? TextDecoration.lineThrough : null,
                    decorationColor: textColor,
                  ),
                ),

                const SizedBox(height: 6),

                // ── Baris: Tanggal & Waktu ──
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: subTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      task.date != null ? _formatDate(task.date!) : '',
                      style: TextStyle(fontSize: 12, color: subTextColor),
                    ),
                    if (task.time != null) ...[
                      const SizedBox(width: 10),
                      Icon(
                        Icons.access_time_outlined,
                        size: 12,
                        color: subTextColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(task.time),
                        style: TextStyle(fontSize: 12, color: subTextColor),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 5),

                // ── Baris: Kategori ──
                Row(
                  children: [
                    Icon(
                      _categoryIcon(task.category),
                      size: 12,
                      color: subTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _categoryLabel(task.category),
                      style: TextStyle(
                        fontSize: 12,
                        color: subTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // ── Catatan (hanya tampil jika ada) ──
                if (task.notes != null && task.notes!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notes_outlined,
                          size: 12,
                          color: subTextColor,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            task.notes!,
                            style: TextStyle(
                              fontSize: 12,
                              color: subTextColor,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ── Checkbox ──
          GestureDetector(
            onTap: () => isComplete
                ? _showUncompleteDialog(task)
                : _showCompleteDialog(task),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isComplete ? Colors.grey.shade400 : textColor,
                  width: 2,
                ),
              ),
              child: isComplete
                  ? Icon(Icons.check, size: 16, color: Colors.grey.shade400)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(Size size) {
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
          // Home
          GestureDetector(
            onTap: () => setState(() => _currentIndex = 0),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == 0
                    ? const Color(0xFFAB47BC)
                    : Colors.transparent,
              ),
              child: Icon(
                Icons.home_filled,
                color: _currentIndex == 0 ? Colors.white : Colors.black45,
                size: 24,
              ),
            ),
          ),

          // Add
          GestureDetector(
            onTap: () async {
              final newTask = await Navigator.push<TaskItem>(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, a, b) => const AddSchedulePage(),
                  transitionsBuilder: (context, anim, secondaryAnim, child) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                  transitionDuration: const Duration(milliseconds: 350),
                ),
              );
              if (newTask != null) {
                setState(() => _state.addTask(newTask));
              }
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 24),
            ),
          ),

          // Profile
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, a, b) => const ProfilePage(),
                  transitionsBuilder: (context, anim, secondaryAnim, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              ).then((_) => setState(() {}));
            },
            child: const Icon(
              Icons.person_outline,
              color: Colors.black45,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
