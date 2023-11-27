import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/pages/custom_widgets.dart';
import 'package:myapp/providers/user_model_provider.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({Key? key}) : super(key: key);

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(userModelProvider).email;
    final avatarURL = ref.read(userModelProvider).avatarURL;
    return Scaffold(
      appBar: CustomAppBar(
        isOnProfilePage: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(4), // The size of the border
                decoration: const BoxDecoration(
                  color: Colors.white, // Border color
                  shape: BoxShape.circle, // Circular shape
                ),
                child: const CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              _buildTextFormField(
                'Username',
                'Enter your username',
                _usernameFocusNode,
              ),
              const SizedBox(height: 30),
              _buildTextFormField(
                'Email',
                'Enter your email',
                _emailFocusNode,
              ),
              const SizedBox(height: 30),
              _buildTextFormField(
                'Password',
                'Enter your password',
                _passwordFocusNode,
                isPassword: true,
              ),
              const SizedBox(height: 60),
              SearchButton(buttonPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      String label, String hintText, FocusNode focusNode,
      {bool isPassword = false}) {
    return TextFormField(
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        fillColor: Colors.black,
        filled: true,
        border: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(borderColor: Colors.blue),
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white60),
      ),
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
    );
  }

  OutlineInputBorder _outlineInputBorder({Color borderColor = Colors.white}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: borderColor, width: 2.0),
    );
  }
}

class SearchButton extends StatelessWidget {
  final Function buttonPressed;

  const SearchButton({Key? key, required this.buttonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 300,
      height: 52,
      onPressed: () {},
      color: AppColors.buttonColor1,
      textColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: const BorderSide(color: Colors.black, width: 0.3),
      ),
      child: const Text(
        'Update Profile',
        style: TextStyle(
          fontFamily: 'Mulish-Bold',
          fontSize: 15,
          letterSpacing: 1.25,
        ),
      ),
    );
  }
}
