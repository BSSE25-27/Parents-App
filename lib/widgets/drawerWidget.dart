// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Widget _buildDrawer(BuildContext context) {
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         DrawerHeader(
//           decoration: BoxDecoration(color: Theme.of(context).primaryColor),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   'https://ui-avatars.com/api/?name=${Uri.encodeComponent(parentName)}&background=random',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 parentName,
//                 style: const TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               Text(
//                 parentEmail,
//                 style: const TextStyle(color: Colors.white70, fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//         ListTile(
//           leading: const Icon(Icons.home),
//           title: const Text('Home'),
//           onTap: () => Navigator.pop(context),
//         ),
//         ListTile(
//           leading: const Icon(Icons.child_care),
//           title: const Text('My Children'),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.pushNamed(context, '/my-children');
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.notifications),
//           title: const Text('Notifications'),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.pushNamed(context, '/notifications');
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.history),
//           title: const Text('Journey History'),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.settings),
//           title: const Text('Settings'),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.pushNamed(context, '/settings');
//           },
//         ),
//         const Divider(),
//         ListTile(
//           leading: const Icon(Icons.logout),
//           title: const Text('Logout'),
//           onTap: () async {
//             final prefs = await SharedPreferences.getInstance();
//             await prefs.remove('api_key');
//             await prefs.remove('parent_id');
//             await prefs.remove('parent_name');
//             await prefs.remove('email');
//             Navigator.pop(context);
//             Navigator.pushReplacementNamed(context, '/login');
//           },
//         ),
//       ],
//     ),
//   );
// }
