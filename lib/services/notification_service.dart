// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:school_van_tracker/models/notification.dart';

class NotificationService {
  // final String? baseUrl = dotenv.env['API_URL'];
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // static final NotificationService _instance = NotificationService._internal();

  // factory NotificationService() {
  //   return _instance;
  // }

  // NotificationService._internal();

  // Future<void> init() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  //   const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //   );

  //   const InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //   );

  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //   );
  // }

  // Future<void> showNotification({
  //   required String title,
  //   required String body,
  //   String? payload,
  // }) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'school_van_tracker_channel',
  //     'School Van Tracker Notifications',
  //     channelDescription: 'Notifications from School Van Tracker app',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showWhen: true,
  //   );

  //   const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );

  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     title,
  //     body,
  //     platformChannelSpecifics,
  //     payload: payload,
  //   );
  // }

  Future<List<AppNotification>> getNotifications(String token) async {
    // In a real app, this would make an API call
    // For demo purposes, we'll return mock data
    await Future.delayed(const Duration(seconds: 1));

    final now = DateTime.now();
    return [
      AppNotification(
        id: '1',
        title: 'Van Arrived',
        message: 'Your child\'s van has arrived at school.',
        timestamp: now.subtract(const Duration(minutes: 10)),
        isRead: false,
        type: NotificationType.arrival,
      ),
      AppNotification(
        id: '2',
        title: 'Journey Started',
        message:
            'Annie Mali has boarded the van. The journey to home has started.',
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: true,
        type: NotificationType.journey,
      ),
      AppNotification(
        id: '3',
        title: 'Delay Alert',
        message: 'The van is experiencing a 10-minute delay due to traffic.',
        timestamp: now.subtract(const Duration(hours: 5)),
        isRead: true,
        type: NotificationType.delay,
      ),
      AppNotification(
        id: '4',
        title: 'Check-in Confirmation',
        message: 'Chris Tomlin has been checked in for the morning journey.',
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
        type: NotificationType.checkin,
      ),
      AppNotification(
        id: '5',
        title: 'Route Change',
        message:
            'The van route has been slightly modified due to road construction.',
        timestamp: now.subtract(const Duration(days: 1, hours: 5)),
        isRead: true,
        type: NotificationType.route,
      ),
      AppNotification(
        id: '6',
        title: 'Driver Change',
        message: 'A new driver has been assigned to your child\'s van route.',
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: true,
        type: NotificationType.driver,
      ),
    ];
  }

  Future<void> markAsRead(String notificationId, String token) async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> markAllAsRead(String token) async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(seconds: 1));
  }
}
