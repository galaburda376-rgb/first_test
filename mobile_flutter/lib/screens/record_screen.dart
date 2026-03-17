import 'package:flutter/material.dart';

import '../state/voice_notes_store.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key, required this.store});

  final VoiceNotesStore store;

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новая запись')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _isRecording
                  ? 'Идет запись... (заглушка для первого этапа)'
                  : 'Нажми старт, чтобы начать запись.',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                setState(() {
                  _isRecording = !_isRecording;
                });
              },
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              label: Text(_isRecording ? 'Остановить' : 'Старт'),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                widget.store.addDemoNote();
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить демо-запись'),
            ),
          ],
        ),
      ),
    );
  }
}
