enum NotificationType {
  arrival,
  journey,
  delay,
  checkin,
  route,
  driver,
  general
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;
  final String? relatedId; // Could be journey ID, child ID, etc.

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.type,
    this.relatedId,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['is_read'] ?? false,
      type: _parseType(json['type']),
      relatedId: json['related_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
      'type': type.toString().split('.').last,
      'related_id': relatedId,
    };
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  static NotificationType _parseType(String type) {
    switch (type.toLowerCase()) {
      case 'arrival':
        return NotificationType.arrival;
      case 'journey':
        return NotificationType.journey;
      case 'delay':
        return NotificationType.delay;
      case 'checkin':
        return NotificationType.checkin;
      case 'route':
        return NotificationType.route;
      case 'driver':
        return NotificationType.driver;
      default:
        return NotificationType.general;
    }
  }
}

