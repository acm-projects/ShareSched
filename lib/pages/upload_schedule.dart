import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/colors/app_colors.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreen createState() => _UploadScreen();
}

class _UploadScreen extends State<UploadScreen> {
  final ImagePicker picker = ImagePicker();
  File? _image;

  Future<void> takeImage() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
      // process image
    }
  }

  Future<void> uploadImage() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
      // process images
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          Container(
            alignment: Alignment.topCenter,
            child: const UploadText(),
          ),
          Container(
            alignment: Alignment.center,
            child: const ImageIcon(
              AssetImage('assets/page-1/images/ocr.png'),
              size: 500,
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TakePictureButton(buttonPressed: takeImage),
                  const SizedBox(
                    width: 20,
                  ),
                  UploadButton(buttonPressed: uploadImage),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class UploadText extends StatelessWidget {
  const UploadText({super.key});
  @override
  Widget build(BuildContext build) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 80),
        Text('Upload',
            style: GoogleFonts.quicksand(
                color: AppColors.primaryTextColor,
                fontSize: 32,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
        Text('Snap a photo of your schedule to auto-fill course details.',
            style: GoogleFonts.quicksand(
              color: AppColors.primaryTextColor,
              fontSize: 15,
            ))
      ],
    );
  }
}

class UploadButton extends StatelessWidget {
  final Function buttonPressed;

  const UploadButton({super.key, required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 180,
        height: 52,
        onPressed: () => buttonPressed(),
        color: AppColors.buttonColor1,
        textColor: AppColors.secondaryTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(color: Colors.black, width: 0.3),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.image,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Upload Picture',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 1.25,
              ),
            ),
          ],
        ));
  }
}

class TakePictureButton extends StatelessWidget {
  final Function buttonPressed;

  const TakePictureButton({super.key, required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 180,
        height: 52,
        onPressed: () => buttonPressed(),
        color: AppColors.buttonColor1,
        textColor: AppColors.secondaryTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(color: Colors.black, width: 0.3),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.camera_enhance,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Take Picture',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 1.25,
              ),
            ),
          ],
        ));
  }
}
