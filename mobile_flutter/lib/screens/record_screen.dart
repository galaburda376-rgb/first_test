import 'dart:async';

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
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = 'Встреча ${DateTime.now().day}.${DateTime.now().month}';
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _stopwatch.stop();
    _titleController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      if (_isRecording) {
        _isRecording = false;
        _stopwatch.stop();
        _ticker?.cancel();
      } else {
        _isRecording = true;
        if (_stopwatch.elapsed == Duration.zero) {
          _stopwatch.reset();
        }
        _stopwatch.start();
        _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
          if (mounted) {
            setState(() {});
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final canSave = !_isRecording && _stopwatch.elapsed > Duration.zero;

    return Scaffold(
      appBar: AppBar(title: const Text('Новая запись')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название записи',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _isRecording
                  ? 'Идет запись...'
                  : 'Нажми старт, чтобы начать запись.',
            ),
            const SizedBox(height: 12),
            Text(
              _formatDuration(_stopwatch.elapsed),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _toggleRecording,
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              label: Text(_isRecording ? 'Остановить' : 'Старт'),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: canSave
                  ? () {
                      widget.store.addNote(
                        title: _titleController.text.trim().isEmpty
                            ? 'Новая запись'
                            : _titleController.text.trim(),
                        duration: _stopwatch.elapsed,
                        transcript: 'Транскрипция появится на следующем шаге.',
                      );
                      Navigator.of(context).pop();
                    }
                  : null,
              child: const Text('Сохранить запись'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
