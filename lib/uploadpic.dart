import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'qrcode.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: UploadPic(),
  ));
}

class UploadPic extends StatefulWidget {
  const UploadPic({Key? key}) : super(key: key);

  @override
  State<UploadPic> createState() => UploadPicState();
}

class UploadPicState extends State<UploadPic> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Your Schedule',
          style: GoogleFonts.exo(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageFile != null)
              Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: FileImage(imageFile!),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(width: 8, color: Colors.black),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              )
            else
              Container(
                width: 600,
                height: 440,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(width: 8, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Image',
                  style: GoogleFonts.exo(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => getImage(source: ImageSource.camera),
                    child: Text(
                      'Capture Image',
                      style: GoogleFonts.exo(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => getImage(source: ImageSource.gallery),
                    child: Text(
                      'Select Image',
                      style: GoogleFonts.exo(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Add the "Next" ElevatedButton below the existing buttons
            ElevatedButton(
              onPressed: () {
                if (imageFile != null) {
                  final imageData = imageFile!.readAsBytesSync();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DemoApp(imageData: imageData),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please select an image before submitting."),
                    ),
                  );
                }
              },
              child: Text(
                'Submit',
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

  void getImage({required ImageSource source}) async {
    final imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(
      source: source,
      maxWidth: 640,
      maxHeight: 480,
      imageQuality: 70,
    );

    if (file?.path != null) {
      final savedFile = File(file!.path);
      setState(() {
        imageFile = savedFile;
      });
    }
  }
}

