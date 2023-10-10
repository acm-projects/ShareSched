import 'package:flutter/material.dart';
import 'newuser.dart';
import 'uploadpic.dart';
import 'package:google_fonts/google_fonts.dart';




void main() {
  runApp(
      MaterialApp(
        home: MyApp(),
      ));
}

class MyApp extends StatefulWidget {

  const MyApp( {Key? key}) : super(key: key);

    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ShareSched'),
          backgroundColor: Colors.blue[800]
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login to ShareSched',
              style: GoogleFonts.exo(
                fontSize: 31,
                color: Colors.blue[800],
                fontWeight: FontWeight.bold,
              ),
            ),


            SizedBox(height: 50,),


            // Asking user to enter their email address in the given box
            Form(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: 'Enter email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String Value) {

                      },
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Email' : null;
                      },
                    ),
                  ),


                  SizedBox(height: 30,),


                  // Asking user to enter their password in the box

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: 'Enter password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String Value) {

                      },
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Password' : null;
                      },
                    ),
                  ),

                  SizedBox(height: 10,),


                  // Option to create an account

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => newuser(),
                        ),
                        );

                      },

                      child: Text('Create an account'),
                    ),
                  ),


                  // Login button

                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {},
                      child: Text('Login'),
                      color: Colors.blue[800],
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )

          ]
        ),
      ),
    );
  }
}