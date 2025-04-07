import 'package:flutter/material.dart';
import 'package:school_van_tracker/models/child.dart';
import 'package:school_van_tracker/models/journey.dart';
import 'package:school_van_tracker/services/child_service.dart';

class ChildProvider with ChangeNotifier {
  List<Child> _children = [];
  Child? _selectedChild;
  Journey? _currentJourney;
  List<Journey> _journeyHistory = [];
  bool _isLoading = false;
  bool _isLoadingJourney = false;

  final ChildService _childService = ChildService();

  List<Child> get children => _children;
  Child? get selectedChild => _selectedChild;
  Journey? get currentJourney => _currentJourney;
  List<Journey> get journeyHistory => _journeyHistory;
  bool get isLoading => _isLoading;
  bool get isLoadingJourney => _isLoadingJourney;

  Future<void> fetchChildren(String parentId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would make an API call
      // For demo purposes, we'll use mock data
      await Future.delayed(const Duration(seconds: 1));
      
      _children = [
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
      
      if (_children.isNotEmpty && _selectedChild == null) {
        _selectedChild = _children.first;
        await fetchCurrentJourney(_selectedChild!.id);
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCurrentJourney(String childId) async {
    _isLoadingJourney = true;
    notifyListeners();

    try {
      // In a real app, this would make an API call
      // For demo purposes, we'll use mock data
      await Future.delayed(const Duration(seconds: 1));
      
      _currentJourney = Journey(
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
    } catch (e) {
      _currentJourney = null;
      rethrow;
    } finally {
      _isLoadingJourney = false;
      notifyListeners();
    }
  }

  Future<void> fetchJourneyHistory(String childId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would make an API call
      // For demo purposes, we'll use mock data
      await Future.delayed(const Duration(seconds: 1));
      
      final now = DateTime.now();
      _journeyHistory = List.generate(10, (index) {
        final isToSchool = index % 2 == 0;
        return Journey(
          id: 'journey_history_$index',
          childId: childId,
          vanId: 'van1',
          driverId: 'driver1',
          startTime: now.subtract(Duration(days: index, hours: isToSchool ? 8 : 15)),
          endTime: now.subtract(Duration(days: index, hours: isToSchool ? 7 : 14, minutes: 35)),
          status: JourneyStatus.completed,
          startLocation: isToSchool ? 'Home' : 'School',
          endLocation: isToSchool ? 'School' : 'Home',
          lastUpdated: now.subtract(Duration(days: index, hours: isToSchool ? 7 : 14, minutes: 35)),
        );
      });
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectChild(Child child) {
    _selectedChild = child;
    fetchCurrentJourney(child.id);
    notifyListeners();
  }
}

