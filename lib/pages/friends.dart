import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/navigation/navigation_bar.dart';
import 'custom_widgets.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/models/friend.dart';

final friendIndexProvider = StateProvider((ref) => 0);

class FriendScreen extends ConsumerWidget {
  @override
  const FriendScreen({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(friendIndexProvider);
    final index = ref.read(friendIndexProvider.notifier).state;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 40,
              child: Row(
                children: [
                  ViewFriendsButton(),
                  const SizedBox(
                    width: 100,
                  ),
                  AddFriendsButton(),
                ],
              )),
          Positioned(
              top: 150,
              child: (index == 0) ? (ViewFriendsForm()) : (AddFriendsForm())),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

class ViewFriendsButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(friendIndexProvider) == 0;
    return MaterialButton(
      onPressed: () {
        ref.read(friendIndexProvider.notifier).state = 0;
      },
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: AnimatedContainer(
        width: 400,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(width: 3.0, color: Colors.white))
              : Border.all(color: Colors.transparent),
        ),
        child: const Icon(Icons.group, color: Colors.white),
      ),
    );
  }
}

class AddFriendsButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(friendIndexProvider) == 1;
    return MaterialButton(
      onPressed: () {
        ref.read(friendIndexProvider.notifier).state = 1;
      },
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: AnimatedContainer(
        width: 400,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(width: 3.0, color: Colors.white))
              : Border.all(color: Colors.transparent),
        ),
        child: const Icon(Icons.group_add, color: Colors.white),
      ),
    );
  }
}

class ViewFriendsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Hello', style: TextStyle(color: Colors.white)));
  }
}

class AddFriendsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Not hello', style: TextStyle(color: Colors.white)));
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  Widget build(BuildContext build) {
    return Text('Friends',
        style: GoogleFonts.quicksand(
          fontSize: 32,
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.bold,
        ));
  }
}
