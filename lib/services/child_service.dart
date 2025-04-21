import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:school_van_tracker/models/child.dart';
import 'package:school_van_tracker/models/journey.dart';

class ChildService {
  final String? baseUrl = dotenv.env['API_URL'];

  Future<List<Child>> getChildren(String parentId, String token) async {
    // In a real app, this would make an API call
    // For demo purposes, we'll return mock data
    await Future.delayed(const Duration(seconds: 1));

    return [
      Child(
        id: 'child1',
        name: 'Annie Mali',
        schoolId: 'school1',
        schoolName: 'Springfield Elementary',
        grade: '3',
        section: 'A',
        parentId: parentId,
        imageUrl: 'https://i.pravatar.cc/150?img=44',
      ),
      Child(
        id: 'child2',
        name: 'Chris Tomlin',
        schoolId: 'school1',
        schoolName: 'Springfield Elementary',
        grade: '5',
        section: 'B',
        parentId: parentId,
        imageUrl: 'https://i.pravatar.cc/150?img=60',
      ),
    ];
  }

  Future<Journey?> getCurrentJourney(String childId, String token) async {
    // In a real app, this would make an API call
    // For demo purposes, we'll return mock data
    await Future.delayed(const Duration(seconds: 1));

    return Journey(
      id: 'journey1',
      childId: childId,
      vanId: 'van1',
      driverId: 'driver1',
      startTime: DateTime.now().subtract(const Duration(minutes: 15)),
      status: JourneyStatus.inTransit,
      startLocation: 'School',
      endLocation: 'Home',
      currentLocation: 'Luwuum Street',
      estimatedArrivalMinutes: 10,
      lastUpdated: DateTime.now(),
    );
  }

  Future<List<Journey>> getJourneyHistory(String childId, String token) async {
    // In a real app, this would make an API call
    // For demo purposes, we'll return mock data
    await Future.delayed(const Duration(seconds: 1));

    final now = DateTime.now();
    return List.generate(10, (index) {
      final isToSchool = index % 2 == 0;
      return Journey(
        id: 'journey_history_$index',
        childId: childId,
        vanId: 'van1',
        driverId: 'driver1',
        startTime:
            now.subtract(Duration(days: index, hours: isToSchool ? 8 : 15)),
        endTime: now.subtract(
            Duration(days: index, hours: isToSchool ? 7 : 14, minutes: 35)),
        status: JourneyStatus.completed,
        startLocation: isToSchool ? 'Home' : 'School',
        endLocation: isToSchool ? 'School' : 'Home',
        lastUpdated: now.subtract(
            Duration(days: index, hours: isToSchool ? 7 : 14, minutes: 35)),
      );
    });
  }
}
