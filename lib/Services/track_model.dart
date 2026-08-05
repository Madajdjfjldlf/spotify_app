class TrackModel {
  final int id;
  final String title;
  final String preview; // رابط معاينة الأغنية (صوت)
  final String artistName;
  final String coverImage;

  TrackModel({
    required this.id,
    required this.title,
    required this.preview,
    required this.artistName,
    required this.coverImage,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      preview: json['preview'] ?? '',
      artistName: json['artist']?['name'] ?? 'Unknown',
      coverImage: json['album']?['cover_medium'] ?? '',
    );
  }
}
