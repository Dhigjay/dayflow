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

// Simple global state — no database needed
class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  AppUser? currentUser;

  final List<TaskItem> _tasks = [
    TaskItem(
      id: '1',
      title: 'Morning Yoga Flow',
      date: DateTime.now(),
      time: const TimeOfDay(hour: 8, minute: 0),
      priority: TaskPriority.medium,
      category: TaskCategory.health,
    ),
    TaskItem(
      id: '2',
      title: 'Team Sync & Planning',
      date: DateTime.now(),
      time: const TimeOfDay(hour: 10, minute: 30),
      priority: TaskPriority.high,
      category: TaskCategory.work,
    ),
    TaskItem(
      id: '3',
      title: 'Review Design Specs',
      date: DateTime.now(),
      time: const TimeOfDay(hour: 14, minute: 0),
      priority: TaskPriority.high,
      category: TaskCategory.work,
    ),
    TaskItem(
      id: '4',
      title: 'Drink 2L Water',
      date: DateTime.now(),
      time: const TimeOfDay(hour: 7, minute: 0),
      priority: TaskPriority.low,
      category: TaskCategory.health,
      isComplete: true,
    ),
  ];

  List<TaskItem> get allTasks => _tasks;
  List<TaskItem> get pendingTasks => _tasks.where((t) => !t.isComplete).toList();
  List<TaskItem> get completedTasks => _tasks.where((t) => t.isComplete).toList();

  int get streakCount {
    // Simple streak: count consecutive days with completed tasks
    return completedTasks.isNotEmpty ? 12 : 0;
  }

  void addTask(TaskItem task) {
    _tasks.add(task);
    notifyListeners();
  }

  void completeTask(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isComplete = true;
    notifyListeners();
  }

  void uncompleteTask(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isComplete = false;
    notifyListeners();
  }

  void login(AppUser user) {
    currentUser = user;
    notifyListeners();
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }

  void updateUser(AppUser user) {
    currentUser = user;
    notifyListeners();
  }
}