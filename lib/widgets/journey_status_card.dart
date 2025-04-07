import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_van_tracker/models/journey.dart';

class JourneyStatusCard extends StatelessWidget {
  final Journey journey;

  const JourneyStatusCard({
    super.key,
    required this.journey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Journey Status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              const Text(
                'Current Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(journey.status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getStatusText(journey.status),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              const Text(
                'Current Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                journey.currentLocation ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              const Text(
                'Estimated Arrival Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                journey.estimatedArrivalMinutes != null
                    ? '${journey.estimatedArrivalMinutes} minutes'
                    : 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Last Updated: ${DateFormat('hh:mm:ss a').format(journey.lastUpdated)}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(JourneyStatus status) {
    switch (status) {
      case JourneyStatus.scheduled:
        return Colors.blue;
      case JourneyStatus.inTransit:
        return Colors.purple;
      case JourneyStatus.completed:
        return Colors.green;
      case JourneyStatus.cancelled:
        return Colors.red;
      case JourneyStatus.delayed:
        return Colors.orange;
    }
  }

  String _getStatusText(JourneyStatus status) {
    switch (status) {
      case JourneyStatus.scheduled:
        return 'Scheduled';
      case JourneyStatus.inTransit:
        return 'In Transit';
      case JourneyStatus.completed:
        return 'Completed';
      case JourneyStatus.cancelled:
        return 'Cancelled';
      case JourneyStatus.delayed:
        return 'Delayed';
    }
  }
}

