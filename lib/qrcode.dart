import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QR Code Generator and Scanner",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey globalKey = GlobalKey();
  String qrData = "";

  Future<void> scanQRCode() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        qrData = result.rawContent ?? "";
      });
    } on Exception catch (e) {
      // Handle exceptions
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: qrData.isEmpty
                      ? Text(
                    "Enter Username / Scan QR",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                      : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3.0),
                    ),
                    child: QrImage(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 175,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Data",
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  setState(() {
                    qrData = value;
                  });
                },
              ),

            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {

              },
              child: Text("SAVE"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: scanQRCode,
              child: Text("SCAN QR CODE"),
            ),
          ],
        ),
      ),
    );
  }
}
