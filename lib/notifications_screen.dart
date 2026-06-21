import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {'title': 'Chef Juna menyukai resep Anda!', 'sub': 'Resep "Ramen Kuah Pedas" mendapat 1 suka.', 'icon': Icons.favorite, 'color': Colors.redAccent, 'isRead': false},
    {'title': 'Komentar Baru', 'sub': 'Sisca: "Wah, enak banget Chef!"', 'icon': Icons.comment, 'color': Colors.blueAccent, 'isRead': false},
    {'title': 'Pencapaian Baru 🏆', 'sub': 'Selamat! Anda mendapat badge "Raja Pedas".', 'icon': Icons.emoji_events, 'color': Colors.amber, 'isRead': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        title: const Text('Notifikasi', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          TextButton(
            onPressed: () {
              setState(() { for (var notif in _notifications) { notif['isRead'] = true; } });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Semua notifikasi ditandai sudah dibaca')));
            },
            child: const Text('Tandai Dibaca', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 10, bottom: 100),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final notif = _notifications[index];
          return Container(
            color: notif['isRead'] ? Colors.white : Colors.red.shade50.withOpacity(0.5),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: CircleAvatar(backgroundColor: notif['color'].withOpacity(0.15), child: Icon(notif['icon'], color: notif['color'])),
              title: Text(notif['title'], style: TextStyle(fontWeight: notif['isRead'] ? FontWeight.normal : FontWeight.bold, fontSize: 15)),
              subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text(notif['sub'], style: TextStyle(color: Colors.grey.shade600, fontSize: 13))),
              trailing: notif['isRead'] ? null : Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)),
              onTap: () {
                if (!notif['isRead']) { setState(() { notif['isRead'] = true; }); }
              },
            ),
          );
        },
      ),
    );
  }
}