import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/services/upload_image.dart';
import 'package:myapp/services/googleCloud.dart';
import 'custom_widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:logger/logger.dart';
import 'dart:convert';


class UploadScreen extends StatefulWidget {
  @override
  _UploadScreen createState() => _UploadScreen();
}

class _UploadScreen extends State<UploadScreen> {
  
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  final logger = Logger();
  final ImagePicker picker = ImagePicker();
  File? _image;
    bool textScanning = false;
    
  String scannedText = "";


  Future<void> takeImage() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
      //process image
    }
  }

  Future<void> uploadImage() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    Uint8List? bytes = await photo?.readAsBytes();
    if (photo != null) {
      textScanning = true;
      setState(() {
        _image = File(photo.path);
      });
      //process image
      // Convert bytes to base64-encoded string
    if (bytes != null) {
      String base64encoded = base64Encode(bytes);

      String resp = await StoreData().uploadImageToStorage('sched.png', bytes );
       
      Map<String, dynamic> visionRequest = createCloudVisionRequest(base64encoded);
      print(jsonEncode(visionRequest));
         
    }
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
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
        Text('Snap a photo of your schedule to auto-fill course details.',
            style: GoogleFonts.quicksand(
              color: Colors.white,
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
        color: const Color(0xFF1264D1),
        textColor: Colors.black,
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
        color: const Color(0xFF1264D1),
        textColor: Colors.black,
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