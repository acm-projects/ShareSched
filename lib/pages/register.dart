import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/providers/user_model_provider.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/controllers/register_controller.dart';
import 'custom_widgets.dart';
import 'package:myapp/pages/upload_schedule.dart';
import 'login.dart';
import 'package:myapp/colors/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                  alignment: Alignment.topCenter,
                ),
                // Registration Form
                Center(
                  child: RegisterForm(),
                ),
                const SizedBox(height: 20),
                TextField(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Already have an account? ",
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
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                'Log in',
                style: TextStyle(
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

class RegisterForm extends ConsumerStatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  dynamic onSignUpButtonPressed() async {
    final AuthService _auth = AuthService();
    // save registration details to database here?
    final registerRepo = Get.put(RegisterController());

    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    if (email != "" && username != "" && password != "") {
      await registerRepo.createUser(UserModel(
          username: username,
          email: email,
          password: password,
          avatarURL: '',
          schedule: Schedule(id: '1', courses: [])));
    }

    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
    if (result == null || result.uid == null) {
      setState(() {
        errorMessage = 'Registration failed'; // Update error message
      });
    } else {
      // Navigate or perform other actions on successful login
      setState(() {
        errorMessage = null; // Clear error message
      });
    }

    ref.read(userModelProvider.notifier).state = UserModel(
        email: email,
        password: password,
        schedule: Schedule(id: '1', courses: []),
        username: '',
        avatarURL: '');

    print("Email: $email");
    print("Username: $username");
    print("Password: $password");

    return result;
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Sign Up',
            style: GoogleFonts.quicksand(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 20),
        Form(
          child: Column(
            children: [
              const SizedBox(height: 20),
              EmailField(
                controller: emailController,
              ),
              const SizedBox(height: 20),
              UsernameField(controller: usernameController),
              const SizedBox(height: 20),
              PasswordField(controller: passwordController),
              const SizedBox(height: 20),
              SignUpButton(
                buttonPressed: onSignUpButtonPressed,
                errorMessage: errorMessage,
              ),
              const SizedBox(height: 20),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Quicksand-SemiBold'),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class EmailField extends StatefulWidget {
  final TextEditingController controller;

  EmailField({required this.controller, Key? key}) : super(key: key);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
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
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                return 'Please enter your email.';
              } else if (!value.contains('@') ||
                  !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                return 'Please enter a valid email.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class UsernameField extends StatefulWidget {
  final TextEditingController controller;
  UsernameField({Key? key, required this.controller}) : super(key: key);
  @override
  _UsernameFieldState createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username Label
          const Text(
            '   USERNAME',
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
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'johndoe',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('assets/page-1/images/custom/user_icon.png',
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
                return 'Please enter your username.';
              }
              final RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');

              if (!regex.hasMatch(value)) {
                return 'Username must contain only alphanumeric characters.';
              }

              if (value.length > 20 || value.length < 3) {
                return 'Username must be between 3 and 20 characters.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  TextEditingController controller;
  @override
  PasswordField({super.key, required this.controller});
  _PasswordField createState() => _PasswordField();
}

class _PasswordField extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          TextFormField(
            controller: widget.controller,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                borderSide: const BorderSide(color: Colors.white, width: 1.5),
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
                return 'Please enter your password.';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  SignUpButton({required this.buttonPressed, required this.errorMessage});
  final Function buttonPressed;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
            minWidth: 335,
            height: 52,
            onPressed: () async {
              dynamic result = await buttonPressed();
              if (result != null && result.uid != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadScreen()));
                print("Sign up successful");
              } else {
                print("Sign up unsuccessful");
              }
            },
            color: AppColors.buttonColor1,
            textColor: AppColors.secondaryTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(color: Colors.black, width: 0.3),
            ),
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                fontFamily: 'Mulish-Bold',
                fontSize: 15,
                letterSpacing: 1.25,
              ),
            )),
      ],
    );
  }
}
