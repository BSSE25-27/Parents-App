import 'package:flutter/material.dart';
import 'package:school_van_tracker/widgets/bottom_navigation.dart';

class MyChildrenScreen extends StatelessWidget {
  const MyChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for children
    final List<Map<String, dynamic>> children = [
      {
        'name': 'Annie Mali',
        'studentId': 'STU-2023-001',
        'grade': 'Grade 3',
        'age': '8 years',
        'avatar': 'https://i.pravatar.cc/150?img=32',
        'school': 'Greenfield Elementary School',
        'pickupTime': '3:30 PM',
        'dropTime': '4:15 PM',
      },
      {
        'name': 'Chris Tomlin',
        'studentId': 'STU-2023-002',
        'grade': 'Grade 5',
        'age': '10 years',
        'avatar': 'https://i.pravatar.cc/150?img=12',
        'school': 'Greenfield Elementary School',
        'pickupTime': '3:30 PM',
        'dropTime': '4:30 PM',
      },
    ];

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Children',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Total: ${children.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Children list
              ...children.map((child) => buildChildCard(context, child)).toList(),
              
              const SizedBox(height: 20),
              
              // Add child button
            //   SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton.icon(
            //       onPressed: () {
            //         // Add child functionality would go here
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(
            //             content: Text('Add child functionality coming soon!'),
            //           ),
            //         );
            //       },
            //       icon: const Icon(Icons.add),
            //       label: const Text('Add Child'),
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(vertical: 12),
            //       ),
            //     ),
            //   ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }
  
  Widget buildChildCard(BuildContext context, Map<String, dynamic> child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        children: [
          // Header with avatar and name
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(child['avatar']),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Student ID: ${child['studentId']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                // IconButton(
                //   icon: const Icon(Icons.edit_outlined),
                //   onPressed: () {
                //     // Edit child functionality would go here
                //   },
                // ),
              ],
            ),
          ),
          
          // Child details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildInfoRow(context, 'Grade', child['grade']),
                const SizedBox(height: 8),
                buildInfoRow(context, 'Age', child['age']),
                const SizedBox(height: 8),
                buildInfoRow(context, 'School', child['school']),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: buildInfoRow(context, 'Pickup', child['pickupTime']),
                    ),
                    Expanded(
                      child: buildInfoRow(context, 'Drop-off', child['dropTime']),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/track');
                        },
                        icon: const Icon(Icons.location_on),
                        label: const Text('Track'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 12),
                    // Expanded(
                    //   child: ElevatedButton.icon(
                    //     onPressed: () {
                    //       // Call driver functionality would go here
                    //     },
                    //     icon: const Icon(Icons.phone),
                    //     label: const Text('Call Driver'),
                    //     style: ElevatedButton.styleFrom(
                    //       padding: const EdgeInsets.symmetric(vertical: 12),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}