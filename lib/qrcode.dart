import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class QRCodePage extends StatelessWidget {
  final String qrData;

  const QRCodePage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            RepaintBoundary(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    children: [
                      QrImage(
                        backgroundColor: Colors.blue,
                        data: qrData,
                        version: QrVersions.auto,
                        size: 250,
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "GENERATED QR CODE",
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {

                        },
                        child: Text("SAVE",
                            style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 16,)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

