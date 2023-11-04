import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrScreenState();
}


class _QrScreenState extends State<QrPage> {
  final GlobalKey globalKey = GlobalKey();
  String qrData = "";
  String scannedData = "";

  TextStyle textStyle = GoogleFonts.quicksand(
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );


  void onGenerateButtonPressed() {
    final random = Random();
    final randomString = String.fromCharCodes(
      List.generate(10, (index) => random.nextInt(26) + 65),
    );

    setState(() {
      qrData = randomString;
    });
  }


  Future<void> scanQRCode() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        scannedData = result.rawContent ?? "";
      });
    } on Exception catch (e) {
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
            const SizedBox(
              height: 140,
            ),
            Text("ShareSched QR",
              style: textStyle,
            ),
            SizedBox(height: 32),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: qrData.isEmpty
                      ? SizedBox.shrink()
                      : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: QrImage(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 175,
                      foregroundColor: Colors.blue[800],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            GenerateButton(onGenerateButtonPressed),
            SizedBox(height: 15),
            ScanQRButton(scanQRCode),
            SizedBox(height: 20),
            if (scannedData.isNotEmpty)
              ScannedDataContainer(scannedData),
          ],
        ),
      ),
    );
  }
}



class GenerateButton extends StatelessWidget {
  final VoidCallback onPressed;

  GenerateButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[900],
      ),
      child: Text("GENERATE",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}



class ScanQRButton extends StatelessWidget {
  final VoidCallback onPressed;

  ScanQRButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[900],
      ),
      child: Text("SCAN QR CODE",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}



class ScannedDataContainer extends StatelessWidget {
  final String scannedData;

  ScannedDataContainer(this.scannedData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
      ),
      child: Text("Scanned Data: $scannedData",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
