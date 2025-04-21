import 'package:flutter/material.dart';
import 'package:school_van_tracker/models/notification.dart';

class NotificationProvider with ChangeNotifier {
  List<AppNotification> _notifications = [];
  bool _isLoading = false;
  int _unreadCount = 0;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _unreadCount;

  Future<void> fetchNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would make an API call
      // For demo purposes, we'll use mock data
      await Future.delayed(const Duration(seconds: 1));

      final now = DateTime.now();
      _notifications = [
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

      _updateUnreadCount();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        final notification = _notifications[index];
        if (!notification.isRead) {
          // In a real app, this would make an API call
          await Future.delayed(const Duration(milliseconds: 300));

          final updatedNotification = AppNotification(
            id: notification.id,
            title: notification.title,
            message: notification.message,
            timestamp: notification.timestamp,
            isRead: true,
            type: notification.type,
            relatedId: notification.relatedId,
          );

          _notifications[index] = updatedNotification;
          _updateUnreadCount();
          notifyListeners();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAllAsRead() async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would make an API call
      await Future.delayed(const Duration(seconds: 1));

      _notifications = _notifications.map((notification) {
        return AppNotification(
          id: notification.id,
          title: notification.title,
          message: notification.message,
          timestamp: notification.timestamp,
          isRead: true,
          type: notification.type,
          relatedId: notification.relatedId,
        );
      }).toList();

      _updateUnreadCount();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _updateUnreadCount() {
    _unreadCount = _notifications.where((n) => !n.isRead).length;
  }
}
