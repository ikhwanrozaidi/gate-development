import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'shared/services/storage/storage.dart';

void main() async {
  // Ensure that Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Now initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final container = ProviderContainer();
  final storageService = container.read(storageServiceProvider);
  await storageService.initStorage();

  // Run the app
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: App(),
      ),
    ),
  );
}
