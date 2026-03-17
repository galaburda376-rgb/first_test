import 'package:flutter/foundation.dart';

import '../models/voice_note.dart';

class VoiceNotesStore extends ChangeNotifier {
  final List<VoiceNote> _notes = [];

  List<VoiceNote> get notes => List.unmodifiable(_notes);

  void addNote({
    required String title,
    required Duration duration,
    String? transcript,
  }) {
    final now = DateTime.now();
    _notes.insert(
      0,
      VoiceNote(
        id: now.microsecondsSinceEpoch.toString(),
        title: title,
        createdAt: now,
        duration: duration,
        transcript: transcript,
        status: VoiceNoteStatus.processing,
      ),
    );
    notifyListeners();
  }
}
