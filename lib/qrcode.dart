import 'dart:async';
import 'package:google_fonts/google_fonts.dart';


import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    final message = 'Scan QR Code';

    Future<ui.Image> _loadImage() async {
      final completer = Completer<ui.Image>();
      final data = await rootBundle.load('assets/images/logo.png');
      ui.decodeImageFromList(data.buffer.asUint8List(), completer.complete);

      return completer.future;
    }

    final qrCode = FutureBuilder(
      future: _loadImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(
            color: Colors.grey,
            height: size,
            width: size,
          );
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            color: Colors.black,
            emptyColor: Colors.white70,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(50),
            ),
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 280,
              child: qrCode,
            ),
            SizedBox(height: 30),
            Text(
              message,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // Add your button's onPressed logic here
              },
              child: Text(
                'Next',
                style: GoogleFonts.exo(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
