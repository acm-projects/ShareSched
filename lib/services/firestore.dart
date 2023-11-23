//function to upload information to database(filling in the fields inside documents)

// const SCHEDULES_COLLECTIONS ='Schdeules';

// export function addSchedule(uid, imageBucket){
//    addDoc(collection(db, SCHEDULES_COLLECTIONS), {uid, imageBucket});
// }


//import the necessary cloud_firestore package.
//The collection name is defined as SCHEDULES_COLLECTION.
//The function addSchedule accepts uid and imageBucket as arguments.
// create an instance of FirebaseFirestore using FirebaseFirestore.instance.
//use await to add a new document to the specified collection with the provided data.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const SCHEDULES_COLLECTION = 'Schedules';  

//add a schedule

Future<void> addSchedule(String uid, String imageBucket) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  await db.collection(SCHEDULES_COLLECTION).add({
    'uid': uid,
    'imageBucket': imageBucket,
  });
}

//get a schedule
//The function getSchedules accepts a uid (String) and isConfirmed (bool) as arguments.
// define the SCHEDULE_COLLECTION constant.
// create a query to fetch schedules based on the uid and isConfirmed conditions.
// use await to retrieve the query snapshot.
// iterate through the snapshot to extract schedule data and fetch the image URL from Firebase Storage.
//The result is a list of maps containing schedule data, including the image URL




const SCHEDULE_COLLECTION = 'Schedules';

Future<List<Map<String, dynamic>>?> getSchedules(String uid, bool isConfirmed) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final Query<Map<String, dynamic>> schedulesQuery = db
      .collection(SCHEDULE_COLLECTION)
      .where('uid', isEqualTo: uid)
      .where('isConfirmed', isEqualTo: isConfirmed);

  final QuerySnapshot<Map<String, dynamic>> snapshot = await schedulesQuery.get();

  final List<Map<String, dynamic>> allSchedules = [];

  for (final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot in snapshot.docs) {
    final Map<String, dynamic> schedule = documentSnapshot.data() as Map<String, dynamic>;

    final String imageBucket = schedule['imageBucket'];

    final String imageUrl = await FirebaseStorage.instance.ref(imageBucket).getDownloadURL();

    allSchedules.add({
      ...schedule,
      'id': documentSnapshot.id,
      'imageUrl': imageUrl,
      'imageBucket': imageBucket,
    });
  }

  return allSchedules;
}



