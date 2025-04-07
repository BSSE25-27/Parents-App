import 'package:intl/intl.dart';

enum JourneyStatus {
  scheduled,
  inTransit,
  completed,
  cancelled,
  delayed
}

class Journey {
  final String id;
  final String childId;
  final String vanId;
  final String driverId;
  final DateTime startTime;
  final DateTime? endTime;
  final JourneyStatus status;
  final String startLocation;
  final String endLocation;
  final String? currentLocation;
  final int? estimatedArrivalMinutes;
  final DateTime lastUpdated;

  Journey({
    required this.id,
    required this.childId,
    required this.vanId,
    required this.driverId,
    required this.startTime,
    this.endTime,
    required this.status,
    required this.startLocation,
    required this.endLocation,
    this.currentLocation,
    this.estimatedArrivalMinutes,
    required this.lastUpdated,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'],
      childId: json['child_id'],
      vanId: json['van_id'],
      driverId: json['driver_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      status: _parseStatus(json['status']),
      startLocation: json['start_location'],
      endLocation: json['end_location'],
      currentLocation: json['current_location'],
      estimatedArrivalMinutes: json['estimated_arrival_minutes'],
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child_id': childId,
      'van_id': vanId,
      'driver_id': driverId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'status': status.toString().split('.').last,
      'start_location': startLocation,
      'end_location': endLocation,
      'current_location': currentLocation,
      'estimated_arrival_minutes': estimatedArrivalMinutes,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  String get formattedLastUpdated {
    return DateFormat('hh:mm:ss a').format(lastUpdated);
  }

  static JourneyStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return JourneyStatus.scheduled;
      case 'in_transit':
      case 'intransit':
        return JourneyStatus.inTransit;
      case 'completed':
        return JourneyStatus.completed;
      case 'cancelled':
        return JourneyStatus.cancelled;
      case 'delayed':
        return JourneyStatus.delayed;
      default:
        return JourneyStatus.scheduled;
    }
  }
}

