//function for uploading an image to firebase storage
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child(''); // Create a reference to the root of the storage bucket
    String fileName = 'sched.jpg'; // Replace with your desired file name
    Reference fileRef = storageRef.child('/$fileName'); // Create a reference to the file in Cloud Storage

    // Create metadata for the file
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

    // Upload the image and metadata to the specified reference
    await fileRef.putFile(imageFile, metadata);

    // Get the download URL for the uploaded image
    String downloadURL = await fileRef.getDownloadURL();
    
    return downloadURL; // Return the download URL of the uploaded image
  } catch (e) {
    print('Error uploading image to Firebase Storage: $e');
    return null; // Return null in case of an error
  }
}























