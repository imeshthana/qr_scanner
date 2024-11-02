import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QR Scanner',
      home: MyHomePage(title: 'QR Code Scanner'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String qrData = 'Unknown';

  @override
  void dispose() {
    super.dispose();
  }

  void scanQr() {
    try {
      FlutterBarcodeScanner.scanBarcode(
        '#2196F3',
        'Cancel',
        true,
        ScanMode.QR,
      ).then((scannedData) {
        if (scannedData.toString() == "-1") {
          setState(() {
            qrData = "No any QR detected";
          });
        } else {
          setState(() {
            qrData = scannedData;
          });
        }
        showAlert(qrData);
      });
    } catch (e) {
      setState(() {
        qrData = 'Error scanning QR';
      });
    }
  }

  void showAlert(String? scannedData) {
    if (scannedData != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Scanned Data'),
            content: Text(scannedData),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: scanQr,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text('Tap to scan'),
            )
          ],
        ),
      ),
    );
  }
}
