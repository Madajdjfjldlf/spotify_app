class Track {
  final String title;
  final String artist;
  final String duration;
  final String image;
  final String rank;
  final String? previewUrl;

  Track({
    required this.title,
    required this.artist,
    required this.duration,
    required this.image,
    required this.rank,
    this.previewUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json, int index) {
    final durationRaw = json['duration'] ?? 0;
    final minutes = (durationRaw as int) ~/ 60;
    final seconds = durationRaw % 60;

    return Track(
      title: (json['title'] ?? '').toString(),
      artist: (json['artist']?['name'] ?? '').toString(),
      duration: '$minutes:${seconds.toString().padLeft(2, '0')}',
      image: (json['album']?['cover_medium'] ?? '').toString(),
      rank: '${index + 1}',
      previewUrl: json['preview']?.toString(),
    );
  }
}
