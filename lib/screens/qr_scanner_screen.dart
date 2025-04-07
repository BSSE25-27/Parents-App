import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:school_van_tracker/widgets/bottom_navigation.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  // Information to be embedded in the QR code
  String qrData = """
Parent Name: Kate Winslet
Parent Contact: +256700123456
Child ID: CHD12345
Child Name: Ann Mali
Child Class: Primary 4
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('QR Code Generator',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // QR Code with embedded information
            PrettyQrView.data(
              data: qrData,
              decoration: const PrettyQrDecoration(),
            ),
            const SizedBox(height: 24),

            // Button to generate a new QR Code (Optional)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  qrData = """
                    Parent Name: Kate Winslet
                    Parent Contact: +256771278951
                    Child ID: CHD67890
                    Child Name: Chris Tomlin
                    Child Class: Primary 3
                    """; // Example of dynamically changing the QR code data
                });
              },
              child: const Text("Scan QR Code"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
    );
  }
}
