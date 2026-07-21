import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:personal_planner/firebase_options.dart';

Future<void> runInitialSetup() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } on FirebaseException catch (e) {
      // On hot restart the native Firestore client from the previous run is
      // still alive, so persistence cannot be cleared. Ignore only that case.
      if (e.code != 'failed-precondition') rethrow;
    }
  }
}
