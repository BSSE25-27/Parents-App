import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:school_van_tracker/widgets/bottom_navigation.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  String qrData = "Loading parent data...";
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadParentData();
  }

  Future<void> _loadParentData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final parentId = prefs.getString('parent_id');
      final parentName = prefs.getString('parent_name');
      final phoneNumber = prefs.getString('phone_number');
      // final children = prefs.getStringList('children_names');

      if (parentId == null || parentName == null || phoneNumber == null) {
        throw Exception('Parent data not found');
      }

      // Ensure children data is properly handled

      setState(() {
        qrData = '''
      {
        "parent_id": "$parentId",
        "parent_name": "$parentName",
        "phone_number": "$phoneNumber",
      }
      ''';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My QR Code', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadParentData,
            tooltip: 'Refresh QR Code',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const CircularProgressIndicator()
              else if (errorMessage != null)
                Column(
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load parent data',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadParentData,
                      child: const Text('Retry'),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    const Text(
                      'Scan this QR code for verification',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: PrettyQrView.data(
                        data: qrData,
                        decoration: PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(
                            color: Theme.of(context).primaryColor,
                            roundFactor: 1,
                          ),
                          image: const PrettyQrDecorationImage(
                            image: AssetImage('assets/icons/van.png'),
                            position: PrettyQrDecorationImagePosition.embedded,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Show this QR code to the van operator for verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
    );
  }
}
