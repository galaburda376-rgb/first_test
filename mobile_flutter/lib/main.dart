import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'state/voice_notes_store.dart';

void main() {
  runApp(const SmartRecorderApp());
}

class SmartRecorderApp extends StatefulWidget {
  const SmartRecorderApp({super.key});

  @override
  State<SmartRecorderApp> createState() => _SmartRecorderAppState();
}

class _SmartRecorderAppState extends State<SmartRecorderApp> {
  final VoiceNotesStore _store = VoiceNotesStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Recorder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(store: _store),
    );
  }
}
