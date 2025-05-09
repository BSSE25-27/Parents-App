import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:school_van_tracker/widgets/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert';

class TrackChildScreen extends StatefulWidget {
  const TrackChildScreen({super.key});

  @override
  State<TrackChildScreen> createState() => _TrackChildScreenState();
}

class ChildLocation {
  final double? currentLatitude;
  final double? currentLongitude;
  final int? childID;
  final String? ChildName;
  final bool? hasLocation;

  ChildLocation({
    required this.currentLatitude,
    required this.currentLongitude,
    required this.childID,
    required this.ChildName,
    required this.hasLocation,
  });
}

class _TrackChildScreenState extends State<TrackChildScreen> {
  late GoogleMapController _mapController;
  static const LatLng _initialLocation = LatLng(0.3476, 32.5825); // Kampala
  LatLng _childLocation = _initialLocation;
  String parentName = 'Loading...';
  String parentEmail = 'loading...';
  ChildLocation childLocation = ChildLocation(
      currentLatitude: 0.0,
      currentLongitude: 0.0,
      childID: 0,
      ChildName: 'Loading...',
      hasLocation: false);
  Timer? _refreshTimer;
  bool _isRefreshing = false;
  DateTime? _lastUpdated;

  @override
  void initState() {
    super.initState();
    _loadParentData();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    const checkDuration = Duration(seconds: 10);
    _refreshTimer = Timer.periodic(checkDuration, (timer) {
      _refreshLocation();
    });
    // Initial refresh
    _refreshLocation();
  }

  Future<void> _loadParentData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      parentName = prefs.getString('parent_name') ?? 'Parent Name';
      parentEmail = prefs.getString('email') ?? 'email@example.com';
    });
  }

  Future<void> _refreshLocation() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      await _getChildLocation();
      setState(() {
        _lastUpdated = DateTime.now();
      });
    } catch (e) {
      print('Refresh error: $e');
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  Future<void> _getChildLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final childId = prefs.getInt('ChildID');

      if (childId == null) {
        print('ChildID not found in SharedPreferences');
        return;
      }

      final response = await http.get(
        Uri.parse('$serverUrl/api/child-location?ChildID=$childId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final responseData = json.decode(response.body);

      setState(() {
        childLocation = ChildLocation(
          currentLatitude:
              double.parse(responseData['childLocation']['current_latitude']),
          currentLongitude:
              double.parse(responseData['childLocation']['current_longitude']),
          childID: responseData['childLocation']['ChildID'],
          ChildName: responseData['childLocation']['ChildName'],
          hasLocation: responseData['childLocation']['has_location'],
        );
        _childLocation = LatLng(
            childLocation.currentLatitude!, childLocation.currentLongitude!);
      });

      // Move camera to new location
      _mapController.animateCamera(
        CameraUpdate.newLatLng(_childLocation),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: Image.asset('assets/images/logo.png').image,
            ),
            const SizedBox(width: 8),
            const Text('BTrack', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: _isRefreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshLocation,
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _childLocation,
              zoom: 15,
            ),
            onMapCreated: _onMapCreated,
            markers: {
              Marker(
                markerId: const MarkerId('child'),
                position: _childLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
                infoWindow: InfoWindow(title: childLocation.ChildName),
              ),
            },
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                _zoomButton(Icons.add, _zoomIn),
                const SizedBox(height: 8),
                _zoomButton(Icons.remove, _zoomOut),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _lastUpdated != null
                        ? 'Updated: ${_lastUpdated!.toLocal().toString().substring(11, 16)}'
                        : 'Updating...',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }

  Widget _zoomButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://ui-avatars.com/api/?name=${Uri.encodeComponent(parentName)}&background=random',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  parentName,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  parentEmail,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.child_care),
            title: const Text('My Children'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/my-children');
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Journey History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/journey-history');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('api_key');
              await prefs.remove('parent_name');
              await prefs.remove('email');
              if (!mounted) return;
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
