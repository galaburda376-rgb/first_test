class VoiceNote {
  VoiceNote({
    required this.id,
    required this.title,
    required this.createdAt,
    this.duration,
    this.transcript,
    this.locationLabel,
  });

  final String id;
  final String title;
  final DateTime createdAt;
  final Duration? duration;
  final String? transcript;
  final String? locationLabel;
}
