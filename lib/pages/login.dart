import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/navigation/navigation_bar.dart';
import 'package:myapp/services/auth.dart';
import 'custom_widgets.dart';
import 'register.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/providers/user_model_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background
          const BackgroundWidget(),
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                // Logo
                const LogoWidget(
                  height: 300,
                  width: 300,
                  logoText: "",
                  alignment: Alignment.center,
                ),
                // Login Form
                Center(
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  dynamic onLoginButtonPressed() async {
    final AuthService _auth = AuthService();
    String email = emailController.text;
    String password = passwordController.text;

    dynamic result = await _auth.signInWithEmailAndPassword(email, password);

    if (result == null || result.uid == null) {
      setState(() {
        errorMessage = 'Login failed'; // Update error message
      });
      return; // Exit the function if login fails
    }

    // Navigate or perform other actions on successful login
    setState(() {
      errorMessage = null; // Clear error message
    });

    UserModel? userModel = await UserModel.fromEmail(email);

    if (userModel != null) {
      // User found, proceed with your logic
      ref.read(userModelProvider.notifier).state = userModel;
      print("UserModel updated successfully");
    } else {
      // Handle the case where no user is found
      print("No user found for this email");
    }
    String? pEmail = ref.read(userModelProvider).email;
    String? pPassword = ref.read(userModelProvider).password;
    String? pUsername = ref.read(userModelProvider).username;
    String? pDocID = ref.read(userModelProvider).userDocID;
    String? avatarURL = ref.read(userModelProvider).avatarURL;

    print("Email: ${pEmail}");
    print("Password: ${pPassword}");
    print("Username: ${pUsername}");
    print("Document ID: ${pDocID}");
    print("Avatar URL: ${avatarURL}");
    print(result.uid);

    return result;
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Log In',
            style: GoogleFonts.quicksand(
              fontSize: 32,
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 20),
        Form(
          child: Column(
            children: [
              const SizedBox(height: 20),
              EmailField(controller: emailController),
              const SizedBox(height: 20),
              PasswordField(controller: passwordController),
              const SizedBox(height: 20),
              if (errorMessage != null)
                Column(
                  children: [
                    Text(
                      errorMessage!,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontFamily: 'Quicksand-SemiBold'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ), // Conditionally display error message
              LoginButton(buttonPressed: onLoginButtonPressed),
              const SizedBox(height: 30),
              const SizedBox(height: 30),
              TextField(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class TextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        style: const TextStyle(
            fontFamily: 'Quicksand-SemiBold',
            fontSize: 16,
            color: AppColors.primaryTextColor),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              child: Text(
                'Sign up',
                style: const TextStyle(
                    fontFamily: 'Quicksand-SemiBold',
                    fontSize: 16,
                    color: Color.fromARGB(255, 18, 101, 209)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Label
          const Text(
            '   EMAIL',
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontWeight: FontWeight.w800,
              fontSize: 12.0,
              letterSpacing: 1.5,
              color: AppColors.primaryTextColor,
            ),
          ),
          const SizedBox(height: 5),
          // Email Text Field
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'name@email.com',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('assets/page-1/images/custom/email_icon.png',
                    width: 24, height: 24),
              ),
              filled: true,
              fillColor: Colors.white,
              // Rounded edges
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onChanged: (String value) {
              // Handle changes
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username Label
          const Text(
            '   PASSWORD',
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontWeight: FontWeight.w800,
              fontSize: 12.0,
              letterSpacing: 1.5,
              color: AppColors.primaryTextColor,
            ),
          ),
          const SizedBox(height: 5),
          // Username Text Field
          TextFormField(
            controller: controller,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: '********',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('assets/page-1/images/custom/lock_icon.png',
                    width: 24, height: 24),
              ),
              filled: true,
              fillColor: Colors.white,
              // Rounded edges
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onChanged: (String value) {
              // Handle changes
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function buttonPressed;

  const LoginButton({super.key, required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 300,
      height: 52,
      onPressed: () async {
        dynamic result = await buttonPressed();
        if (result != null && result.uid != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomNavigationBar(),
              ));
        }
      },
      color: AppColors.buttonColor1,
      textColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: const BorderSide(color: Colors.black, width: 0.3),
      ),
      child: const Text(
        'LOG IN',
        style: TextStyle(
          fontFamily: 'Mulish-Bold',
          fontSize: 15,
          letterSpacing: 1.25,
        ),
      ),
    );
  }
}