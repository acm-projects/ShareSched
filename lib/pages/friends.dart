import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/friend_provider.dart';
import 'package:myapp/colors/app_colors.dart';

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
                    width: 50,
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
      minWidth: 50,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: AnimatedContainer(
        width: 100,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(width: 3.0, color: Colors.white))
              : Border.all(color: Colors.transparent),
        ),
        child: const Icon(
          Icons.group,
          color: Colors.white,
          size: 30,
        ),
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
      minWidth: 50,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: AnimatedContainer(
        width: 100,
        duration: const Duration(milliseconds: 200),
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

class ViewFriendsForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsList = ref.read(friendsProvider.notifier).state;
    return Center(
      child: Container(
        height: 600,
        width: 300, // Slightly increased width for a better layout
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.white70,
          ),
          itemCount: friendsList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                dense: true,
                onTap: () {},
                leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        NetworkImage(friendsList[index].avatarURL!)),
                title: Text(
                  friendsList[index].username,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Quicksand'),
                ),
                trailing: const Icon(Icons.view_headline_rounded,
                    size: 30, color: Colors.white),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                tileColor: Colors
                    .transparent, // Tile color made transparent to show gradient
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      ),
    );
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
