
// INCOMPLETE - CODE IS COMMENTED OUT





/*
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'uploadpic.dart';

void main() => runApp(QrCode());

class QrCode extends StatelessWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScanQr(),
    );
  }
}

*/
 /*
class ScanQr extends StatefulWidget {
  const ScanQr({Key? key}) : super(key: key);

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {


  @override
  Widget build(BuildContext context) {

    final message = "ShareSched QR";

    Future<ui.Image> _loadImage() async {
      final completer = Completer<ui.Image>();
      final data = await rootBundle.load('assets/among.png');
      ui.decodeImageFromList(data.buffer.asUint8List(),completer.complete);

      return completer.future;

    }

    final qrCode = FutureBuilder(builder: null);
    
    return Container();
  }
}

*/
