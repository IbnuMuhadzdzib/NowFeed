import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Breaking News!",
      "message": "Big earthquake hits the city center.",
      "icon": Icons.notifications_active,
      "time": "2 min ago",
    },
    {
      "title": "New Article",
      "message": "Check out today's top 10 tech trends.",
      "icon": Icons.article,
      "time": "10 min ago",
    },
    {
      "title": "Saved News",
      "message": "Your saved article is ready to read offline.",
      "icon": Icons.bookmark,
      "time": "30 min ago",
    },
    {
      "title": "Daily Digest",
      "message": "Here’s your personalized news summary.",
      "icon": Icons.view_day,
      "time": "1 hr ago",
    },
    {
      "title": "Reminder",
      "message": "Don’t miss today’s live press conference.",
      "icon": Icons.alarm,
      "time": "3 hr ago",
    },
    {
      "title": "Sports Update",
      "message": "Your favorite team won the match!",
      "icon": Icons.sports_soccer,
      "time": "5 hr ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // jumlah kolom
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notif = notifications[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${notif['title']} → ${notif['message']}"),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.15),
                        child: Icon(
                          notif["icon"],
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        notif["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notif["message"],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          notif["time"],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
