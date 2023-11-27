import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/pages/custom_widgets.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/friends.dart';
import 'package:myapp/pages/qrcode.dart';

class CustomNavigationBar extends ConsumerStatefulWidget {
  CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

final indexProvider = StateProvider(((ref) => 0));

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
  final Screens = [
    const HomeScreen(),
    FriendScreen(),
    const QrPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(indexProvider.notifier).state;
    ref.watch(indexProvider);
    return Scaffold(
      body: Screens[pageIndex],
      appBar: CustomAppBar(),
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
    final currentIndex = ref.watch(indexProvider.notifier).state;
    Color iconColor = currentIndex == index
        ? const Color.fromARGB(255, 57, 60, 245)
        : const Color.fromARGB(255, 141, 141, 141);

    return Expanded(
      child: InkWell(
        onTap: () {
          ref.read(indexProvider.notifier).state = index;
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
                width: ref.read(indexProvider.notifier).state == index ? 8 : 0,
                child: const SizedBox(width: 8), // space between icon and text
              ),
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  color: ref.read(indexProvider.notifier).state == index
                      ? AppColors.themeColor
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