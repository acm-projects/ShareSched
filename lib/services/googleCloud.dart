import 'dart:core';
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';

FirebaseFunctions mFunctions = FirebaseFunctions.instance;

Future<dynamic> annotateImage(String requestJson) {
  return mFunctions
      .httpsCallable('annotateImage')
      .call(requestJson)
      .then((HttpsCallableResult result) {
        return result.data;
      });

      
}


Future<dynamic> callAnnotateImageFunction(String requestJson) async {
  final result = await mFunctions.httpsCallable('annotateImage').call(requestJson);
  // This continuation runs on either success or failure.
  // If the task has failed, it will throw an Exception which will be propagated down.

  final data = result.data;
  return json.decode(json.encode(data));
}




Map<String, dynamic> createCloudVisionRequest(String base64encoded) {
  Map<String, dynamic> request = {
    'image': {'content': base64encoded},
    'features': [
      {'type': 'TEXT_DETECTION'},
      // Alternatively, for DOCUMENT_TEXT_DETECTION:
      // {'type': 'DOCUMENT_TEXT_DETECTION'}
    ],
  };
  return request;
}

// void main() {
//   // Example usage:
//   String base64encoded = 'your_base64_encoded_image_data';
//   Map<String, dynamic> visionRequest = createCloudVisionRequest(base64encoded);
//   print(jsonEncode(visionRequest));
// }
