import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/friend_provider.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/models/schedule.dart';
import 'package:time_planner/time_planner.dart';

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
      child: SizedBox(
        height: 600,
        width: 300,
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
                onTap: () {
                  final tappedUser = friendsList[index];
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MiniSchedule(
                          username: tappedUser.username,
                          schedule: tappedUser.schedule);
                    },
                  );
                },
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
                tileColor: Colors.transparent,
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
  TextEditingController nameController = TextEditingController();

  // Future<bool> sendFriendRequest(String name) {
  //   // send friend request logic here
  // }
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 600,
      width: 300,
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        TextField(
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor:
                    Colors.lightBlue[50], // Background color of the TextField
                hintText: 'Enter name',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ))),
        SizedBox(height: 90),
        SearchButton(buttonPressed: () {}),
      ]),
    ));
  }
}

class SearchButton extends StatelessWidget {
  final Function buttonPressed;

  const SearchButton({super.key, required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 300,
      height: 52,
      onPressed: () async {
        dynamic result = await buttonPressed();
      },
      color: AppColors.buttonColor1,
      textColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: Colors.black, width: 0.3),
      ),
      child: const Text(
        'SEARCH',
        style: TextStyle(
          fontFamily: 'Mulish-Bold',
          fontSize: 15,
          letterSpacing: 1.25,
        ),
      ),
    );
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

class MiniSchedule extends StatelessWidget {
  // To instantiate this MiniSchedule class, we'll need to retrieve a User object from the db
  String? username;
  final Schedule schedule;

  MiniSchedule({Key? key, this.username, required this.schedule})
      : super(key: key);

  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${username!}\'s schedule',
                style: const TextStyle(
                    color: AppColors.primaryTextColor,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w900,
                    fontSize: 16)),
          ),
          SizedBox(
            height: 5,
          ),
          ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height *
                    0.7, // 70% of screen height
                maxWidth: MediaQuery.of(context).size.width *
                    0.9, // 90% of screen width
              ),
              child: SingleChildScrollView(
                child: Container(
                    height: 800,
                    width: 450,
                    child: TimePlanner(
                      startHour: 8,
                      endHour: 22,
                      headers: const [
                        TimePlannerTitle(
                            title: 'Monday',
                            titleStyle: TextStyle(
                                color: AppColors.primaryTextColor,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700)),
                        TimePlannerTitle(
                            title: 'Tuesday',
                            titleStyle: TextStyle(
                                color: AppColors.primaryTextColor,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700)),
                        TimePlannerTitle(
                            title: 'Wednesday',
                            titleStyle: TextStyle(
                                color: AppColors.primaryTextColor,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700)),
                        TimePlannerTitle(
                            title: 'Thursday',
                            titleStyle: TextStyle(
                                color: AppColors.primaryTextColor,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700)),
                        TimePlannerTitle(
                          title: 'Friday',
                          titleStyle: TextStyle(
                              color: AppColors.primaryTextColor,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                      style: TimePlannerStyle(
                          horizontalTaskPadding: BorderSide.strokeAlignCenter,
                          backgroundColor: Colors.black,
                          dividerColor: const Color.fromRGBO(53, 51, 205, 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0))),
                      use24HourFormat: false,
                    )),
              )),
        ]),
      ),
    );
  }
}
