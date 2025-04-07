import 'package:flutter/material.dart';
import 'package:school_van_tracker/widgets/bottom_navigation.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notification data
    final notifications = [
      {
        'title': 'Van Arrived',
        'message': 'Your child\'s van has arrived at school.',
        'time': '10 minutes ago',
        'isRead': false,
        'type': 'arrival',
      },
      {
        'title': 'Journey Started',
        'message': 'Annie Mali has boarded the van. The journey to home has started.',
        'time': '2 hours ago',
        'isRead': true,
        'type': 'journey',
      },
      {
        'title': 'Delay Alert',
        'message': 'The van is experiencing a 10-minute delay due to traffic.',
        'time': '5 hours ago',
        'isRead': true,
        'type': 'delay',
      },
      {
        'title': 'Check-in Confirmation',
        'message': 'Chris Tomlin has been checked in for the morning journey.',
        'time': 'Yesterday',
        'isRead': true,
        'type': 'checkin',
      },
      {
        'title': 'Route Change',
        'message': 'The van route has been slightly modified due to road construction.',
        'time': 'Yesterday',
        'isRead': true,
        'type': 'route',
      },
      {
        'title': 'Driver Change',
        'message': 'A new driver has been assigned to your child\'s van route.',
        'time': '2 days ago',
        'isRead': true,
        'type': 'driver',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                IconData iconData;
                Color iconColor;

                // Determine icon and color based on notification type
                switch (notification['type']) {
                  case 'arrival':
                    iconData = Icons.location_on;
                    iconColor = Colors.green;
                    break;
                  case 'journey':
                    iconData = Icons.directions_bus;
                    iconColor = Theme.of(context).primaryColor;
                    break;
                  case 'delay':
                    iconData = Icons.access_time;
                    iconColor = Colors.orange;
                    break;
                  case 'checkin':
                    iconData = Icons.check_circle;
                    iconColor = Colors.blue;
                    break;
                  case 'route':
                    iconData = Icons.map;
                    iconColor = Colors.indigo;
                    break;
                  case 'driver':
                    iconData = Icons.person;
                    iconColor = Colors.teal;
                    break;
                  default:
                    iconData = Icons.notifications;
                    iconColor = Colors.grey;
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: notification['isRead'] as bool ? Colors.white : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: iconColor.withOpacity(0.1),
                      child: Icon(
                        iconData,
                        color: iconColor,
                      ),
                    ),
                    title: Text(
                      notification['title'] as String,
                      style: TextStyle(
                        fontWeight: notification['isRead'] as bool ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(notification['message'] as String),
                        const SizedBox(height: 4),
                        Text(
                          notification['time'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: notification['isRead'] as bool
                        ? null
                        : Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                  ),
                );
              },
            ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }
}

