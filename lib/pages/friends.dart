import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/pages/chat.dart';
import 'package:myapp/pages/compare.dart';
import 'package:myapp/providers/friend_provider.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/providers/user_model_provider.dart';
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
              child:
                  (index == 0) ? (ViewFriendsForm()) : (AddFriendsFormState())),
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
  void _showPopupMenu(BuildContext context, Offset position, UserModel friend) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    showMenu(
      color: Colors.black,
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40), // smaller rectangle, the touch area
        Offset.zero & overlay.size, // Bigger rectangle, the entire screen
      ),
      items: [
        PopupMenuItem(
          value: "option1",
          child: Container(
            width: 250,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "View Schedule",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  color: AppColors.primaryTextColor),
            ),
          ),
        ),
        PopupMenuItem(
          value: "option2",
          child: Container(
            width: 250,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              textAlign: TextAlign.center,
              "Compare Schedules",
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  color: AppColors.primaryTextColor),
            ),
          ),
        ),
        PopupMenuItem(
          value: "option3",
          child: Container(
            width: 250,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              textAlign: TextAlign.center,
              "Chat",
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  color: AppColors.primaryTextColor),
            ),
          ),
        ),
      ],
    ).then((value) {
      switch (value) {
        case "option1":
          showDialog(
            context: context,
            builder: (context) {
              friend.schedule!.printCourses();
              return MiniSchedule(
                username: friend.username,
                schedule: friend.schedule!,
              );
            },
          );
          break;
        case "option2":
          showDialog(
              context: context,
              builder: (context) => ComparisonScreen(
                    friend: friend,
                  ));
          break;
        case "option3":
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          friend: friend,
                        )));
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the friendsListStreamProvider for real-time updates
    AsyncValue<List<UserModel>> friendsListAsyncValue =
        ref.watch(friendsListStreamProvider);

    return Center(
      child: SizedBox(
        height: 600,
        width: 300,
        child: friendsListAsyncValue.when(
          data: (List<UserModel> friendsList) {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white70),
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTapDown: (details) {
                    _showPopupMenu(
                        context, details.globalPosition, friendsList[index]);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(friendsList[index].avatarURL!),
                      ),
                      title: Text(
                        friendsList[index].username!,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Quicksand'),
                      ),
                      trailing: const Icon(Icons.view_headline_rounded,
                          size: 30, color: Colors.white),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      tileColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}

class AddFriendsFormState extends ConsumerStatefulWidget {
  _AddFriendsForm createState() => _AddFriendsForm();
}

class _AddFriendsForm extends ConsumerState<AddFriendsFormState> {
  TextEditingController nameController = TextEditingController();
  bool friendRequestSuccessful = false;
  String? errorMessage;
  String successMessage = "Friend request sent successfully";
  Future<bool> onSearchButtonPressed() async {
    try {
      // Add search db logic here

      String userDocID = ref.read(userModelProvider).userDocID!;
      String friendName = nameController.text;

      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("Users")
          .where("Username", isEqualTo: friendName)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No user found with this username.");
        return false;
      }

      String friendDocID = snapshot.docs.first.id;

      print("Friend ID: ${friendDocID}");
      List<String> newFriends = [friendDocID];
      return await addFriendsToUser(newFriends);
    } catch (e) {
      print('Error searching for user: $e');
      return false;
    }
  }

  Future<bool> addFriendsToUser(List<String> newFriends) async {
    try {
      final email = ref.read(userModelProvider).email;
      String userDocID = ref.read(userModelProvider).userDocID!;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(userDocID);

      DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
          await userDocRef.get() as DocumentSnapshot<Map<String, dynamic>>;
      List<dynamic> currentFriends = userDocSnapshot.data()?['Friends'] ??
          <String>[]; //get current friends

      List mergedFriends = currentFriends + newFriends; //merged friends lists
      await userDocRef.set({'Friends': mergedFriends},
          SetOptions(merge: true)); //update friends list in DB

      print('Friends added successfully.');
      return true;
    } catch (e) {
      print('Error adding friends: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 600,
      width: 300,
      child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        const Text('Add Friends',
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontWeight: FontWeight.w800,
              fontSize: 12.0,
              letterSpacing: 1.5,
              color: AppColors.primaryTextColor,
            )),
        const SizedBox(
          height: 20,
        ),
        TextField(
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
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
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ))),
        const SizedBox(height: 60),
        SearchButton(buttonPressed: () async {
          bool success = await onSearchButtonPressed();
          setState(() {
            friendRequestSuccessful = success;
            if (friendRequestSuccessful) {
              errorMessage = null; // Clear any previous error message
            } else {
              errorMessage = "Friend request failed";
            }
          });
        }),
        const SizedBox(height: 40),
        if (friendRequestSuccessful)
          Text(
            successMessage,
            style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontFamily: 'Quicksand-SemiBold'),
          )
        else if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontFamily: 'Quicksand-SemiBold'),
          ),
        const SizedBox(height: 20),
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
          const SizedBox(
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
                      tasks: schedule.convertCoursesToTasks(context),
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
