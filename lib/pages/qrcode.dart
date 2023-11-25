import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/providers/user_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QrScreen extends ConsumerStatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  ConsumerState<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends ConsumerState<QrScreen> {
  String qrData = "";
  String scannedData = "";
  User? user;

  TextStyle textStyle = const TextStyle(
      fontSize: 32,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Quicksand-SemiBold');

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    generateQrData();
  }

  Future<void> generateQrData() async {
    final email = ref.read(userModelProvider).email;
    print(email);
    final userDocID = ref.read(userModelProvider).userDocID;
    print("Grabbed the document ID for ${email}: ${userDocID}");
    if (userDocID.isNotEmpty) {
      setState(() {
        qrData = userDocID;
      });
    } else {
      print("No document found for the specified email");
    }
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            Text(
              "QR",
              style: textStyle,
            ),
            const SizedBox(height: 60),
            RepaintBoundary(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: qrData.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            size: 175,
                            foregroundColor: Colors.blue[800],
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Share your schedule by having your friends scan this!",
              style: TextStyle(
                  fontFamily: 'Quicksand', color: AppColors.primaryTextColor),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 20),
            if (scannedData.isNotEmpty) ScannedDataContainer(scannedData),
          ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
      ),
      child: Text(
        "Scanned Data: $scannedData",
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
