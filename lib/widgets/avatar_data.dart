import 'package:flutter/material.dart';

// ── Koleksi avatar terpusat ──
// Tambah atau kurangi avatar di sini sesuka kamu.
// avatarIndex di AppUser merujuk ke index list ini.

class AvatarData {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String label;

  const AvatarData({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.label,
  });
}

const List<AvatarData> kAvatars = [
  // 0 — Default
  AvatarData(
    icon: Icons.person,
    bgColor: Color(0xFFE0E0E0),
    iconColor: Colors.grey,
    label: 'Default',
  ),
  // 1 — Star
  AvatarData(
    icon: Icons.star_rounded,
    bgColor: Color(0xFFFFF9C4),
    iconColor: Color(0xFFF9A825),
    label: 'Star',
  ),
  // 2 — Rocket
  AvatarData(
    icon: Icons.rocket_launch_rounded,
    bgColor: Color(0xFFE3F2FD),
    iconColor: Color(0xFF1565C0),
    label: 'Rocket',
  ),
  // 3 — Crown
  AvatarData(
    icon: Icons.workspace_premium_rounded,
    bgColor: Color(0xFFFCE4EC),
    iconColor: Color(0xFFC62828),
    label: 'Crown',
  ),
  // 4 — Lightning
  AvatarData(
    icon: Icons.bolt_rounded,
    bgColor: Color(0xFFFFF3E0),
    iconColor: Color(0xFFE65100),
    label: 'Lightning',
  ),
  // 5 — Diamond
  AvatarData(
    icon: Icons.diamond_rounded,
    bgColor: Color(0xFFE8EAF6),
    iconColor: Color(0xFF283593),
    label: 'Diamond',
  ),
  // 6 — Heart
  AvatarData(
    icon: Icons.favorite_rounded,
    bgColor: Color(0xFFFCE4EC),
    iconColor: Color(0xFFE91E63),
    label: 'Heart',
  ),
  // 7 — Music
  AvatarData(
    icon: Icons.music_note_rounded,
    bgColor: Color(0xFFF3E5F5),
    iconColor: Color(0xFF7B1FA2),
    label: 'Music',
  ),
  // 8 — Leaf
  AvatarData(
    icon: Icons.eco_rounded,
    bgColor: Color(0xFFE8F5E9),
    iconColor: Color(0xFF2E7D32),
    label: 'Nature',
  ),
  // 9 — Ghost
  AvatarData(
    icon: Icons.face_retouching_natural,
    bgColor: Color(0xFFE0F7FA),
    iconColor: Color(0xFF00838F),
    label: 'Cute',
  ),
  // 10 — Fire
  AvatarData(
    icon: Icons.local_fire_department_rounded,
    bgColor: Color(0xFFFFEBEE),
    iconColor: Color(0xFFD32F2F),
    label: 'Fire',
  ),
  // 11 — Cat
  AvatarData(
    icon: Icons.cruelty_free_rounded,
    bgColor: Color(0xFFF1F8E9),
    iconColor: Color(0xFF558B2F),
    label: 'Animal',
  ),
];

// Helper: ambil avatar berdasarkan index, aman dari out-of-range
AvatarData getAvatar(int index) {
  if (index < 0 || index >= kAvatars.length) return kAvatars[0];
  return kAvatars[index];
}