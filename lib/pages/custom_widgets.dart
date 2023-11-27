import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/pages/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  bool? isOnProfilePage;
  CustomAppBar({super.key, this.isOnProfilePage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Image.asset(
        'assets/page-1/images/custom/logo_2.png',
        fit: BoxFit.cover,
        height: 40,
      ),
      actions: <Widget>[
        if (!isOnProfilePage!)
          (IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
          ))
      ],
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      bottomOpacity: 20,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;
  final Alignment alignment;
  final String logoText;
  const LogoWidget(
      {super.key,
      this.height = 300,
      this.width = 300,
      this.logoText = "ShareSched",
      this.alignment = Alignment.center});

  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
          height: height,
          width: width,
          child: Stack(
            alignment: alignment,
            children: [
              Image.asset('assets/page-1/images/custom/logo.png'),
              Text(
                logoText,
                style: GoogleFonts.quicksand(
                    fontSize: 28,
                    height: 14.5,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.w300),
              ),
            ],
          )),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("Background widget building");
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color.fromRGBO(0, 0, 0, 1), Color.fromRGBO(53, 51, 205, 1)],
        ),
      ),
    );
  }
}

class BackgroundWidget2 extends StatelessWidget {
  const BackgroundWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    print("Background widget 2 building");
    return Container(
        height: double.infinity, width: double.infinity, color: Colors.black);
  }
}

class BackgroundWidget3 extends StatelessWidget {
  const BackgroundWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    print("Background widget building");
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 0, 11, 24),
            Color.fromARGB(255, 0, 23, 45),
            Color.fromARGB(255, 0, 39, 77),
            Color.fromARGB(255, 2, 56, 110)
          ],
        ),
      ),
    );
  }
}



class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 12.0,
    this.color = AppColors.primaryTextColor,
    this.fontWeight = FontWeight.bold,
    this.letterSpacing = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Quicksand',
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}