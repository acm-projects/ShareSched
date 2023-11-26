import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/user_model_provider.dart';
import 'custom_widgets.dart';

class FriendScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends ConsumerState<FriendScreen> {
  bool addFriendSelected = false;

  void toggleAddFriend(bool value) {
    setState(() {
      addFriendSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundWidget2(),
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                FriendWidget(toggleAddFriend: toggleAddFriend),
                addFriendSelected
                    ? Center(child: SearchForm())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Text('Friends',
                              style: GoogleFonts.quicksand(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends ConsumerState<SearchForm> {
  TextEditingController friendName = TextEditingController();

  Future<void> onSearchButtonPressed() async {
    // add search db logic here
    String username = friendName.text;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
    .collection("Users")
    .where("Username", isEqualTo: friendName.text)
    .limit(1)
    .get();

    String friendDocID = snapshot.docs.first.id;
    List<String> newFriends = [friendDocID];
    

    addFriendsToUser(newFriends);
  }

  void addFriendsToUser(List<String> newFriends) async {
  try {
    final email = ref.read(userModelProvider).email;
    QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance
    .collection("Users")
    .where("Email", isEqualTo: email)
    .limit(1)
    .get();
    String userDocID = user.docs.first.id;
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userDocID);
    
    DocumentSnapshot<Map<String, dynamic>> userDocSnapshot = await userDocRef.get() as DocumentSnapshot<Map<String, dynamic>>;
    List<dynamic> currentFriends = userDocSnapshot.data()?['Friends'] ?? <String>[];//get current friends


    List mergedFriends = currentFriends+newFriends;//merged friends lists
    await userDocRef.set({'Friends': mergedFriends}, SetOptions(merge: true));//update friends list in DB


  } catch (e) {
    print('Error adding friends: $e');
    // Handle error as needed
  }
}

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 70,
          child: Text('Add Friends',
              style: GoogleFonts.quicksand(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        const SizedBox(height: 500),
        Form(
          child: Column(
            children: [
              const SizedBox(height: 20),
              AddFriendsField(controller: friendName),
              const SizedBox(height: 70),
              SearchButton(
                buttonPressed: onSearchButtonPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddFriendsField extends StatelessWidget {
  TextEditingController controller;

  AddFriendsField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username Label
          const Text(
            '   SEARCH',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
              letterSpacing: 1.5,
              height: 1.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          // Username Text Field
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Add friends with their username!',
              prefixIcon: const Icon(Icons.search),
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
                return 'Please enter a username';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  final Function buttonPressed;

  const SearchButton({super.key, required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 300,
        height: 50,
        onPressed: () {
          buttonPressed();
        },
        color: const Color.fromRGBO(53, 51, 205, 1),
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(color: Colors.black, width: 0.3),
        ),
        child: const Text(
          'SEARCH',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: 1.25,
          ),
        ));
  }
}

class FriendWidget extends StatefulWidget {
  final Function toggleAddFriend;
  FriendWidget({required this.toggleAddFriend});

  @override
  _FriendWidgetState createState() => _FriendWidgetState();
}

class _FriendWidgetState extends State<FriendWidget> {
  @override
  bool viewFriendSelected = true;
  bool addFriendSelected = false;

  void _selectViewFriend() {
    setState(() {
      viewFriendSelected = true;
      addFriendSelected = false;
      widget.toggleAddFriend(false);
    });
  }

  void _selectViewAddFriend() {
    setState(() {
      viewFriendSelected = false;
      addFriendSelected = true;
      widget.toggleAddFriend(true);
    });
  }

  Widget build(BuildContext build) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectViewFriend();
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(
                  color: Color.fromARGB(99, 255, 255, 255), width: 2.0)),
          child: Icon(
            Icons.person,
            size: 30,
            color: (viewFriendSelected
                ? Colors.white
                : const Color.fromARGB(255, 165, 154, 154)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectViewAddFriend();
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchForm(),
                ],
              );
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: const BorderSide(
                color: Color.fromARGB(99, 255, 255, 255), width: 2.0),
          ),
          child: Icon(
            Icons.group_add,
            size: 30,
            color: (addFriendSelected
                ? Colors.white
                : const Color.fromARGB(255, 165, 154, 154)),
          ),
        ),
      ],
    );
  }
}

class FriendIcon extends StatelessWidget {
  FriendIcon({super.key});

  @override
  Widget build(BuildContext build) {
    return const Icon(
      Icons.group_add,
      size: 100,
      color: Colors.white,
    );
  }
}
