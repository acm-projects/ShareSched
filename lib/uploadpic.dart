import 'package:flutter/material.dart';
import 'package:login_screen_sharesched/newuser.dart';
import 'package:image_picker/image_picker.dart';

class uploadpic extends StatefulWidget {
  @override
  _uploadpic createState() => _uploadpic();
}
class _uploadpic extends State<uploadpic> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(

            // Back arrow button for the page where user uploads picture

            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => newuser(),
              ),
              );
            },
          ),

          //App bar of the page

          backgroundColor: Colors.blue[800],
          title: Text('Upload Schedule',
              style: TextStyle(color: Colors.white)),
        ),

        // Button that allows the user to upload picture from their camera roll

        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: IconButton(
                  icon: Icon(Icons.photo_album, size: 80),
                  onPressed : () {},
                ),
              ),

              SizedBox(
                height: 5.0,

              // Button so user can take a picture of their schedule

              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: IconButton(
                  icon: Icon(Icons.camera_alt, size: 80),
                  onPressed : () {},
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}


