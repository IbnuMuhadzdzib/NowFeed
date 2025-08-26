import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart'; // biar bisa pakai flutterLocalNotificationsPlugin

class TestNotificationPage extends StatelessWidget {
  const TestNotificationPage({super.key});

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'news_channel', // ID channel
      'News Notifications', // Nama channel
      channelDescription: 'Channel untuk notifikasi berita',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Breaking News!',
      'Ada 5 berita baru di kategori Teknologi 🚀',
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tes Notifikasi")),
      body: Center(
        child: ElevatedButton(
          onPressed: _showNotification,
          child: const Text("Tampilkan Notifikasi"),
        ),
      ),
    );
  }
}
