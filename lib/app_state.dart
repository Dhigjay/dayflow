import 'package:flutter/material.dart';

enum TaskPriority { high, medium, low }

enum TaskCategory { work, personal, health, study, other }

class TaskItem {
  final String id;
  String title;
  String? notes;
  DateTime? date;
  TimeOfDay? time;
  TaskPriority priority;
  TaskCategory category;
  bool isComplete;

  TaskItem({
    required this.id,
    required this.title,
    this.notes,
    this.date,
    this.time,
    this.priority = TaskPriority.low,
    this.category = TaskCategory.personal,
    this.isComplete = false,
  });
}

class AppUser {
  String username;
  String email;
  String password;

  AppUser({
    required this.username,
    required this.email,
    required this.password,
  });
}

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  AppUser? currentUser;
  List<TaskItem> _tasks = [];

  List<TaskItem> get allTasks => _tasks;
  List<TaskItem> get pendingTasks =>
      _tasks.where((t) => !t.isComplete).toList();
  List<TaskItem> get completedTasks =>
      _tasks.where((t) => t.isComplete).toList();

  // STREAK = jumlah schedule yang sudah diselesaikan user
  int get streakCount => completedTasks.length;

  void addTask(TaskItem task) {
    _tasks.add(task);
    notifyListeners();
  }

  void completeTask(String id) {
    final idx = _tasks.indexWhere((t) => t.id == id);
    if (idx != -1) {
      _tasks[idx].isComplete = true;
      notifyListeners();
    }
  }

  void uncompleteTask(String id) {
    final idx = _tasks.indexWhere((t) => t.id == id);
    if (idx != -1) {
      _tasks[idx].isComplete = false;
      notifyListeners();
    }
  }

  // Login: set user + reset tasks ke default
  void login(AppUser user) {
    currentUser = user;
    _resetTasksToDefault();
    notifyListeners();
  }

  // Logout: hapus user dan semua tasks
  void logout() {
    currentUser = null;
    _tasks = [];
    notifyListeners();
  }

  void updateUser(AppUser user) {
    currentUser = user;
    notifyListeners();
  }

  void _resetTasksToDefault() {
    _tasks = [
      TaskItem(
        id: 'd1',
        title: 'Morning Yoga Flow',
        date: DateTime.now(),
        time: const TimeOfDay(hour: 8, minute: 0),
        priority: TaskPriority.medium,
        category: TaskCategory.health,
      ),
      TaskItem(
        id: 'd2',
        title: 'Team Sync & Planning',
        date: DateTime.now(),
        time: const TimeOfDay(hour: 10, minute: 30),
        priority: TaskPriority.high,
        category: TaskCategory.work,
      ),
      TaskItem(
        id: 'd3',
        title: 'Review Design Specs',
        date: DateTime.now(),
        time: const TimeOfDay(hour: 14, minute: 0),
        priority: TaskPriority.high,
        category: TaskCategory.work,
      ),
      TaskItem(
        id: 'd4',
        title: 'Drink 2L Water',
        date: DateTime.now(),
        time: const TimeOfDay(hour: 7, minute: 0),
        priority: TaskPriority.low,
        category: TaskCategory.health,
      ),
      TaskItem(
        id: 'd5',
        title: 'Baca Buku 30 Menit',
        date: DateTime.now(),
        time: const TimeOfDay(hour: 20, minute: 0),
        priority: TaskPriority.low,
        category: TaskCategory.personal,
      ),
    ];
  }
}
