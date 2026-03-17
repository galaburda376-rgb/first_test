import 'package:flutter/material.dart';

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
                  '${note.createdAt.hour.toString().padLeft(2, '0')}:${note.createdAt.minute.toString().padLeft(2, '0')}',
                ),
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
}
