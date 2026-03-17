import 'package:flutter/foundation.dart';

import '../models/voice_note.dart';

class VoiceNotesStore extends ChangeNotifier {
  final List<VoiceNote> _notes = [];

  List<VoiceNote> get notes => List.unmodifiable(_notes);

  void addDemoNote() {
    final now = DateTime.now();
    _notes.insert(
      0,
      VoiceNote(
        id: now.microsecondsSinceEpoch.toString(),
        title: 'Новая запись ${_notes.length + 1}',
        createdAt: now,
        duration: const Duration(minutes: 1, seconds: 20),
        transcript: 'Здесь появится транскрипция в следующем спринте.',
      ),
    );
    notifyListeners();
  }
}
