import 'package:flutter/material.dart';

import '../models/voice_note.dart';
import '../state/voice_notes_store.dart';
import 'record_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.store});

  final VoiceNotesStore store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Умный диктофон')),
      body: AnimatedBuilder(
        animation: store,
        builder: (context, _) {
          if (store.notes.isEmpty) {
            return const Center(
              child: Text('Записей пока нет. Нажми кнопку +, чтобы создать первую.'),
            );
          }

          return ListView.separated(
            itemCount: store.notes.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final note = store.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(
                  'Создано: ${note.createdAt.day}.${note.createdAt.month}.${note.createdAt.year} '
                  '${note.createdAt.hour.toString().padLeft(2, '0')}:${note.createdAt.minute.toString().padLeft(2, '0')}\n'
                  'Длительность: ${_formatDuration(note.duration)} · Статус: ${_statusLabel(note.status)}',
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => RecordScreen(store: store)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '00:00';
    }
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _statusLabel(VoiceNoteStatus status) {
    switch (status) {
      case VoiceNoteStatus.draft:
        return 'Черновик';
      case VoiceNoteStatus.processing:
        return 'Обрабатывается';
      case VoiceNoteStatus.ready:
        return 'Готово';
      case VoiceNoteStatus.error:
        return 'Ошибка';
    }
  }
}
