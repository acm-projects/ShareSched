import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_widgets.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/models/friend.dart';

class FriendModal extends StatefulWidget {
  final Offset? position;
  final Friend? friend;

  const FriendModal({required this.friend, required this.position});
  _FriendModalState createState() => _FriendModalState();
}

class _FriendModalState extends State<FriendModal> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: widget.position?.dx,
          top: widget.position?.dy,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                letterSpacing: 1.5,
                height: 1.0,
                color: Colors.white,
              ),
              child: Text(widget.friend?.name ?? "No Friend Info"),
            ),
          ),
        ),
      ],
    );
  }
}

class FriendWidget extends StatefulWidget {
  _FriendWidgetState createState() => _FriendWidgetState();
}

class _FriendWidgetState extends State<FriendWidget> {
  Offset? _tapPosition;
  List<Friend> friendsList = [
    Friend(
        id: '1',
        name: 'xor',
        status: 'online',
        avatarURL:
            'https://images-ext-2.discordapp.net/external/YsCYJaiMfN5jYAiXQCki5mhOHlcvTwb5qwpnlUf6-fE/%3Fsize%3D128/https/cdn.discordapp.com/avatars/94487068729679872/9917684b0587481351ef72462ca57175.png?width=160&height=160'),
    Friend(
        id: '3',
        name: 'Josh',
        status: 'offline',
        avatarURL: 'url_to_image_of_'),
  ];

  Future<List<Friend>> getFriendsFromDatabase() async {
    // database logic to retrieve the list of friends.
    List<Friend> friendsList = [];
    return friendsList;
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendsList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
                title: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 2),
              child: GestureDetector(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 80),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: () {
                    final RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    final Offset localPosition =
                        renderBox.localToGlobal(Offset.zero);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FriendModal(
                            friend: friendsList[index],
                            position: localPosition,
                          );
                        });
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(friendsList[index].avatarURL),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(friendsList[index].name,
                          style: const TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTextColor,
                          )),
                      Spacer(),
                      // Status indicator
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: friendsList[index].status == 'online'
                              ? Colors.green
                              : friendsList[index].status == 'dnd'
                                  ? Colors.red
                                  : Color.fromARGB(255, 149, 149, 149),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            // Add a divider
            Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ],
        );
      },
    );
  }
}

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FriendNavigationButton(toggleAddFriend: toggleAddFriend),
                addFriendSelected
                    ? Center(child: SearchForm())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            const SizedBox(height: 20),
                            Text('Friends',
                                style: GoogleFonts.quicksand(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 30),
                            Container(
                              alignment: Alignment.center,
                              height: 800,
                              width: 400,
                              child: FriendWidget(),
                            )
                          ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  TextEditingController friendName = TextEditingController();

  void onSearchButtonPressed() {
    // add search db logic here
    String username = friendName.text;
    print("Username: $username");
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
              const SizedBox(height: 10),
              AddFriendsField(controller: friendName),
              const SizedBox(height: 60),
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
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 12.0,
              letterSpacing: 1.5,
              height: 1.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 7),
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
              fontFamily: 'Mulish-Bold',
              fontWeight: FontWeight.w800,
              fontSize: 15,
              letterSpacing: 1.25,
              height: 1.0,
              color: AppColors.secondaryTextColor),
        ));
  }
}

class FriendNavigationButton extends StatefulWidget {
  final Function toggleAddFriend;
  const FriendNavigationButton({required this.toggleAddFriend});

  @override
  _FriendNavigationButtonState createState() => _FriendNavigationButtonState();
}

class _FriendNavigationButtonState extends State<FriendNavigationButton> {
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
            Icons.group,
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
  const FriendIcon({super.key});

  @override
  Widget build(BuildContext build) {
    return const Icon(
      Icons.group_add,
      size: 100,
      color: Colors.white,
    );
  }
}
