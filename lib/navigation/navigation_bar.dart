import 'package:flutter/material.dart';
import 'package:myapp/pages/custom_widgets.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/friends.dart';
import 'package:myapp/pages/qrcode.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _currentIndex = 0;

  final Screens = [
    const HomeScreen(),
    FriendScreen(),
    const QRScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[_currentIndex],
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 60,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              _buildNavItem(
                  0,
                  const ImageIcon(
                      AssetImage('assets/page-1/images/custom/home2.png')),
                  'Home'),
              const SizedBox(
                width: 20,
              ),
              _buildNavItem(
                  1, const Icon(Icons.group_outlined, size: 30), 'Friends'),
              _buildNavItem(2, const Icon(Icons.qr_code_outlined), 'QR'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, Widget icon, String label) {
    Color iconColor = _currentIndex == index
        ? const Color.fromARGB(255, 57, 60, 245)
        : const Color.fromARGB(255, 141, 141, 141);

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTheme(
                data: IconThemeData(color: iconColor),
                child: icon,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: _currentIndex == index ? 8 : 0,
                child: const SizedBox(width: 8), // space between icon and text
              ),
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  color: _currentIndex == index
                      ? const Color.fromARGB(255, 57, 60, 245)
                      : Colors.transparent,
                  fontSize: 14,
                ),
                duration: const Duration(milliseconds: 250),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
