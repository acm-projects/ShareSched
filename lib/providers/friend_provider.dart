import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/providers/user_model_provider.dart';

final friendsListStreamProvider = StreamProvider<List<UserModel>>((ref) async* {
  final currentUserDocID = ref.watch(userModelProvider).userDocID;
  final snapshotStream = FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUserDocID)
      .snapshots();

  await for (final snapshot in snapshotStream) {
    if (snapshot.exists && snapshot.data() != null) {
      List<String> friendDocIDs =
          List<String>.from(snapshot.data()!['Friends'] ?? []);
      List<UserModel>? friendsList =
          await UserModel.getFriendsModels(friendDocIDs);
      yield friendsList!;
    } else {
      yield []; // Yield an empty list if no friends or user document doesn't exist
    }
  }
});
