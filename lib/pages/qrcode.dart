import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/colors/app_colors.dart';

class QRScreen extends StatelessWidget {
  @override
  const QRScreen({super.key});

  Widget build(BuildContext build) {
    return Scaffold(
      body: Stack(children: [
        const Positioned(
          top: 70,
          child: NameWidget(),
        ),
        const SizedBox(
          height: 200,
        ),
        IconWidget(),
      ]),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  Widget build(BuildContext build) {
    return const Text('QR Code',
        style: TextStyle(
          fontSize: 32,
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.bold,
        ));
  }
}

class IconWidget extends StatelessWidget {
  @override
  IconWidget({super.key});

  Widget build(BuildContext build) {
    return const Icon(
      Icons.qr_code,
      size: 300,
      color: Colors.white,
    );
  }
}
