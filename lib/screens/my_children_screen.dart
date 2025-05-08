import 'package:flutter/material.dart';
import 'package:school_van_tracker/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class MyChildrenScreen extends StatefulWidget {
  const MyChildrenScreen({super.key});

  @override
  State<MyChildrenScreen> createState() => _MyChildrenScreenState();
}

class _MyChildrenScreenState extends State<MyChildrenScreen> {
  List<dynamic> children = [];
  bool isLoading = true;
  String errorMessage = '';
  String parentName = 'Parent';

  @override
  void initState() {
    super.initState();
    _loadParentData();
    _fetchChildren();
  }

  Future<void> _loadParentData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      parentName = prefs.getString('parent_name') ?? 'Parent';
    });
  }

  Future<void> _fetchChildren() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final apiKey = prefs.getString('api_key');
      final parentId = prefs.getString('parent_id');

      if (apiKey == null || parentId == null) {
        throw Exception('Not authenticated');
      }

      final response = await http.get(
        Uri.parse('$serverUrl/api/parent-children?ParentID=$parentId'),
        headers: {
          'X-API-KEY': apiKey,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          children = responseData['children'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load children data');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> trackChildLocation(int childID) async {
    try {
      print(childID);
      final prefs = await SharedPreferences.getInstance();

      prefs.setInt('ChildID', childID);
      Navigator.pushNamed(
        context,
        '/track',
        arguments: {'childId': childID},
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
            ),
            SizedBox(width: 8),
            Text('BTrack', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$parentName\'s Children',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (errorMessage.isNotEmpty)
                Center(child: Text(errorMessage))
              else if (children.isEmpty)
                const Center(child: Text('No children registered'))
              else
                ...children.map((child) => _buildChildCard(child)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildChildCard(Map<String, dynamic> child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://ui-avatars.com/api/?name=${Uri.encodeComponent(child['ChildName'])}&background=random',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child['ChildName'] ?? 'Child',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${child['ChildID']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  trackChildLocation(child['ChildID']);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Track Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
